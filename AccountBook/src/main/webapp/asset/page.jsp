<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function() {
		$("#sign").click(function() {
			location.href = "../member/sign_up.jsp";
		})
	})
</script>
</head>
<body>
	<div class="">
		<!-- 사이드바 -->
		<div class="left-20">
			<jsp:include page="../main/sidebar.jsp"></jsp:include>
		</div>
		
		<!-- 컨텐츠 -->
		<div class="right-80">
			<h3 class="h3"><i class="fi fi-rr-home"></i> 메인페이지</h3>
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<h3 class="h3">수입/지출 관리</h3>
			<% }
			/* 로그인이 되어 있지 않을 때 */
			else { %>
				<div class="card-group">
					<div class="card" id="sign">
						<div class="card-body">
							<i class="fi fi-rs-user-add"></i><br>
							회원가입
						</div>
					</div>
					<div class="card" id="login">
						<div class="card-body">
							<i class="fi fi-rs-user"></i><br>
							로그인
						</div>
					</div>
					<div class="card" id="find">
						<div class="card-body">
							<i class="fi fi-rr-search"></i><br>
							아이디/비밀번호 찾기
						</div>
					</div>
				</div>
			<% } %>
		</div>
	</div>
</body>
</html>