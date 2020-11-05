<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
  
<%@ page import="work.WorkDAO"%>

<%@ page import="work.Work"%>

<%@ page import="java.io.PrintWriter"%>

<%@ page import="java.util.ArrayList"%>

<%@ page import="user.UserDAO"%>
<jsp:useBean id="user" class="user.User" scope="page" />

<%

	request.setCharacterEncoding("UTF-8");

	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.
	
	UserDAO UserDAO = new UserDAO();
	
	String year = "";
	
	String month = "";
	
	year = request.getParameter("year");
	
	month = request.getParameter("month");
	
	System.out.println(year);
	
	System.out.println(month);
	
	String userId = null;
	
	WorkDAO WorkDAO = new WorkDAO();
	
	ArrayList<Work> workLog = new ArrayList<Work>();

	if (session.getAttribute("userId") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 

		userId = (String) session.getAttribute("userId");//유저아이디에 해당 세션값을 넣어준다.

	}
	
	if (userId == null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('로그인을 하세요.')");

		script.println("location.href = 'login.jsp'");

		script.println("</script>");

	}else{
	
	
	
	workLog = WorkDAO.getWorkLog(userId, year, month);
	
	System.out.println(workLog);
	
		if(workLog.size() != 0){
			
		}
	}
	

%>

<jsp:useBean id="work" class="work.Work" scope="page" />

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->

<meta name="viewport" content="width=device-width" >

<!-- 스타일시트 참조  -->

<link rel="stylesheet" href="css/bootstrap.min.css">

<title>jsp 게시판 웹사이트</title>





</head>

<body>



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

    <li><a href="main.jsp">근무계획 수정</a></li>

    <li><a href="workSchedule.jsp">근무표</a></li>
    
    <li><a href="workLog.jsp">지난 근무 내역</a></li>

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
 
 
 <form action="workLog.jsp" method="post">
  <select id="year" name="year" onchange="changeComboBox()" >
    <option value="">===년 선택 ===</option>
    <option value="2020">2020</option>
    <option value="2021">2021</option>
    <option value="2022">2022</option>
    <option value="2023">2023</option>
    <option value="2024">2024</option>
    <option value="2025">2025</option>
    <option value="2026">2026</option>
    <option value="2027">2027</option>
    <option value="2028">2028</option>
  </select>


  <select id="month" name="month" onchange="changeComboBox()" >
    <option value="">===월 선택 ===</option>
    <option value="01">01</option>
    <option value="02">02</option>
    <option value="03">03</option>
    <option value="04">04</option>
    <option value="05">05</option>
    <option value="06">06</option>
    <option value="07">07</option>
    <option value="08">08</option>
    <option value="09">09</option>
    <option value="10">10</option>
    <option value="11">11</option>
    <option value="12">12</option>
  </select>
  <input type="submit" value="확인">
</form>

<table border="1" cellspacing="0">
<tr>
<td> 날짜 </td>
<td> 출근 시간 </td>
<td> 퇴근 시간 </td>
<td> 근무 단위 </td>
<td> 근무 내용 </td>

</tr>

<%
for(int i = 0; i<workLog.size();i++){
%>
<tr>
<td><%=workLog.get(i).getWorkDate() %></td>
<td><%=workLog.get(i).getWorkStartReal() %></td>
<td><%=workLog.get(i).getWorkEndReal() %></td>
<td><%=workLog.get(i).getWorkUnitReal() %></td>
<td><%if(workLog.get(i).getWorkContent()!=null){ %><%=workLog.get(i).getWorkContent() %><%} %></td>
</tr>
<%} %>


</table>
 
<!-- 애니매이션 담당 JQUERY -->

 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 

 <!-- 부트스트랩 JS  -->

 <script src="js/bootstrap.js"></script>

</body>

</html>