<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 회원가입</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<link rel="stylesheet" type="text/css" href="../resources/css/member/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/member/sign_up.js"></script>
</head>
<body>
	<div>
		<div>
			<!-- 컨텐츠 -->
			<div class="container signup main-div">
				<div>
					<h2 class="title-text"><i class="fi fi-rs-user-add"></i> 회원가입</h2>
					<br>
					<table class="table center-table">
						<tr>
							<td>
								<div><i class="fi fi-rr-user"></i></div>
								<div><input type="text" id="userid" placeholder="아이디" maxlength="20"></div>
							</td>
						</tr>
						<tr>
							<td>
								<div><i class="fi fi-rr-lock"></i></div>
								<div><input type="password" id="pw" placeholder="비밀번호" maxlength="20"></div>
							</td>
						</tr>
					</table>
					<div id="id-check-div"></div>
					<div id="pw-check-div"></div>
					<br>
					<table class="table center-table">
						<tr>
							<td>
								<div><i class="fi fi-rr-user"></i></div>
								<div><input placeholder="이름" id="username" maxlength="10"></div>
							</td>
						</tr>
						<tr>
							<td>
								<div><i class="fi fi-rs-calendar"></i></div>
								<div><input placeholder="생년월일 8자리 (YYYYMMDD)" id="birth" maxlength="8"></div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="select">
									<input type="radio" name="gender" id="male" value="M"><label for="male">남자</label>
									<input type="radio" name="gender" id="female" value="F"><label for="female">여자</label>
								</div>
							</td>
						</tr>
					</table>
					<div id="name-check-div"></div>
					<div id="birth-check-div"></div>
					<br>
					<table class="table center-table">
						<tr>
							<td>
								<div><i class="fi fi-rr-envelope"></i></div>
								<div id="email-div">
									<div><input type="text" placeholder="이메일" id="email">@</div>
									<div>
										<input type="text" id="address"><i class="fi fi-rr-angle-square-down" id="select-address-btn"></i>
										<div id="select-address-div">
											<table id="address-table">
												<tr><td>naver.com</td></tr>
												<tr><td>gmail.com</td></tr>
												<tr><td>kakao.com</td></tr>
												<tr><td>nate.com</td></tr>
											</table>
										</div>
									</div>
								</div>
							</td>
							<td id="send-code-btn"><i class="fi fi-rr-paper-plane"></i></td>
						</tr>
						<tr>
							<td colspan="2">
								<div><i class="fi fi-rr-lock"></i></div>
								<div><input placeholder="인증번호" id="code" maxlength="6"></div>
							</td>
						</tr>
					</table>
					<br><br>
					<button type="submit" class="btn main-color-btn" id="signup-btn">가입</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>