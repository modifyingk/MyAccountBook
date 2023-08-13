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
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<div>
					<div class="right-80">
						<div>
							<div class="left-60">
								<h2 class="h2"><i class="fi fi-rs-user"></i> <%= session.getAttribute("userid") %></h2>
								<a href="../member/myInfo.jsp"><button class="btn long outline-green">내 정보 관리</button></a>
							</div>
							<div class="right-40">
								<br>
								<a href="../member/logout"><button class="btn outline-gray" id="logoutBtn">로그아웃</button></a>
							</div>
						</div>
					</div>
					<div class="right-20">
						
					</div>
				</div>
			<% }
			/* 로그인이 되어 있지 않을 때 */
			else { %>
				<script>location.href = "../member/login.jsp";</script>
			<% } %>
		</div>
	</div>
</body>
</html>