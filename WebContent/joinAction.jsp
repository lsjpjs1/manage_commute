<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="user.UserDAO" %> <!-- userdao�� Ŭ���� ������ -->

<%@ page import="java.io.PrintWriter" %> <!-- �ڹ� Ŭ���� ��� -->

<%

	request.setCharacterEncoding("UTF-8");

	response.setContentType("text/html; charset=UTF-8"); //set���ξ��½������̼���.

%>

<!-- �Ѹ��� ȸ�������� ��� userŬ������ �ڹ� ����� ��� / scope:������ ������ ������������ ���-->

<jsp:useBean id="user" class="user.User" scope="page" />

<jsp:setProperty name="user" property="userId" />

<jsp:setProperty name="user" property="userPassword" /> 

<jsp:setProperty name="user" property="userName" />


 
<jsp:setProperty name="user" property="userPosition" />

<jsp:setProperty name="user" property="userBelong" />

<!DOCTYPE html>

<html>

<head>



<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>jsp �Խ��� ������Ʈ</title>

</head>

<body>

	<%
	
		

		if (user.getUserId() == null || user.getUserPassword() == null || user.getUserName() == null

			|| user.getUserPosition() == null || user.getUserBelong() == null ){

				PrintWriter script = response.getWriter();

				script.println("<script>");

				script.println("alert('�Է��� �� �� ������ �ֽ��ϴ�.')");

				script.println("history.back()");

				script.println("</script>");

			} else{

				UserDAO userDAO = new UserDAO(); //�ν��Ͻ�����

				int result = userDAO.join(user);				

				

				if(result == -1){ // ���̵� �⺻Ű��. �ߺ��Ǹ� ����.

					PrintWriter script = response.getWriter();

					script.println("<script>");

					script.println("alert('�̹� �����ϴ� ���̵� �Դϴ�.')");

					script.println("history.back()");

					script.println("</script>");

				}

				//���Լ���

				else {

					PrintWriter script = response.getWriter();

					script.println("<script>");
					
					script.println("alert('������ �Ϸ�Ǿ����ϴ�.')");

					script.println("location.href = 'login.jsp'");

					script.println("</script>");

				}

			}

			%>



</body>

</body>

</html>


