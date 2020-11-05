<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>


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

		String userId = null;

		if (session.getAttribute("userId") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 

			userId = (String) session.getAttribute("userId");//유저아이디에 해당 세션값을 넣어준다.

		}

		if (userId == null) {

			PrintWriter script = response.getWriter();

			script.print("<script>");

			script.println("alert('로그인을 하세요.')");

			script.println("location.href = '../login.jsp'");

			script.println("</script>");

		} else {

			WorkDAO WorkDAO = new WorkDAO();
			
			int result = WorkDAO.ReClickLeave(userId);
			
			if(result == -1){
				PrintWriter script = response.getWriter();

				script.println("<script>");

				script.println("alert('데이터베이스 오류가 발생하였습니다.')");

				script.println("history.back()");

				script.println("</script>");

			}else {
				PrintWriter script = response.getWriter();

				script.println("<script>");

				script.println("alert('다시 퇴근 처리 되었습니다.')");

				script.println("history.back()");

				script.println("</script>");
			}


		}

	%>

</body>

</html>



