<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 비밀번호 변경</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<link rel="stylesheet" type="text/css" href="../resources/css/member/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/member/update_pw.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
</script>
</head>
<body>
	<div>
		<jsp:include page="../main/header.jsp"></jsp:include>
		<jsp:include page="../main/sidebar.jsp"></jsp:include>
		
		<!-- 컨텐츠 -->
		<div class="container updatepw">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<div>
					<h3 class="title-text"><i class="fi fi-rr-key"></i> 비밀번호 변경</h3>
					<table class="center-table">
						<tr>
							<td>
								<div><i class="fi fi-rr-lock"></i></div>
								<div><input class="input-inner" type="password" id="pw" placeholder="변경할 비밀번호" maxlength="20"></div>
							</td>
						</tr>
						<tr>
							<td>
								<div><i class="fi fi-rr-lock"></i></div>
								<div><input class="input-inner" type="password" id="pw2" placeholder="비밀번호 확인" maxlength="20"></div>
							</td>
						</tr>
					</table>
					<div id="pw-check-div"></div>
					<div id="pw-equal-div"></div>
					<button class="btn main-color-btn" id="update-pw-btn">변경</button>
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