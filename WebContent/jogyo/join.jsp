<%-- 주석처리
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 
        Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>신규 직원 정보 등록</title>
</head>
<body>
    <form action="joinAction.jsp" method="get">
        아이디 :       <input type="text" name="userId" size="20"><br>
        비밀번호 :	     <input type="text" name="userPassword" size="20"><br>
        이름 :        <input type="text" name="userName" size="20"><br>
        직책 :        <input type="text" name="userPosition" size="20"><br>
        소속 : 
        <input type="checkbox" name="userBelong" value="사전학센터">사전학센터
        <input type="checkbox" name="userBelong" value="국어사전실">국어사전실
        <input type="checkbox" name="userBelong" value="중한사전실">중한사전실     
        <input type="checkbox" name="userBelong" value="전산실">전산실           
        <br>
        <input type="submit" value="전송">
    </form>
</body>
</html> 
주석처리--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>
	
<%@ page import="java.io.PrintWriter" %> <!-- 자바 클래스 사용 -->

<%

	request.setCharacterEncoding("UTF-8");

	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.

%>


<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->

<meta name="viewport" content="width=device-width" >

<!-- 스타일시트 참조  -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">

<title>jsp 게시판 웹사이트</title>

</head>

<body>

	
	<!-- 네비게이션  -->

	<nav class="navbar navbar-default">

		<div class="navbar-header">

			<button type="button" class="navbar-toggle collapsed"

				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"

				aria-expaned="false">

				<span class="icon-bar"></span> <span class="icon-bar"></span> <span

					class="icon-bar"></span>

			</button>

			<a class="navbar-brand" href="login.jsp">출퇴근 관리</a>

		</div> 

		<div class="collapse navbar-collapse"

			id="#bs-example-navbar-collapse-1">

			<!-- <ul class="nav navbar-nav">

				<li><a href="main.jsp">메인</a></li>

				<li><a href="bbs.jsp">게시판</a></li>

			</ul> -->



			<ul class="nav navbar-nav navbar-right">

				<li class="dropdown"><a href="#" class="dropdown-toggle"

					data-toggle="dropdown" role="button" aria-haspopup="true"


 
					aria-expanded="false">접속하기<span class="caret"></span></a>

					<ul class="dropdown-menu">

						<li class="active"><a href="login.jsp">로그인</a></li>

						<li><a href="join.jsp">회원가입</a></li>



					</ul></li>

			</ul>

		</div>

	</nav>

	<!-- 로긴폼 -->

	<div class="container">

		<div class="col-lg-4"></div>

		<div class="col-lg-4">

			<!-- 점보트론 -->

			<div class="jumbotron" style="padding-top: 20px;">

				<!-- 로그인 정보를 숨기면서 전송post -->

				<form method="post" action="joinAction.jsp">

					<h3 style="text-align: center;">회원가입</h3>

					<div class="form-group">

						<input type="text" class="form-control" placeholder="아이디(20자 이내)"

							name="userId" maxlength="20">

					</div>

					<div class="form-group">

						<input type="password" class="form-control" placeholder="비밀번호(20자 이내)"

							name="userPassword" maxlength="20">

					</div>

					<div class="form-group">

						<input type="text" class="form-control" placeholder="이름"

							name="userName" maxlength="20">

					</div>
					<div class="form-group">

						<input type="radio" name="userPosition" value="연구원"> 연구원
						<input type="radio" name="userPosition" value="조교보"> 조교보

					</div>
					
					<div class="form-group">

						<input type="radio" name="userBelong" value="국어사전실"> 국어사전실 
						<input type="radio" name="userBelong" value="중한사전실"> 중국어사전실
						<input type="radio" name="userBelong" value="전산실"> 전산실

					</div>
					
					
					<!--  

					<div class="form-group" style="text-align: center;">

						<div class="btn-group" data-toggle="buttons">

							<label class="btn btn-primary active"> <input

								type="radio" name="userBelong" autocomplete="off" value="dictionaryCenter"

								checked>사전학센터

							</label> 
							<label class="btn btn-primary"> <input type="radio"

								name="userBelong" autocomplete="off" value="koreanDic" >국어사전실

							</label>
							
							<label class="btn btn-primary"> <input type="radio"

								name="userBelong" autocomplete="off" value="chineseDic" >중한사전실

							</label>
							<label class="btn btn-primary"> <input type="radio"

								name="userBelong" autocomplete="off" value="computerManage" >전산실

							</label>
							

						</div>

					</div> 
					
					-->




					<input type="submit" class="btn btn-primary form-control"

						value="회원가입">





				</form>

			</div>

		</div>

	</div>





	<!-- 애니매이션 담당 JQUERY -->

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

	<!-- 부트스트랩 JS  -->

	<script src="js/bootstrap.js"></script>



</body>

</html>


