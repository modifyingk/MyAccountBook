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
<script type="text/javascript">
	$(function() {
		// 아이디 중복 확인
		$("#overlapBtn").click(function() {
			$.ajax({
				type : "post",
				url : "isOverlapId",
				data : {
					userid : $("#userid").val()
				},
				success : function(x) {
					$("#overlapCheck").html(x);
				}
			})
		})
		// 비밀번호 확인
		$("#pw2").keyup(function() {
			if($("#pw2").val() != $("#pw").val()) { // 비밀번호가 일치하지 않는 경우
				$("#pwCheck").html("<p style='color : red; font-size: 14px;'>비밀번호가 일치하지 않습니다.</p>");
			} else { // 비밀번호가 일치하는 경우
				$("#pwCheck").html("");
			}
		})
	})
</script>
</head>
<body>
	<div>
		<!-- 메누 -->
		<div class="sidebar">
			<jsp:include page="../menu.jsp"></jsp:include>
		</div>

		<!-- 내용 -->
		<div class="content">
			<h3 class="h3"><i class="fi fi-rs-user-add"></i> 회원가입</h3>
			<div class="container" style="border: 1px solid lightgray; border-radius: 10px; width: 750px; padding: 0 20px 20px 20px;">
			<h3 class="h4">회원가입</h3>
			<table class="table">
				<tr>
					<td>아이디</td>
					<td><input class="input" type="text" id="userid"><div id="overlapCheck"></div></td>
					<td><button type="button" class="btn green" id="overlapBtn">중복확인</button></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input class="input" type="password" id="pw"></td>
					<td></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input class="input" type="password" id="pw2"><div id="pwCheck"></div></td>
					<td></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input class="input" type="text" id="username"></td>
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
						<input class="input birth" type="text" id="year" placeholder="년(4자)">
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
						<input class="input birth" type="text" id="day" placeholder="일">
					</td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td colspan="2">
						<input class="input tel" type="text" id="tel"> -
						<input class="input tel" type="text" id="tel2"> -
						<input class="input tel" type="text" id="tel3">
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td colspan="2">
						<input class="input email" type="text" id="email1"> @
						<input class="input email" type="text" id="email2">
						<select class="input email">
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