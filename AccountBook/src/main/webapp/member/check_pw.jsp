<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 비밀번호 확인</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function() {
		$("#checkPwBtn").click(function() {
			$.ajax({
				type : "post",
				url : "checkPw",
				data : {
					userid : $("#userid").val(),
					pw : $("#pw").val()
				},
				success : function(x) {
					if(x == "success") {
						location.href = "update_pw.jsp";
					} else {
						alert("비밀번호가 일치하지 않습니다.");
					}
				}
			})
		})
	})
</script>
</head>
<body>
	<div>
		<!-- 사이드바 -->
		<div class="col-2 is-border is-shadow">
			<jsp:include page="../main/sidebar.jsp"></jsp:include>
			<img src="../resources/img/logo.png" style="width: 90%;" onclick="location.href='../main/main.jsp'">
			<ul class="menu-group">
				<li class="menu active"><i class="fi fi-rr-home"></i> 메인페이지</li>
				<li class="menu"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 관리</li>		
				<li class="menu"><i class="fi fi-rr-coins"></i> 자산관리</li>		
				<li class="menu"><i class="fi fi-rs-calendar-check"></i> 캘린더</li>		
				<li class="menu"><i class="fi fi-rs-chart-histogram"></i> 목표 관리</li>
				<li class="menu"><i class="fi fi-rr-sign-out-alt"></i> 로그아웃</li>
			</ul>
		</div>
		
		<!-- 컨텐츠 -->
		<div class="col-8 is-center">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<div class="container margin-medium is-border width-50">
					<h3 class="h-normal fs-28"><i class="fi fi-rr-key"></i> 비밀번호 확인</h3>
					<table class="table">
						<tr>
							<th>아이디</th>
							<td><input class="input" type="text" value="<%= session.getAttribute("userid") %>" disabled="true" id="userid"></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input class="input" type="password" id="pw"></td>
						</tr>
					</table>
					<button class="btn long green" id="checkPwBtn">확인</button>
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