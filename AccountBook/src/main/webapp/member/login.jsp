<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 로그인</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function() {
		$("#login-btn").click(function() {
			let id = $("#userid").val();
			let pw = $("#pw").val();
			
			$.ajax({
				type: "post",
				url : "login",
				data : {
					userid : id,
					pw : pw
				},
				success : function(res) {
					if(res == "fail") {
						$("#login-fail-div").html("<p class='red'>아이디와 비밀번호가 일치하지 않습니다.</p>")
					} else {
						location.href = "../member/mypage.jsp";
					}
				}
			})
		})
	})
</script>
<style type="text/css">
	#login-btn {
		width: 450px;
		height: 55px;
		font-size: 20px;
		font-weight: bold;
	}
	#main-div {
		margin-top: 10%;
	}
	.signup-table {
		border-collapse: collapse;
		border-radius: 10px;
		width: 450px;
	}
	.signup-table td {
		border: 1px solid lightgray;
		padding: 10px;
		font-size: 20px;
		width: 450px;
	}
	.signup-table td div {
		float: left;
		margin: 5px;
	}
	.signup-table input {
		border: none;
		font-size: 18px;
		width: 350px;
	}
	.signup-table input:focus {
		outline: none;
	}
	
</style>
</head>
<body>
	<div>
		<div>
			<div class="container" id="main-div">
				<h2 class="fs40 main-color"><i class="fi fi-rs-user"></i> 로그인</h2>
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
				<div id="login-fail-div"></div>
				<br><br>
				<button type="submit" class="btn main-color-btn" id="login-btn">로그인</button>
			</div>
		</div>
	</div>
</body>
</html>