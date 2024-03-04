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
<style type="text/css">
	#login-btn {
		width: 500px;
		height: 60px;
		font-weight: bold;
		font-size: 20px;
	}
	#main-div {
		margin-top: 10%;
	}
</style>
</head>
<body>
	<% /* 로그인이 되어 있을 때*/
	if(session.getAttribute("userid") != null) { %>
	<jsp:include page="../main/header.jsp"></jsp:include>
	<jsp:include page="../main/sidebar.jsp"></jsp:include>	
	<% }
	/* 로그인이 되어 있지 않을 때 */
	else { %>
	<div class="container" id="main-div">
		<div>
			<img src="../resources/img/piggy-bank.png" width="200px;">
		</div>
		<div>
			<div>
				<h1 class="main-color fs50">WHERE IS THE MONEY</h1>
				<h1 class="fs40">내 돈 어디로 사라진걸까?</h1>
				<h2>가계부로 사라진 돈을 찾아보세요!</h2>
				<br>
				<a href="../member/login.jsp"><button class="btn main-color-btn" id="login-btn">로그인</button></a>
			</div>
			<div>
				<a href="../member/find_id_pw.jsp">아이디/비밀번호 찾기</a>
				<a href="../member/sign_up.jsp">회원가입</a>
			</div>
		</div>
	</div>
	<% } %>
</body>
</html>