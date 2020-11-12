<%@page import="work.Work"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.Calendar"%>

<%@ page import="work.WorkDAO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.util.Date"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="user.UserDAO"%>
<jsp:useBean id="user" class="user.User" scope="page" />

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

<%

	String userId=null;

	userId = (String) session.getAttribute("userId");//유저아이디에 해당 세션값을 넣어준다.
	WorkDAO WorkDAO = new WorkDAO();
	UserDAO UserDAO = new UserDAO();
	
%>

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
 
 <button style="height: 80px; width:100px" onclick="location='clickArriveAction.jsp'">출근</button>
 <span id="leave"><button style="height: 80px; width:100px" onclick="location='clickLeaveAction.jsp'">퇴근</button></span>
 <span id="reLeave"><button style="height: 80px; width:100px" onclick="location='reClickLeaveAction.jsp'">다시 퇴근</button></span>
  <input type="checkbox" id="lunchCheck" onchange="location='lunchCheckAction.jsp'" name="lunchCheck" >점심시간 근무 여부
 <%
 SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
	
	SimpleDateFormat formatterForDate = new SimpleDateFormat ("yyyy-MM-dd");
	
	Calendar cal = Calendar.getInstance();
	
	String today = null;
	
 	today = formatter.format(cal.getTime());
	
	Timestamp ts = Timestamp.valueOf(today);
	
	Date d = new Date(ts.getTime());
	

	
	String workDate = formatterForDate.format(d);

	int result =WorkDAO.isNullWorkEndReal(userId, workDate);
	System.out.println(result);
 if(result==-3){ %>
 <script>
 document.getElementById("leave").style.display="none";
 document.getElementById("reLeave").style.display="";
 </script>
 <%}else{ %>
 <script>
 document.getElementById("leave").style.display="";
 document.getElementById("reLeave").style.display="none";
 </script>
 <%} %>
 
  <%if(WorkDAO.getLunch(userId, workDate).equals("O")){%>
 <script>
 document.getElementById("lunchCheck").checked=true;
 </script>
 <%}else{ %>
  <script>
 document.getElementById("lunchCheck").checked=false;
 </script>
 <%} %>
 
 <form action="addWorkContent.jsp" method="post">
 <pre>
 비고
 <input type="text" name = "workContent" size="100">
 <input type="submit" value="확인">
 </pre>
 </form>
 
<!-- 애니매이션 담당 JQUERY -->

 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 

 <!-- 부트스트랩 JS  -->

 <script src="js/bootstrap.js"></script>

</body>

</html>