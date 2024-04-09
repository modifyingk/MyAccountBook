<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<link rel="stylesheet" type="text/css" href="../resources/css/member/main.css">
</head>
<body>
	<% /* 로그인이 되어 있을 때*/
	if(session.getAttribute("userid") != null) { %>
		<script>location.href = "../member/mypage.jsp";</script>
	<% }
	/* 로그인이 되어 있지 않을 때 */
	else { %>
	<div class="container main">
		<div>
			<div>
				<div>
					<img src="../resources/img/piggy-bank.png" width="200px;">
				</div>
				<h1 class="main-color fs50">가 계 부</h1>
				<h1 class="fs40">돈을 모으는 가장 빠른 방법</h1>
				<h2>가계부로 돈을 관리해보세요!</h2>
				<br>
				<a href="../member/login.jsp"><button class="btn main-color-btn" id="login-btn">로그인</button></a>
			</div>
			<br>
			<div id="href">
				<a href="../member/sign_up.jsp">회원가입</a>
				<a href="../member/find_id_pw.jsp">아이디/비밀번호 찾기</a>
			</div>
		</div>
	</div>
	<% } %>
</body>
</html>