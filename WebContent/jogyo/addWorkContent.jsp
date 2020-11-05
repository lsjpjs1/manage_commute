<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>
	
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->

<%@ page import="work.WorkDAO"%>

<%@ page import="java.io.PrintWriter"%>

<%

	request.setCharacterEncoding("UTF-8");

	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.

%>


<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->

<jsp:useBean id="work" class="work.Work" scope="page" />

<!DOCTYPE html>

<html>

<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>jsp 게시판 웹사이트</title>

</head>

<body>

	<%
		PrintWriter script = response.getWriter();
	
		String userId = null;

		if (session.getAttribute("userId") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 

			userId = (String) session.getAttribute("userId");//유저아이디에 해당 세션값을 넣어준다.

		}

		if (userId == null) {

			script.println("<script>");

			script.println("alert('로그인을 하세요.')");

			script.println("location.href = 'login.jsp'");

			script.println("</script>");

		} else {

			String workContent = "";
			
			WorkDAO WorkDAO = new WorkDAO();
			
			workContent = request.getParameter("workContent");
			
			int result = WorkDAO.setWorkContent(userId, workContent);
			
			if(result !=0){
				
				script.println("<script>");

				script.println("alert('입력 완료')");

				script.println("location.href = 'main.jsp'");

				script.println("</script>");

			}else{
			
			script.println("<script>");

			script.println("alert('입력 실패')");

			script.println("location.href = 'main.jsp'");

			script.println("</script>");
			}
		}

	%>

</body>

</html>



