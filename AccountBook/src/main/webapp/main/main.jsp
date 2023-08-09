<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-thin-straight/css/uicons-thin-straight.css'>
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
		$("#find").click(function() {
			location.href = "";
		})
		
		var angle = 0;
		$("#watering").mousedown(function() {
			angle++;
			$("#water").show();
			if(angle >= 5) {
				$("#money").attr("src", "../resources/img/moneyleaf.png");
			}
			if(angle >= 10) {
				$("#money").attr("src", "../resources/img/moneyflower.png");
			}
			if(angle >= 15) {
				
			}
		})
		$("#watering").mouseup(function() {
			$("#water").hide();
		})
		$("#sign").click(function() {
			location.href = "../member/sign_up.jsp";
		})
	})
</script>
</head>
<body>
	<div class="">
		<!-- 사이드바 -->
		<div class="left-30">
			<img src="../resources/img/logo.png" class="side-logo" onclick="location.href='../main/main.jsp'">
		</div>
		
		<!-- 컨텐츠 -->
		<div class="right-70">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<%= session.getAttribute("userid") %>님 환영합니다!
			<% }
			/* 로그인이 되어 있지 않을 때 */
			else { %>
				<div>
					<div style="margin: 10%">
						<h2 class="mainText"><i class="fi fi-ts-seedling"></i>  Water Your Money!</h2>
						<p style="text-align: center;">클릭하면 물이 나와요</p>
						<img src="../resources/img/watering.png" width="200px" id="watering">
						<img src="../resources/img/water.png" width="80px;" id="water">
						<img src="../resources/img/moneyseed.png" id="money" width="200px;">
					</div>
					<div style="margin-top: 75%;">
						<button class="btn middle outline-green" id="sign">회원가입</button>
						<button class="btn middle outline-green" id="login">로그인</button>
						<button class="btn middle outline-green" id="find">아이디/비밀번호 찾기</button>
					</div>
				</div>			
			<% } %>
		</div>
	</div>
</body>
</html>