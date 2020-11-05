<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="user.UserDAO" %> <!-- userdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->



<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->

<jsp:useBean id="user" class="user.User" scope="page" />

<jsp:setProperty name="user" property="userId" />

<jsp:setProperty name="user" property="userPassword" /> 



<!DOCTYPE html>

<html>

<head>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>jsp 게시판 웹사이트</title>

</head>

<body>

	<%

		UserDAO userDAO = new UserDAO(); //인스턴스생성

		int result = userDAO.login(user.getUserId(), user.getUserPassword());

		// 1: 기존의 세션 데이터를 모두 삭제
	    session.invalidate();
	    // 2: 로그인 페이지로 이동시킴.
	    response.sendRedirect("login.jsp");

		


	

	%>



</body>

</body>

</html>



