<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 회원가입</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/member/sign_up.js"></script>
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
					<li class="menu active"><i class="fi fi-rs-user-add"></i> 회원가입</li>
					<li class="menu"><i class="fi fi-rs-user"></i> 로그인</li>		
					<li class="menu"><i class="fi fi-rr-search"></i> 아이디 찾기</li>		
					<li class="menu"><i class="fi fi-rr-search"></i> 비밀번호 찾기</li>		
				</ul>
			</div>

			<!-- 컨텐츠 -->
			<div class="col-7 is-center">
				<div class="container margin-small">
				<h2 class="h-normal fs-35"><i class="fi fi-rs-user-add"></i> 회원가입</h2>
				<br>
				<table class="table">
					<tr>
						<th>아이디</th>
						<td>
							<div>
								<input class="input" type="text" id="userid" maxlength="20">
								<button type="button" class="btn green" id="overlapBtn">중복확인</button>
							</div>
							<div id="idCheck"><p class='msg info'>영문자, 숫자, 언더바(_), 점(.)을 이용한 5~20자</p></div>
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<div>
								<input class="input" type="password" id="pw" maxlength="20">
							</div>
							<div id="pwRegCheck"><p class='msg info'>10 ~ 20자 영문, 숫자, 특수문자 조합</p></div>
						</td>
					</tr>
					<tr>
						<th>비밀번호 확인</th>
						<td>
							<div>
								<input class="input" type="password" id="pw2" maxlength="16">
							</div>
							<div id="pwCheck"></div>
						</td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<div>
								<input class="input" type="text" id="username" maxlength="10">
							</div>
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
							<input class="input small" type="text" id="year" placeholder="년(4자)" maxlength="4"> /
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
							</select> /
							<input class="input small" type="text" id="date" placeholder="일" maxlength="2">
							<div id="birthCheck"></div>
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
								<button class="btn green" id="makeCodeBtn">인증번호 받기</button>
							</div>
							<div style="margin-top: 10px;">
								<input class="input" type="text" id="inputCode">
								<button class="btn outline-green" id="verifCodeBtn">인증하기</button>
							</div>
						</td>
					</tr>
				</table>
				<button type="submit" class="btn long green" id="signUpBtn">회원가입</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>