<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 개인정보 관리</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/member/my_info.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
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
					<h2 class="h-normal fs-35"><i class="fi fi-rs-user"></i> <%= session.getAttribute("userid") %></h2>
				<table class="table">
					<tr>
						<th>비밀번호</th>
						<td><button class="btn medium outline-gray" id="chgPwBtn">비밀번호 변경</button></td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input class="input" type="text" id="username" maxlength="10">
							<div id="nameCheck"></div>					
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
							<input class="input small" type="text" id="year" placeholder="년(4자)" maxlength="4">
							<select class="input small" id="month">
								<option>월</option>
								<option value="01">1</option>
								<option value="02">2</option>
								<option value="03">3</option>
								<option value="04">4</option>
								<option value="05">5</option>
								<option value="06">6</option>
								<option value="07">7</option>
								<option value="08">8</option>
								<option value="09">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select>
							<input class="input small" type="text" id="date" placeholder="일" maxlength="2">
							<div id="birthCheck"></div>
						</td>
					</tr>
				</table>
				<button class="btn medium green" id="updateMemBtn">개인정보 수정</button>
				<button class="btn medium outline-green" id="deleteMemBtn">회원탈퇴</button>
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