<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function() {
		$("#chgPwBtn").click(function() {
			location.href = "checkPw.jsp";
		})
		
		var userid = "<%= session.getAttribute("userid") %>";
		$.ajax({
			type : "post",
			url : "userInfo",
			data : {
				userid : userid
			},
			success : function(info) {
				var infoArr = info.split("/");
				
				var username = infoArr[0];
				var gender = infoArr[1];
				var birth = (infoArr[2]).split("-");
				
				$("#username").attr("value", username);
				
				if(gender == "남") {
					$("input[type=radio][value='남']").prop("checked", true);
				} else {
					$("input[type=radio][value='여']").prop("checked", true);
				}
				
				$("#year").attr("value", birth[0]);
				$("#month").val(birth[1]).prop("selected", true);
				$("#date").attr("value", birth[2]);
			}
		})
	})
</script>
</head>
<body>
	<div class="">
		<!-- 사이드바 -->
		<div class="left-20">
			<jsp:include page="../main/sidebar.jsp"></jsp:include>
		</div>
		
		<!-- 컨텐츠 -->
		<div class="right-80">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<div class="info-container">
					<h2 class="h2"><i class="fi fi-rs-user"></i> <%= session.getAttribute("userid") %></h2>
				<table class="info-table">
					<tr>
						<td class="field">아이디</td>
						<td><input class="signup-input" type="text" value="<%= session.getAttribute("userid") %>" maxlength="20"></td>
					</tr>
					<tr>
						<td class="field">비밀번호</td>
						<td><button class="btn outline-gray" id="chgPwBtn">비밀번호 변경</button></td>
					</tr>
					<tr>
						<td class="field">이름</td>
						<td><input class="signup-input" type="text" id="username" maxlength="10"></td>
					</tr>
					<tr>
						<td class="field">성별</td>
						<td>
							<div class="signup-select">
								<input type="radio" name="gender" id="male" value="남"><label for="male">남자</label>
								<input type="radio" name="gender" id="female" value="여"><label for="female">여자</label>
							</div>
						</td>
					</tr>
					<tr>
						<td class="field">생년월일</td>
						<td>
							<input class="signup-input birth" type="text" id="year" placeholder="년(4자)" maxlength="4">
							<select class="signup-input birth" id="month">
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
							<input class="signup-input birth" type="text" id="date" placeholder="일" maxlength="2">
						</td>
					</tr>
				</table>
				<button class="btn long green">개인정보 수정</button>
				<button class="btn long outline-green">회원탈퇴</button>
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