<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>


<%@ page import="work.WorkDAO"%>

<%@ page import="java.io.PrintWriter"%>

<%

	request.setCharacterEncoding("UTF-8");

	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.

%>




<jsp:useBean id="work" class="work.Work" scope="page" />

<!DOCTYPE html>

<html>

<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>jsp 게시판 웹사이트</title>

</head>

<body>

	<%

	String userId = null;

	if (session.getAttribute("userId") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 

		userId = (String) session.getAttribute("userId");//유저아이디에 해당 세션값을 넣어준다.

	}
	
	if (userId == null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('로그인을 하세요.')");

		script.println("location.href = 'login.jsp'");

		script.println("</script>");

	} else {
		
		WorkDAO WorkDAO = new WorkDAO();
		
		
		
	}

	%>

</body>

</html>