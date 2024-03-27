<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 비밀번호 확인</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<link rel="stylesheet" type="text/css" href="../resources/css/member/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function() {
		$("#check-pw-btn").click(function() {
			$.ajax({
				type : "post",
				url : "checkPw",
				data : {
					userid : $("#userid").val(),
					pw : $("#pw").val()
				},
				success : function(res) {
					if(res == true) {
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
		<jsp:include page="../main/header.jsp"></jsp:include>
		<jsp:include page="../main/sidebar.jsp"></jsp:include>
		
		<!-- 컨텐츠 -->
		<div class="container checkpw">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<div>
					<h3 class="title-text"><i class="fi fi-rr-key"></i> 비밀번호 확인</h3>
					<table class="center-table">
						<tr>
							<td>
								<div><i class="fi fi-rr-user"></i></div>
								<div><input class="input-inner" type="text" value="<%= session.getAttribute("userid") %>" disabled="disabled" id="userid"></div>
							</td>
						</tr>
						<tr>
							<td>
								<div><i class="fi fi-rr-lock"></i></div>
								<div><input class="input-inner" type="password" id="pw" placeholder="비밀번호" maxlength="20"></div>
							</td>
						</tr>
					</table>
				
					<button class="btn main-color-btn" id="check-pw-btn">확인</button>
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