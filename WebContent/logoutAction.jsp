<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="user.UserDAO" %> <!-- userdao�� Ŭ���� ������ -->

<%@ page import="java.io.PrintWriter" %> <!-- �ڹ� Ŭ���� ��� -->



<!-- �Ѹ��� ȸ�������� ��� userŬ������ �ڹ� ����� ��� / scope:������ ������ ������������ ���-->

<jsp:useBean id="user" class="user.User" scope="page" />

<jsp:setProperty name="user" property="userId" />

<jsp:setProperty name="user" property="userPassword" /> 



<!DOCTYPE html>

<html>

<head>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>jsp �Խ��� ������Ʈ</title>

</head>

<body>

	<%

		UserDAO userDAO = new UserDAO(); //�ν��Ͻ�����

		int result = userDAO.login(user.getUserId(), user.getUserPassword());

		// 1: ������ ���� �����͸� ��� ����
	    session.invalidate();
	    // 2: �α��� �������� �̵���Ŵ.
	    response.sendRedirect("login.jsp");

		


	

	%>



</body>

</body>

</html>



