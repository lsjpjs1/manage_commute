
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

int sumWorkUnitPlan = 0;
 

int year = cal.get(Calendar.YEAR);

int month = cal.get(Calendar.MONTH);

int date = cal.get(Calendar.DATE);

SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");

SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");

ArrayList<Work> workLog = new ArrayList<Work>();






if(strYear != null)

{

  year = Integer.parseInt(strYear);

  month = Integer.parseInt(strMonth);

 

}else{

 

}
String yearStr = Integer.toString(year);
String monthStr = "";
if(year<10){
	monthStr = "0" + Integer.toString(month+1);
}else{
	monthStr = Integer.toString(month+1);
}

workLog = WorkDAO.getWorkLog(userId, yearStr, monthStr);

String workStartRealStr = "";
String workEndRealStr = "";

long sumWorkTimeMilliSec = 0;

for(int i=0; i<workLog.size();i++){
	if(workLog.get(i).getWorkStartReal()!=null && workLog.get(i).getWorkEndReal()!=null){
		workStartRealStr = formatter.format(workLog.get(i).getWorkStartReal());
		
		workEndRealStr = formatter.format(workLog.get(i).getWorkEndReal());
		
		Date workStartRealDate = formatter.parse(workStartRealStr);
		
		Date workEndRealDate = formatter.parse(workEndRealStr);
		
		long diff = workEndRealDate.getTime() - workStartRealDate.getTime();
		
		sumWorkTimeMilliSec += diff;
	}
		
}

long sumWorkTimeMin = sumWorkTimeMilliSec/60000;

//년도/월 셋팅

cal.set(year, month, 1);

 

int startDay = cal.getMinimum(java.util.Calendar.DATE);

int endDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);

int start = cal.get(java.util.Calendar.DAY_OF_WEEK);

int newLine = 0;

String endDayString = Integer.toString(endDay);

float sumWorkUnit = 0f;


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
		
		<link rel="stylesheet" href="css/bootstrap.min.css">

       <TITLE></TITLE>

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

    <a class="navbar-brand" href="main.jsp">출퇴근 관리</a>

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

<form name="calendarFrm" id="calendarFrm"  method="post" action="addScheduleAction.jsp">

<DIV id="content" style="width:712px;">


<a href="#" onclick="printArea()" style="color:blue">인쇄하기</a>
 

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

                    <a href="workLog.jsp?year=<%=year-1%>&amp;month=<%=month%>" target="_self">

                           <b>&lt;&lt;</b><!-- 이전해 -->

                    </a>

                    <%if(month > 0 ){ %>

                    <a href="workLog.jsp?year=<%=year%>&amp;month=<%=month-1%>" target="_self">

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

                    <a href="workLog.jsp?year=<%=year%>&amp;month=<%=month+1%>" target="_self">

                           <!-- 다음달 --><b>&gt;</b>

                    </a>

                    <%}else{%>

                           <b>&gt;</b>

                    <%} %>

                    <a href="workLog.jsp?year=<%=year+1%>&amp;month=<%=month%>" target="_self">

                           <!-- 다음해 --><b>&gt;&gt;</b>

                    </a>

             </td>

       </tr>

       </table>

 

</td>

</tr>

</table>
<div id="box">
&#60;<%=year%>년 <%=month+1 %>월 근무 내역&#62;
<div>
<p style="font-size:20px;display:inline">·</p>이름: <%=UserDAO.getUserName(userId) %> &nbsp; &nbsp; &nbsp; <p style="font-size:20px;display:inline">·</p>부서: <%=UserDAO.getUserBelong(userId) %> &nbsp;&nbsp;&nbsp;  <p style="font-size:20px;display:inline">·</p>직위: <%=UserDAO.getUserPosition(userId) %>
</div>
<table border="1">

<THEAD>

<tr height='20px' valign="middle">
	
	<TD width='90px' align="center">
	
	날짜
	
	</TD>
	
	<TD width='160px' align="center">
	
	출근 시간
	
	</TD>
	
	<TD width='160px' align="center">
	
	퇴근 시간
	
	</TD >
	
	<TD width='60px' align="center">
	
	근무 단위
	
	</TD>
	
	<TD width='242px' align="center">
	
	비고
	
	</TD>
	
</tr>
</THEAD>
<tbody>
<%
for(int index = 1; index <= endDay; index++){
    // 근무내용 달 주르륵 나오게 바꾸는 중 캘린더 참고해서 바꾸는 중 현재 포문으로 tr td 추가하는 중	
    String sUseDate = Integer.toString(year); 

    sUseDate += Integer.toString(month+1).length() == 1 ? "0" + Integer.toString(month+1) : Integer.toString(month+1);

    sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);

    String yyyymmddForCheck = sUseDate.substring(0,8);
    
    Date nDate = transFormat.parse(yyyymmddForCheck);
    
    cal.setTime(nDate);
	
    if(WorkDAO.getWorkUnitReal(userId, yyyymmddForCheck)==-1){
    	sumWorkUnit = sumWorkUnit + 1.5f;
    }else{
    	sumWorkUnit = sumWorkUnit + (float)WorkDAO.getWorkUnitReal(userId, yyyymmddForCheck);
    }
	
    
    int dayNum = cal.get(Calendar.DAY_OF_WEEK) ;
	
    String day = "";
    
    switch(dayNum){
    case 1:
        day = "일";
        break ;
    case 2:
        day = "월";
        break ;
    case 3:
        day = "화";
        break ;
    case 4:
        day = "수";
        break ;
    case 5:
        day = "목";
        break ;
    case 6:
        day = "금";
        break ;
    case 7:
        day = "토";
        break ;
         
}



%>

<tr height='17px' valign="middle">

	<td width='90px' align="center">
	
	<%=yyyymmddForCheck.substring(0,4) + "-" + yyyymmddForCheck.substring(4,6) + "-" + yyyymmddForCheck.substring(6) + " (" + day +")" %>
	
	</td>


	<td width='160px' align="center">
	
	<%for(int i=0; i< workLog.size();i++){
		String workDateStr = transFormat.format(workLog.get(i).getWorkDate());
		
		if(workDateStr.equals(yyyymmddForCheck)){  %>
			<%=workLog.get(i).getWorkStartReal() %>
		<% }else{}
	 } %>
	
	</td>


	<td width='160px' align="center">
	
	<%for(int i=0; i< workLog.size();i++){
		String workDateStr = transFormat.format(workLog.get(i).getWorkDate());
		if(workDateStr.equals(yyyymmddForCheck)){  %>
			<%=workLog.get(i).getWorkEndReal() %>
		<% }else{}
	 } %>
	
	</td>


	<td width='60px' align="center">
	
	<%for(int i=0; i< workLog.size();i++){
		String workDateStr = transFormat.format(workLog.get(i).getWorkDate());
		if(workDateStr.equals(yyyymmddForCheck)){  
			if(workLog.get(i).getWorkUnitReal()==-1){
		%>
			1.5
			<%}else{ %>
		
			<%=workLog.get(i).getWorkUnitReal() %>
		<% }}else{}
	 } %>
	
	</td>

	<td width='242px' align="center">
	
	<%for(int i=0; i< workLog.size();i++){
		String workDateStr = transFormat.format(workLog.get(i).getWorkDate());
		if(workDateStr.equals(yyyymmddForCheck)){  %>
			<%=workLog.get(i).getWorkContent() %>
		<% }else{}
	 } %>
	
	</td>

</tr>



<%} %>

</tbody>

</table>

<div>
<div id="sumWorkTime" style="display:block">총 근무 시간 : <%=sumWorkTimeMin/60 %> 시간 <%=sumWorkTimeMin%60 %> 분<br></div>
<div id="sumWorkUnit" style="display:block">총 근무 단위 : <%=sumWorkUnit %> 단위</div>
</div>
<%
if(UserDAO.getUserPosition(userId).equals("연구원")){%>
<script>
document.getElementById("sumWorkTime").style.display="none";
document.getElementById("sumWorkUnit").style.display="block";
</script>
<%}else{ %>
<script>
document.getElementById("sumWorkTime").style.display="block";
document.getElementById("sumWorkUnit").style.display="none";
</script>
<%} %>

</DIV>
</DIV>
&nbsp;&nbsp; &nbsp;&nbsp;
</form>
<!-- 애니매이션 담당 JQUERY -->
<script type="text/javascript">

var initBody;

function beforePrint() {
 boxes = document.body.innerHTML;
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
