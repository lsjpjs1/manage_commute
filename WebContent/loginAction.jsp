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

		

		//�α��� ����

		if(result == 1){
			
			if(userDAO.getUserPosition(user.getUserId()).equals("������")){
				PrintWriter script = response.getWriter();
				
				session.setAttribute("userId", user.getUserId()); 

				script.println("<script>");
				
				script.println("alert('�α��� �Ǿ����ϴ�.')");

				script.println("location.href = 'main.jsp'");

				script.println("</script>");
			}else{
PrintWriter script = response.getWriter();
				
				session.setAttribute("userId", user.getUserId()); 

				script.println("<script>");
				
				script.println("alert('�α��� �Ǿ����ϴ�.')");

				script.println("location.href = 'jogyo/main_jogyo.jsp'");

				script.println("</script>");
			}

			

		}

		//�α��� ����

		else if(result == 0){

			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("alert('��й�ȣ�� Ʋ���ϴ�.')");

			script.println("history.back()");

			script.println("</script>");

		}

		//���̵� ����

		else if(result == -1){

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('�������� �ʴ� ���̵� �Դϴ�.')");

		script.println("history.back()");

		script.println("</script>");

		}

		//DB����

		else if(result == -2){

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('DB������ �߻��߽��ϴ�.')");

		script.println("history.back()");

		script.println("</script>");

		}		

	

	%>



</body>

</body>

</html>



