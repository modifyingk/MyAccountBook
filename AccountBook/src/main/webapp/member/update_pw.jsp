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
	var pwChk = false;
	var pwChk2 = false;
	
	$(function() {
		// 비밀번호  확인
		$("#pw, #pw2").blur(function() {
			var pwReg = RegExp(/^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{10,20}/);
			if(!pwReg.test($("#pw").val())){
				$("#pwRegCheck").html("<p class='warningMsg'>10 ~ 20자 영문, 숫자, 특수문자 조합</p>");
				pwChk = false;
			} else {
				$("#pwRegCheck").html("<p class='infoMsg'>10 ~ 20자 영문, 숫자, 특수문자 조합</p>");
				pwChk = true;
			}
			if($("#pw2").val() != $("#pw").val()) { // 비밀번호가 일치하지 않는 경우
				$("#pwCheck").html("<p class='warningMsg'>비밀번호가 일치하지 않습니다</p>");
				pwChk2 = false;
			} else { // 비밀번호가 일치하는 경우
				$("#pwCheck").html("");
				pwChk2 = true;
			}
		})
		
		var userid = "<%= session.getAttribute("userid") %>";
		
		$("#updatePwBtn").click(function() {
			if(pwChk && pwChk2) {
				$.ajax({
					type : "post",
					url : "updatePw",
					data : {
						userid : userid,
						pw : $("#pw").val()
					},
					success : function(x) {
						if(x == "success") {
							alert("비밀번호가 성공적으로 변경되었습니다.");
							location.href = "myInfo.jsp";
						} else {
							alert("다시 시도해주세요");
						}
					}
				})
			} else {
				alert("입력 값을 다시 확인해주세요.");		
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
					<h3 class="h3"><i class="fi fi-rr-key"></i> 비밀번호 변경</h3>
				<table class="info-table">
					<tr>
						<td class="field">변경할 비밀번호</td>
						<td>
							<input class="signup-input" type="password" id="pw" maxlength="20">
							<div class="checkDiv" id="pwRegCheck"><p class='infoMsg'>10 ~ 20자 영문, 숫자, 특수문자 조합</p></div>
						</td>
					</tr>
					<tr>
						<td class="field">비밀번호 확인</td>
						<td>
							<input class="signup-input" type="password" id="pw2" maxlength="20">
							<div class="checkDiv" id="pwCheck"></div>
						</td>
					</tr>
				</table>
				<button class="btn long green" id="updatePwBtn">변경</button>
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