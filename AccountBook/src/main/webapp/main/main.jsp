<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-thin-straight/css/uicons-thin-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function() {
		$("#sign").click(function() {
			location.href = "../member/sign_up.jsp";
		})
		$("#login").click(function() {
			location.href = "../member/login.jsp";
		})
		$("#find_id").click(function() {
			location.href = "../member/find_id.jsp";
		})
		$("#find_pw").click(function() {
			location.href = "../member/find_pw.jsp";
		})
	})
</script>
</head>
<body>
	<div class="">
		<!-- 사이드바 -->
		<div class="col-3 is-border is-shadow">
			<jsp:include page="../main/mainbar.jsp"></jsp:include>
			<img src="../resources/img/logo.png" class="side-logo" onclick="location.href='../main/main.jsp'">
			<ul class="menu-group">
				<li class="menu active"><i class="fi fi-rr-home"></i> 메인화면</li>
				<li class="menu"><i class="fi fi-rs-user-add"></i> 회원가입</li>
				<li class="menu"><i class="fi fi-rs-user"></i> 로그인</li>		
				<li class="menu"><i class="fi fi-rr-search"></i> 아이디 찾기</li>		
				<li class="menu"><i class="fi fi-rr-search"></i> 비밀번호 찾기</li>		
			</ul>
		</div>
		
		<!-- 컨텐츠 -->
		<div class="col-7 is-center">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<script>location.href = "../member/mypage.jsp";</script>
			<% }
			/* 로그인이 되어 있지 않을 때 */
			else { %>
				<div class="container margin-small">
					<div>
						<h2 class="main-text"><i class="fi fi-ts-seedling"></i>  Water Your Money!</h2>
						<br>
						<img src="../resources/img/watering.png" width="200px" id="watering">
						<img src="../resources/img/water.png" width="80px;" id="water">
						<img src="../resources/img/moneyseed.png" id="plant" width="200px;">
					</div>
					<div class="main-menu">
						<button class="btn menu-btn outline-green" id="sign">회원가입</button>
						<button class="btn menu-btn green" id="login">로그인</button> <br>
						<button class="btn menu-btn outline-green" id="find_id">아이디 찾기</button>
						<button class="btn menu-btn outline-green" id="find_pw">비밀번호 찾기</button>
					</div>
				</div>			
			<% } %>
		</div>
	</div>
</body>
</html>