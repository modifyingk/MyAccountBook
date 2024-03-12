<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 아이디/비밀번호 찾기</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/member/find_id_pw.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<link rel="stylesheet" type="text/css" href="../resources/css/member/main.css">
</head>
<body>
	<div>
		<div class="container find-id-pw">
			<table id="select-find">
				<tr>
					<td>아이디 찾기</td>
					<td class="active">비밀번호 찾기</td>
				</tr>
			</table>
	
			<!-- 아이디 찾기 -->
			<div id="find-id-div" hidden="hidden">
				<div>
					<h2 class="title-text"><i class="fi fi-rr-search"></i> 아이디 찾기</h2>
					<p>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 아이디를 찾으실 수 있습니다.</p><br>
				</div>
				<div>
					<form method="post" id="find-id-form" action="showId">
						<table class="center-table">
							<tr>
								<th>이름</th>
								<td>
									<div>
										<input class="input" type="text" name="username" id="username-id">
									</div>
								</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td>
									<div>
										<input class="input email" type="text" id="email1-id"> @
										<input class="input email" type="text" id="email2-id">
										<select class="input email" id="select-email-id">
											<option value="self">직접입력</option>
											<option value="naver.com">naver.com</option>
											<option value="google.com">google.com</option>
											<option value="kakao.com">kakao.com</option>
											<option value="nate.com">nate.com</option>
										</select>
										<button type="button" class="btn main-color-btn" id="send-code-btn">인증번호 받기</button>
									</div>
									<div>
										<input class="input" type="text" name="code" id="code" placeholder="인증번호" maxlength="6">
										<button type="button" class="btn main-color-btn" id="verify-code-btn">인증하기</button>
									</div>
								</td>
							</tr>
						</table>
						<br><br>
					</form>
					<button class="btn main-color-btn" id="find-id-btn" disabled="disabled">아이디 찾기</button>
				</div>
			</div>
			
			<div id="find-pw-div">
				<div>
					<h2 class="title-text"><i class="fi fi-rr-search"></i> 비밀번호 찾기</h2>
					<p>본인확인 이메일 주소와 입력한 이메일 주소가 같아야, 비밀번호를 찾으실 수 있습니다.</p><br>
				</div>
				<div>
					<table class="center-table">
						<tr>
							<th>아이디</th>
							<td>
								<div>
									<input class="input" type="text" id="userid-pw">
								</div>
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>
								<div>
									<input class="input" type="text" id="username-pw">
								</div>
								<div class="checkDiv" id="nameCheck"></div>
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<div>
									<input class="input email" type="text" id="email1-pw"> @
									<input class="input email" type="text" id="email2-pw">
									<select class="input email" id="select-email-pw">
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
					<br><br>
					<button type="submit" class="btn main-color-btn" id="find-pw-btn">비밀번호 찾기</button>	
				</div>
			</div>
		</div>
	</div>
</body>
</html>