<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 회원가입</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function() {
		$("#loginBtn").click(function() {
			$.ajax({
				type: "post",
				url : "login",
				data : {
					userid : $("#userid").val(),
					pw : $("#pw").val()
				},
				success : function(x) {
					if(x == "fail") {
						$("#loginFail").html("<i style='color : red;'>아이디와 비밀번호가 일치하지 않습니다.</i>")
					} else {
						location.href = "../main/main.jsp";
					}
				}
			})
		})
	})
</script>
</head>
<body>
	<div class="content">
		<div>
			<!-- 사이드바 -->
			<div class="left-30">
				<img src="../resources/img/logo.png" class="side-logo" onclick="location.href='../main/main.jsp'">
			</div>

			<!-- 컨텐츠 -->
			<div class="right-70">
				<div class="login-container">
				<h2 class="h2"><i class="fi fi-rs-user"></i> 로그인</h2>
				<br>
				<table class="signup-table">
					<tr>
						<td class="field">아이디</td>
						<td>
							<div>
								<input class="signup-input" type="text" id="userid" maxlength="20">
							</div>
						</td>
					</tr>
					<tr>
						<td class="field">비밀번호</td>
						<td>
							<div>
								<input class="signup-input" type="password" id="pw" maxlength="20">
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2"><div id="loginFail"></div></td>
					</tr>
				</table>
				<button type="submit" class="btn green" id="loginBtn">로그인</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>