<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 회원가입</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function() {
		// 아이디 형식 확인
		$("#userid").blur(function() {
			// 영문자로 시작하는 영문자 또는 숫자 6~20자 
			var idReg = RegExp(/^[a-z]+[a-z0-9]{5,19}$/g);
			
			if(!idReg.test($('#userid').val())){ // 정규식에 맞지 않을 때
				$("#idCheck").html("<i style='color : red;'>영문자로 시작하는 영문자, 숫자 조합 6~20자</i>");
			} else {
				// 아이디 중복 확인
				$("#overlapBtn").click(function() {
					$.ajax({
						type : "post",
						url : "isOverlapId",
						data : {
							userid : $("#userid").val()
						},
						success : function(x) {
							$("#idCheck").html(x);
						}
					})
				})
			}
		})
		// 비밀번호 형식 확인
		$("#pw").blur(function() {
			var pwReg = RegExp(/^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/);
			if(!pwReg.test($('#pw').val())){
				$("#pwRegCheck").html("<i style='color : red;'>8 ~ 16자 영문, 숫자, 특수문자 조합</i>");
			} else {
				$("#pwRegCheck").html("");
			}
		})
		// 비밀번호 확인
		$("#pw2").blur(function() {
			if($("#pw2").val() != $("#pw").val()) { // 비밀번호가 일치하지 않는 경우
				$("#pwCheck").html("<i style='color : red;'>비밀번호가 일치하지 않습니다.</i>");
			} else { // 비밀번호가 일치하는 경우
				$("#pwCheck").html("");
			}
		})
		// 이메일 주소 select
		$("#selectEmail").change(function() {
			// 직접입력을 선택한 경우
			if($(this).val() == "self") {
				$("#email2").attr("value", "");
			} else { // 직접입력이 아닌 주소를 선택한 경우
				$("#email2").attr("value", $(this).val());
			}
		})
		// 이름 형식 확인 (한글, 영어만 입력)
		
		// 생년월일 형식 확인 (숫자만 입력)
		// 전화번호 형식 확인 (숫자만 입력)
		// 빈값일 때 어떻게 할지 적용
	})
</script>
</head>
<body>
	<div>
		<!-- 사이드바 -->
		<div class="sidebar">
			<jsp:include page="../main/sidebar.jsp"></jsp:include>
		</div>

		<!-- 컨텐츠 -->
		<div class="content">
			<h3 class="h3"><i class="fi fi-rs-user-add"></i> 회원가입</h3>
			<div class="container" style="border: 1px solid lightgray; border-radius: 10px; width: 750px; padding: 0 20px 20px 20px;">
			<h3 class="h4">회원가입</h3>
			<table class="table">
				<tr>
					<td>아이디</td>
					<td><input class="input" type="text" id="userid" maxlength="20"><div class="checkDiv" id="idCheck"><i>영문자로 시작하는 영문자, 숫자 조합 6~20자</i></div></td>
					<td><button type="button" class="btn green" id="overlapBtn">중복확인</button></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input class="input" type="password" id="pw" maxlength="16"><div class="checkDiv" id="pwRegCheck"><i>8 ~ 16자 영문, 숫자, 특수문자 조합</i></div></td>
					<td></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input class="input" type="password" id="pw2" maxlength="16"><div class="checkDiv" id="pwCheck"></div></td>
					<td></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input class="input" type="text" id="username" required></td>
					<td></td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<div class="select">
							<input type="radio" name="gender" id="male" value="남"><label for="male">남자</label>
							<input type="radio" name="gender" id="female" value="여"><label for="female">여자</label>
						</div>
					</td>
						<td></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td colspan="2">
						<input class="input birth" type="text" id="year" placeholder="년(4자)" maxlength="4">
						<select class="input birth" id="month">
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
						<input class="input birth" type="text" id="day" placeholder="일" maxlength="2">
					</td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td colspan="2">
						<input class="input tel" type="text" id="tel1"> -
						<input class="input tel" type="text" id="tel2"> -
						<input class="input tel" type="text" id="tel3">
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td colspan="2">
						<input class="input email" type="text" id="email1"> @
						<input class="input email" type="text" id="email2">
						<select class="input email" id="selectEmail">
							<option value="self">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="google.com">google.com</option>
							<option value="kakao.com">kakao.com</option>
							<option value="nate.com">nate.com</option>
						</select>
					</td>
				</tr>
			</table>
			<button type="submit" class="btn green" id="signUpBtn" style="width: 750px; height: 50px;">회원가입</button>
			</div>
		</div>
	</div>
</body>
</html>