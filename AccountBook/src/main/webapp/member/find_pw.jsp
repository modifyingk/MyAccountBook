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
<script>
	$(function() {
		// 이메일 주소 select
		$("#selectEmail").change(function() {
			// 직접입력을 선택한 경우
			if($(this).val() == "self") {
				$("#email2").attr("value", "");
			} else { // 직접입력이 아닌 주소를 선택한 경우
				$("#email2").attr("value", $(this).val());
			}
		})
		// DB에 저장된 아이디와 이름, 이메일 정보가 일치하는지 확인
		$("#findpwBtn").click(function() {
			var email = $("#email1").val() + "@" + $("#email2").val();
			$.ajax({
				type : "post",
				url : "findPw",
				data : {
					userid : $("#userid").val(),
					username : $("#username").val(),
					email : email
				},
				success : function(x) {
					if(x != "fail") {
						$.ajax({
							type : "post",
							url : "tempPw",
							data : {
								userid : x,
								email : email
							},
							success : function(x) {
								if(x == "success") {
									alert("입력하신 이메일로 임시 비밀번호가 전송되었습니다.")
									location.href = "../member/login.jsp";
								} else {
									alert("다시 시도해주세요.");
								}
							}
						})
					} else {
						alert("입력한 정보를 다시 확인해주세요");
					}
				}
			})
		})
	})
</script>
</head>
<body>
	<div class="content">
		<div>
			<!-- 사이드바 -->
			<div class="left-30">
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
			<div class="right-70">
				<div class="find-container">
				<h2 class="h2"><i class="fi fi-rr-search"></i> 비밀번호 찾기</h2>
				<br>
				<table class="signup-table">
					<tr>
						<td class="field">아이디</td>
						<td>
							<div>
								<input class="signup-input" type="text" id="userid">
							</div>
						</td>
					</tr>
					<tr>
						<td class="field">이름</td>
						<td>
							<div>
								<input class="signup-input" type="text" id="username">
							</div>
							<div class="checkDiv" id="nameCheck"></div>
						</td>
					</tr>
					<tr>
						<td class="field">이메일</td>
						<td>
							<div>
								<input class="signup-input email" type="text" id="email1"> @
								<input class="signup-input email" type="text" id="email2">
								<select class="signup-input email" id="selectEmail">
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
				<button type="submit" class="btn green" id="findpwBtn">비밀번호 찾기</button>				
				</div>
			</div>
		</div>
	</div>
</body>
</html>