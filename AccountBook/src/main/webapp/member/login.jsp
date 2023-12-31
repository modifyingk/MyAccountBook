<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 로그인</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function() {
		if($(location).attr("href").includes("sign_up")){
			$("#signupMenu").addClass("active");
		}
		
		$("#loginBtn").click(function() {
			$.ajax({
				type: "post",
				url : "login",
				data : {
					userid : $("#userid").val(),
					pw : $("#pw").val()
				},
				success : function(x) {
					if(x == "fail") {
						$("#loginFail").html("<p class='msg warning'>아이디와 비밀번호가 일치하지 않습니다.</p>")
					} else {
						location.href = "../main/main.jsp";
					}
				}
			})
		})
	})
</script>
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
					<li class="menu"><i class="fi fi-rs-user-add"></i> 회원가입</li>
					<li class="menu active"><i class="fi fi-rs-user"></i> 로그인</li>		
					<li class="menu"><i class="fi fi-rr-search"></i> 아이디 찾기</li>		
					<li class="menu"><i class="fi fi-rr-search"></i> 비밀번호 찾기</li>		
				</ul>
			</div>

			<!-- 컨텐츠 -->
			<div class="col-7 is-center">
				<div class="container margin-big">
				<h2 class="h-normal fs-35"><i class="fi fi-rs-user"></i> 로그인</h2>
				<br>
				<table class="table">
					<tr>
						<th>아이디</th>
						<td>
							<div>
								<input class="input" type="text" id="userid" maxlength="20">
							</div>
						</td>
					</tr>
					<tr>
						<th>비밀번호</th>
						<td>
							<div>
								<input class="input" type="password" id="pw" maxlength="20">
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2"><div id="loginFail"></div></td>
					</tr>
				</table>
				<button type="submit" class="btn long green" id="loginBtn">로그인</button>
				<br><br>
				<a href="../member/find_id.jsp">아이디 찾기</a>
				<a href="../member/find_pw.jsp">비밀번호 찾기</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>