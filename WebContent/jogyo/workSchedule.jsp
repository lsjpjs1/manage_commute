
<%@page import="work.Work"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.Calendar"%>

<%@ page contentType="text/html; charset=utf-8"%>

<%@ page import="work.WorkDAO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.util.Date"%>

<jsp:useBean id="work" class="work.Work" scope="page" />
<jsp:useBean id="user" class="user.User" scope="page" />
<style>
@page { size: A4 landscape }
</style>
<%

request.setCharacterEncoding("UTF-8");

response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.


String userId=null;



userId = (String) session.getAttribute("userId");//유저아이디에 해당 세션값을 넣어준다.



Calendar cal = Calendar.getInstance();

WorkDAO WorkDAO = new WorkDAO(); 

UserDAO UserDAO = new UserDAO();

String strYear = request.getParameter("year");

String strMonth = request.getParameter("month");

String userBelong = "전체";

if(request.getParameter("userBelongSelect")!=null){
	userBelong = request.getParameter("userBelongSelect");
}

int sumWorkUnitPlan = 0;
 

int year = cal.get(Calendar.YEAR);

int month = cal.get(Calendar.MONTH);

int date = cal.get(Calendar.DATE);

SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");

 

if(strYear != null)

{

  year = Integer.parseInt(strYear);

  month = Integer.parseInt(strMonth);

 

}else{

 

}

//년도/월 셋팅

cal.set(year, month, 1);

 

int startDay = cal.getMinimum(java.util.Calendar.DATE);

int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);

int start = cal.get(java.util.Calendar.DAY_OF_WEEK);

int newLine = 0;

String endDayString = Integer.toString(endDay);




//오늘 날짜 저장.

Calendar todayCal = Calendar.getInstance();

SimpleDateFormat sdf = new SimpleDateFormat("yyyMMdd");

int intToday = Integer.parseInt(sdf.format(todayCal.getTime()));

 

 

%>

<html lang="ko">

<HEAD>

		<!-- 뷰포트 -->
		
		<meta name="viewport" content="width=device-width" >
		
		<!-- 스타일시트 참조  -->
		
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">

       <TITLE>캘린더</TITLE>

       <meta http-equiv="content-type" content="text/html; charset=utf-8">

 

 

       <script type="text/javaScript" language="javascript"> 

      

       </script>

       <style TYPE="text/css">

             body {

             scrollbar-face-color: #F6F6F6;

             scrollbar-highlight-color: #bbbbbb;

             scrollbar-3dlight-color: #FFFFFF;

             scrollbar-shadow-color: #bbbbbb;

             scrollbar-darkshadow-color: #FFFFFF;

             scrollbar-track-color: #FFFFFF;

             scrollbar-arrow-color: #bbbbbb;

             margin-left:"0px"; margin-right:"0px"; margin-top:"0px"; margin-bottom:"0px";

             }

 

             td {font-size: 9pt; color:#595959;}

             th {font-size: 9pt; color:#000000;}

             select {font-size: 9pt; color:#595959;}

 

 

             .divDotText {

             overflow:hidden;

             text-overflow:ellipsis;

             }

 

 

 

       </style>

</HEAD>

<BODY>

	 <nav class="navbar navbar-default">

  <div class="navbar-header">

   <button type="button" class="navbar-toggle collapsed" 

    data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"

    aria-expaned="false">

     <span class="icon-bar"></span>

     <span class="icon-bar"></span>

     <span class="icon-bar"></span>

    </button>

    <a class="navbar-brand" href="main_jogyo.jsp">출퇴근 관리</a>

  </div> 

  <div class="collapse navbar-collapse" id="#bs-example-navbar-collapse-1">

   <ul class="nav navbar-nav">

    <li><a href="calendar.jsp">근무계획</a></li>

    <li><a href="workSchedule.jsp">근무표</a></li>
    
    <li><a href="workLog.jsp">지난 근무 내역</a></li> 
    
    <li><a href="workLogEntire.jsp">사전실 근무 내역</a></li>	
    

   </ul> 
 

    

   

  </div> 
  
  <div class="collapse navbar-collapse" id="#bs-example-navbar-collapse-1">


   <ul class="nav navbar-nav navbar-right">

	<div float: right><li><b><span style="color:blue"> <%=UserDAO.getUserName(userId) %></span></b> 님</li></div>
	<br>
   <div float: right> <li><a href="logoutAction.jsp">로그아웃</a></li></div>

   </ul>

  </div> 

 </nav>
 <a href="#" onclick="printArea()" style="color:blue">인쇄하기</a>
<div id="box">
<form name="calendarFrm" id="calendarFrm"  method="post" action="workSchedule.jsp">
<div id="belongSelect">
<select name="userBelongSelect" >
    <option value="전체" selected>--전체--</option>
    <option value="국어사전실" >국어사전실</option>
    <option value="중한사전실" >중국어사전실</option>
    <option value="전산실" >전산실</option>
  </select>
  <button type="submit">확인</button>
  </div>
  <input type="hidden" name="year" value="<%=year %>"/>
  <input type="hidden" name="month" value="<%=month %>"/>
</form>
<DIV id="content" style="width:1190px;">


<table width="100%" border="0" cellspacing="1" cellpadding="1">

<tr>

       <td align ="right">

             
       </td>

 

</tr>

</table>

<!--날짜 네비게이션  -->

<table width="100%" border="0" cellspacing="1" cellpadding="1" id="KOO" bgcolor="#F3F9D7" style="border:1px solid #CED99C">

 

<tr>

<td height="60">

 

       <table width="100%" border="0" cellspacing="0" cellpadding="0">

       <tr>

             <td height="10">

             </td>

       </tr>

      

       <tr>

             <td align="center" >

                    <a href="workSchedule.jsp?year=<%=year-1%>&amp;month=<%=month%>&amp;userBelongSelect=<%=userBelong%>" target="_self">

                           <b>&lt;&lt;</b><!-- 이전해 -->

                    </a>

                    <%if(month > 0 ){ %>

                    <a href="workSchedule.jsp?year=<%=year%>&amp;month=<%=month-1%>&amp;userBelongSelect=<%=userBelong%>" target="_self">

                           <b>&lt;</b><!-- 이전달 -->

                    </a>

                    <%} else {%>

                           <b>&lt;</b>

                    <%} %>

                    &nbsp;&nbsp;

                    <%=year%>년

                   

                    <%=month+1%>월

                    &nbsp;&nbsp;

                    <%if(month < 11 ){ %>

                    <a href="workSchedule.jsp?year=<%=year%>&amp;month=<%=month+1%>&amp;userBelongSelect=<%=userBelong%>" target="_self">

                           <!-- 다음달 --><b>&gt;</b>

                    </a>

                    <%}else{%>

                           <b>&gt;</b>

                    <%} %>

                    <a href="workSchedule.jsp?year=<%=year+1%>&amp;month=<%=month%>&amp;userBelongSelect=<%=userBelong%>" target="_self">

                           <!-- 다음해 --><b>&gt;&gt;</b>

                    </a>

             </td>

       </tr>

       </table>

 

</td>

</tr>

</table>
<div id="information" style="display:none">

<%=month+1 %> 월 근무표
<br>
부서 : <%=userBelong%>


</div>

<table border="1" cellspacing="1" cellpadding="1" bgcolor="#FFFFFF" >

<THEAD >

<TR bgcolor="#CECECE">

       <TD width='100px' >

       <DIV align="center"><font color="red">일</font></DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">월</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">화</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">수</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">목</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center">금</DIV>

       </TD>

       <TD width='100px'>

       <DIV align="center"><font color="#529dbc">토</font></DIV>

       </TD>

</TR>

</THEAD>


<TBODY>

<TR>


<%


//처음 빈공란 표시



for(int index = 1; index < start ; index++ )

{

  out.println("<TD >&nbsp;</TD>");

  newLine++;

}
       String yyyymmdd="";
 

for(int index = 1; index <= endDay; index++)

{

       String color = "";

 

       if(newLine == 0){          color = "RED";

       }else if(newLine == 6){    color = "#529dbc";

       }else{                     color = "BLACK"; };

 

       String sUseDate = Integer.toString(year); 

       sUseDate += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);

       sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);

 

       int iUseDate = Integer.parseInt(sUseDate);

       yyyymmdd = sUseDate.substring(0,6);
       
       String yyyymmddForCheck = sUseDate.substring(0,8);
       
       String workDate = sUseDate.substring(0);
      
      ArrayList<Work> workSchedule = new ArrayList<Work>();
      
      workSchedule = WorkDAO.getWorkSchedule(workDate);

      
       String backColor = "#EFEFEF";

       if(iUseDate == intToday ) {

             backColor = "#c9c9c9";

       }

       //out.println("<TD valign='top' align='left' height='92px' bgcolor='"+backColor+"' nowrap>");

       %>
	<td valign='top' align='left' width='170px' height='110px'  nowrap>	
       <font color='<%=color%>'>

             <%=index %>

       </font>

 		

       <%

      

       out.println("<BR>");

       %>
     
       
        
       <% 
       System.out.println(workDate);
       for(int i=0;i<workSchedule.size();i++){
    	   	
    	   if(UserDAO.getUserBelong(workSchedule.get(i).getUserId()).equals(userBelong) ||userBelong.equals("전체")){
    		   int workUnitPlan = workSchedule.get(i).getWorkUnitPlan();
       	    
       	    String userName = UserDAO.getUserName(workSchedule.get(i).getUserId());
       	    
       	    String workStartPlan = "";
       	    
       	    String workEndPlan = "";
       	    
       	    if(workSchedule.get(i).getWorkStartPlan()!=null){
       	    	workStartPlan = formatter.format(workSchedule.get(i).getWorkStartPlan());
       	    }else{
       	    	workStartPlan = "";
       	    }
       	    
       	    if(workSchedule.get(i).getWorkEndPlan()!=null){
       	    	workEndPlan = formatter.format(workSchedule.get(i).getWorkEndPlan());
       	    }else{
       	    	workEndPlan = "";
       	    }
       	 
       	    
       	      
       	    if(workStartPlan!=""){
       	      	workStartPlan = workStartPlan.substring(11,16);
       	  	}
       	      
       	    if(workEndPlan!=""){
       	      	workEndPlan = workEndPlan.substring(11,16);
       	    }

       	   %>
          	<% if(!workStartPlan.equals("") || !workEndPlan.equals("") || workUnitPlan!=0){
           	%><strong style="color:blue" ><%=userName %></strong>
           <%=workStartPlan %><%} %>
           <%if(!workStartPlan.equals("") || !workEndPlan.equals("")){ %>
           ~
           <%} %>
           <%=workEndPlan %>
           <%if(workUnitPlan==-1){ %>
           , 1.5 단위
           <%}else if(workUnitPlan!=0){ %>
           , <%=workUnitPlan %> 단위
           <%} %>
           <% if(!workStartPlan.equals("") || !workEndPlan.equals("") || workUnitPlan!=0){
           	%><br><%} %> 
    	   
    	    
        <%}} %>
        
       </td>
       <%

       //out.println("<BR>");

      

      

       //기능 제거 

       //out.println("</TD>");

       newLine++;

 

       if(newLine == 7)

       {

         out.println("</TR>");

         if(index <= endDay)

         {

           out.println("<TR>");

         }

         newLine=0;

       }

}


//마지막 공란 LOOP

while(newLine > 0 && newLine < 7)

{

  out.println("<TD>&nbsp;</TD>");

  newLine++;

}

%>

</TR>

 

</TBODY>

</TABLE>
</div>


</DIV>


<!-- 애니매이션 담당 JQUERY -->
<script type="text/javascript">

var initBody;

function beforePrint() {
 boxes = document.body.innerHTML;
 document.getElementById("KOO").style.display="none";
 document.getElementById("belongSelect").style.display="none";
 document.getElementById("information").style.display="block";
 document.body.innerHTML = box.innerHTML;
}
function afterPrint() { 
 document.body.innerHTML = boxes;
}
function printArea() {
 window.print();
}

window.onbeforeprint = beforePrint;
window.onafterprint = afterPrint;


</script>
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 

 <!-- 부트스트랩 JS  -->

 <script src="js/bootstrap.js"></script>

</BODY>

</HTML>
