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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/member/sign_up.js"></script>
<style type="text/css">
	#main-div {
		margin-top: 5%;
	}
	#signup-btn {
		width: 500px;
		height: 55px;
		font-weight: bold;
		font-size: 20px;
	}
	.signup-table {
		border-collapse: collapse;
		border-radius: 10px;
		width: 500px;
	}
	.signup-table td {
		border: 1px solid lightgray;
		padding: 10px;
		font-size: 20px;
		width: 500px;
	}
	.signup-table td div {
		float: left;
		margin: 5px;
	}
	.signup-table input {
		border: none;
		font-size: 18px;
		width: 400px;
	}
	.signup-table input:focus {
		outline: none;
	}
	#email-div {
		margin: 0;
	}
	#email-div input {
		width: 150px;
	}
	#select-address-btn:hover {
		cursor: pointer;
		color: #f39c12;
	}
	#select-address-div {
		position: absolute;
		background: white;
		display: none;
	}
	#address-table {
		width: 150px;
		border-collapse: separate;
	}
	#address-table td {
		border: 1px solid lightgray;
		border-radius: 10px;
	}
	#address-table td:hover {
		background: #F3F3F3;
		cursor: pointer;
	}
	#send-code-btn {
		width: 50px;
		background: #f39c12;
		color: white;
		text-align: center;
	}
	#send-code-btn:hover{
		cursor: pointer;
		background-color: #f38e12;
	}
</style>
</head>
<body>
	<div>
		<div>
			<!-- 컨텐츠 -->
			<div class="container" id="main-div">
				<div>
					<h2 class="fs40 main-color"><i class="fi fi-rs-user-add"></i> 회원가입</h2>
					<br>
					<table class="center-table signup-table">
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
					<table class="center-table signup-table">
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
					<table class="center-table signup-table">
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