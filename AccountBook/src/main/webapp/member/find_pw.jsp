<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 비밀번호 찾기</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/member/find_pw.js"></script>
</head>
<body>
	<div>
		<div>
			<!-- 사이드바 -->
			<div class="col-3 is-border is-shadow">
				<jsp:include page="../main/mainbar.jsp"></jsp:include>
				<img src="../resources/img/logo.png" class="side-logo" onclick="location.href='../main/main.jsp'">
				<ul class="menu-group">
					<li class="menu"><i class="fi fi-rr-home"></i> 메인화면</li>
					<li class="menu"><i class="fi fi-rs-user-add"></i> 회원가입</li>
					<li class="menu"><i class="fi fi-rs-user"></i> 로그인</li>		
					<li class="menu"><i class="fi fi-rr-search"></i> 아이디 찾기</li>		
					<li class="menu active"><i class="fi fi-rr-search"></i> 비밀번호 찾기</li>		
				</ul>
			</div>

			<!-- 컨텐츠 -->
			<div class="col-7 is-center">
				<div class="container margin-big">
				<h2 class="h-normal fs-35"><i class="fi fi-rr-search"></i> 비밀번호 찾기</h2>
				<br>
				<table class="table">
					<tr>
						<th>아이디</th>
						<td>
							<div>
								<input class="input" type="text" id="userid">
							</div>
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<div>
								<input class="input" type="text" id="username">
							</div>
							<div class="checkDiv" id="nameCheck"></div>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<div>
								<input class="input small" type="text" id="email1"> @
								<input class="input small" type="text" id="email2">
								<select class="input small" id="selectEmail">
									<option value="self">직접입력</option>
									<option value="naver.com">naver.com</option>
									<option value="google.com">google.com</option>
									<option value="kakao.com">kakao.com</option>
									<option value="nate.com">nate.com</option>
								</select>
							</div>
						</td>
					</tr>
				</table>
				<button type="submit" class="btn long green" id="findpwBtn">비밀번호 찾기</button>				
				</div>
			</div>
		</div>
	</div>
</body>
</html>