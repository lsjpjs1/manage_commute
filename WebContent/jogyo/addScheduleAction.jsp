
<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
  
<%@ page import="work.WorkDAO"%>

<%@ page import="java.io.PrintWriter"%>

<%@ page import="java.util.Enumeration"%>

<jsp:useBean id="work" class="work.Work" scope="page" />

<!DOCTYPE html>
<% 
	
	request.setCharacterEncoding("UTF-8");
	
	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.
	
	Boolean isCancel = false;
	
	if(request.getParameter("isCancel").equals("yes")){
		isCancel = true;
	}else{
		isCancel = false;
	}
	
	String userId = null;
	
	String startTime = "";
	
	String endTime = "";
	
	String [] chk = {};
	
	if(request.getParameterValues("chk[]")!=null){
		chk = request.getParameterValues("chk[]");
	}
	String endDay = request.getParameter("endDay");
	endDay = endDay.substring(0,2);
	String yyyymm = request.getParameter("yyyymmdd");
	
	int endDayInt = Integer.parseInt(endDay);
	
	WorkDAO WorkDAO = new WorkDAO();

	if (session.getAttribute("userId") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 

		userId = (String) session.getAttribute("userId");//유저아이디에 해당 세션값을 넣어준다.

	}

	if (userId == null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('로그인을 하세요.')");

		script.println("location.href = '../login.jsp'");

		script.println("</script>");

	} else {
	
		
		
		for(int i=1;i<endDayInt+1;i++){

			String index = Integer.toString(i);
			
			String validCheck = "validCheck" + index;
			
			String indexForWorkDate = "";
			
			if(index.length()==1){
				indexForWorkDate = "0" + index;
			}else{
				indexForWorkDate = index;
			}
			
			String workDate = yyyymm.substring(0, 6) + indexForWorkDate;
			
			
			
			for(int j=0;j<chk.length;j++){
				if(workDate.equals(chk[j])){
					
					startTime = request.getParameter("startTime");
					endTime = request.getParameter("endTime");
					String workStartPlan = yyyymm.substring(0, 4) + "-" + yyyymm.substring(4, 6) + "-" + indexForWorkDate + " " + startTime + ":00";
					String workEndPlan = yyyymm.substring(0, 4) + "-" + yyyymm.substring(4, 6) + "-" + indexForWorkDate + " " + endTime + ":00";
					if(startTime=="" || isCancel){
						workStartPlan=null;
					}
					
					if(endTime=="" || isCancel){
						workEndPlan=null;							
					}
					
					WorkDAO.setWorkStartPlan(userId, workDate, workStartPlan);
					
					WorkDAO.setWorkEndPlan(userId, workDate, workEndPlan);
					
					String workUnitPlan = request.getParameter("selectUnit");
					
					if(isCancel){
						workUnitPlan = null;
					}else{
						workUnitPlan = request.getParameter("selectUnit");
					}
					
					WorkDAO.setWorkUnitPlan(userId, workDate, workUnitPlan);
				}
			}
			
			PrintWriter script = response.getWriter();

			script.println("<script>");

			script.println("location.href = 'calendar.jsp'");

			script.println("</script>");
	
			
			
		}
		
		
	
	}
	


%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp 게시판 웹사이트</title>
</head>
<body>

</body>
</html>