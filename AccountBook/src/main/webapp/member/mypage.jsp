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
				<%= session.getAttribute("userid") %>님 환영합니다!
				<a href="../member/logout"><button class="btn outline-green" id="logoutBtn">로그아웃</button></a>
			<% }
			/* 로그인이 되어 있지 않을 때 */
			else { %>
				<script>location.href = "../member/login.jsp";</script>
			<% } %>
		</div>
	</div>
</body>
</html>