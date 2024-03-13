<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 개인정보 관리</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<link rel="stylesheet" type="text/css" href="../resources/css/member/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/member/my_info.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
</script>
</head>
<body>
	<div>
		<jsp:include page="../main/header.jsp"></jsp:include>
		<jsp:include page="../main/sidebar.jsp"></jsp:include>	
		
		<!-- 컨텐츠 -->
		<div class="myinfo">
		<%
		/* 로그인이 되어 있을 때*/
		if(session.getAttribute("userid") != null) { %>
				<h2 class="title-text">개인정보 관리</h2>
				<table>
					<tr>
						<th>비밀번호</th>
						<td><button class="btn" id="change-pw">비밀번호 변경</button></td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input class="input" type="text" id="username" maxlength="10">
						</td>
					</tr>
					<tr>
						<th>성별</th>
						<td>
							<div class="select">
								<input type="radio" name="gender" id="male" value="M"><label for="male">남자</label>
								<input type="radio" name="gender" id="female" value="F"><label for="female">여자</label>
							</div>
						</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>
							<input class="input" placeholder="생년월일 8자리 (YYYYMMDD)" id="birth" maxlength="8">
						</td>
					</tr>
				</table>
				<br><br>
				<button class="btn main-color-btn" id="update-btn">개인정보 수정</button>
				<button class="btn main-outline-btn" id="drop-btn">회원탈퇴</button>
		<% }
		/* 로그인이 되어 있지 않을 때 */
		else { %>
			<script>location.href = "../member/login.jsp";</script>
		<% } %>
		</div>
	</div>
</body>
</html>