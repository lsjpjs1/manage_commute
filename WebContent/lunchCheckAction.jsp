<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>

<%@page import="work.Work"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.Calendar"%>



<%@ page import="user.UserDAO"%>


<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.util.Date"%>
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

		String today = null;
	
		String userId = null;
		
		Calendar cal = Calendar.getInstance();
		
		SimpleDateFormat formatterForDate = new SimpleDateFormat ("yyyy-MM-dd");
		
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
		
		today = formatter.format(cal.getTime());
		
		Timestamp ts = Timestamp.valueOf(today);
		
		Date d = new Date(ts.getTime());
		
		
		String workDate = formatterForDate.format(d);

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
			
			if(WorkDAO.getLunch(userId, workDate).equals("X")){
				int result=WorkDAO.setLunch(userId, "O");
				if(result==1){
					PrintWriter script = response.getWriter();

					script.println("<script>");

					script.println("alert('점심시간 근무 확인')");

					script.println("location.href = 'main.jsp'");

					script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();

					script.println("<script>");

					script.println("alert('오류 발생')");

					script.println("location.href = 'main.jsp'");

					script.println("</script>");
				}
			}else{
				int result=WorkDAO.setLunch(userId, "X");
				if(result==1){
					PrintWriter script = response.getWriter();

					script.println("<script>");

					script.println("alert('점심시간 근무 취소')");

					script.println("location.href = 'main.jsp'");

					script.println("</script>");
				}else{
					PrintWriter script = response.getWriter();

					script.println("<script>");

					script.println("alert('오류 발생')");

					script.println("location.href = 'main.jsp'");

					script.println("</script>");
				}
			}
			
			
			
			
			


		}

	%>

</body>

</html>



