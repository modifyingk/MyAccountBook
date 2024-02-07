<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 아이디찾기</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/member/find_id.js"></script>
</head>
<body>
	<div>
		<div>
			<!-- 사이드바 -->
			<div class="col-3 height-1050 is-border is-shadow">
				<jsp:include page="../main/mainbar.jsp"></jsp:include>
				<img src="../resources/img/logo.png" class="side-logo" onclick="location.href='../main/main.jsp'">
				<ul class="menu-group">
					<li class="menu"><i class="fi fi-rr-home"></i> 메인화면</li>
					<li class="menu"><i class="fi fi-rs-user-add"></i> 회원가입</li>
					<li class="menu"><i class="fi fi-rs-user"></i> 로그인</li>		
					<li class="menu active"><i class="fi fi-rr-search"></i> 아이디 찾기</li>		
					<li class="menu"><i class="fi fi-rr-search"></i> 비밀번호 찾기</li>		
				</ul>
			</div>

			<!-- 컨텐츠 -->
			<div class="col-7 is-center">
				<div class="container margin-big">
				<h2 class="h-normal fs-35"><i class="fi fi-rr-search"></i> 아이디 찾기</h2>
				<br>
				<p class="msg info">&nbsp 본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</p>
				<br><br>
				
				<form method="post" action="showId">
					<table class="table">
						<tr>
							<th>이름</th>
							<td>
								<div>
									<input class="input" type="text" name="username" id="username">
								</div>
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
									<button type="button" class="btn green" id="makeCodeBtn">인증번호 받기</button>
								</div>
								<div style="margin-top: 10px;">
									<input class="input" type="text" id="inputCode">
									<button type="button" class="btn outline-green" id="verifCodeBtn">인증하기</button>
								</div>
							</td>
						</tr>
						<tr hidden="true">
							<td colspan="2"><input name="email" id="email"></td>
						</tr>
					</table>
				<button type="submit" class="btn long green" id="findidBtn" disabled>아이디 찾기</button>
				</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>