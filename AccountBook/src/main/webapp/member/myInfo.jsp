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
	var nameChk = true;
	var birthChk = true;
	
	$(function() {
		// 회원정보 수정 유효성 검사
		// 이름 형식 확인 (한글, 영어만 입력)
		$("#username").keyup(function() {
			var nameReg = /[^a-zA-zㄱ-ㅎㅏ-ㅣ가-힣]/g; // 영어, 한글이 아닌 값 정규식
			$(this).val($("#username").val().replace(nameReg, ""));
		})	
		$("#username").blur(function() {
			var nameReg = RegExp(/^[a-zA-Z가-힣]{2,10}$/); // 한글, 영어 2~10글자
			if(!nameReg.test($("#username").val())) {
				$("#nameCheck").html("<p class='msg warning'>이름이 정확한지 확인해주세요</p>");
				nameChk = false;
			} else {
				$("#nameCheck").html("");
				nameChk = true;
			}
		})
		// 숫자만 입력되도록 (생년월일)
		$("#year, #date").keyup(function() {
			var numReg = /[^0-9]/g;	// 숫자가 아닌 값 정규식
			$(this).val($(this).val().replace(numReg, ""));
		})
		// 생년월일 잘못된 값 입력방지
		$("#year, #month, #date").blur(function() {
			var today = new Date();
			if($("#year").val() > today.getFullYear() || $("#year").val() < today.getFullYear() - 100) { // 현재연도보다 늦은 연도를 입력하거나 현재연도로부터 100년전 연도를 입력할 경우
				$("#birthCheck").html("<p class='msg warning'> 생년월일이 정확한지 확인해주세요</p>");
				birthChk = false;
			} else if($("#year").val() == today.getFullYear()) { // 현재연도와 입력연도가 같을 때
				if($("#month").val() > today.getMonth() + 1) { // 현재 월보다 클 때
					$("#birthCheck").html("<p class='msg warning'> 생년월일이 정확한지 확인해주세요</p>");
					birthChk = false;
				} else if($("#month").val() == today.getMonth() + 1) { // 현재 월과 같을 때
					if($("#date").val() > today.getDate()) { // 현재 일보다 크면
						$("#birthCheck").html("<p class='msg warning'> 생년월일이 정확한지 확인해주세요</p>");
						birthChk = false;
					} else {
						$("#birthCheck").html("");
						birthChk = true;
					}
				} else {
					$("#birthCheck").html("");
					birthChk = true;
				}
			} else {
				$("#birthCheck").html("");
				birthChk = true;
			}
		})
		$("#date").blur(function() {
			// 일 값이 1에서 31까지만 입력 가능하도록
			if($("#date").val() > 31 || $("#date").val() < 1) {
				$("#birthCheck").html("<p class='msg warning'> 생년월일이 정확한지 확인해주세요</p>");
				birthChk = false;
			} else {
				$("#birthCheck").html("");
				birthChk = true;
			}
		})
		
		var userid = "<%= session.getAttribute("userid") %>";
		// 현재 세션의 정보 가져오기
		$.ajax({
			type : "post",
			url : "userInfo",
			data : {
				userid : userid
			},
			success : function(info) {
				var username = info.username;
				var gender = info.gender;
				var birth = info.birth.split("-");
				
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

		// 비밀번호 변경 클릭 시 비밀번호 변경 페이지로
		$("#chgPwBtn").click(function() {
			location.href = "check_pw.jsp";
		})
		
		// 개인정보 변경 클릭 시
		$("#updateMemBtn").click(function() {
			if(nameChk && birthChk) {
				$.ajax({
					type : "post",
					url : "updateMember",
					data : {
						userid : userid,
						username : $("#username").val(),
						gender : $("input[name=gender]:checked").val(),
						birth : $("#year").val() + $("#month").val() + $("#date").val()
					},
					success : function(x) {
						if(x == "success") {
							alert("회원정보가 수정되었습니다.");
						} else {
							alert("다시 시도해주세요.");
						}
					}
				})
			} else {
				alert("입력 값을 다시 확인해주세요");				
			}
		})
		
		// 회원탈퇴 클릭 시
		$("#deleteMemBtn").click(function() {
			var op = confirm("정말로 탈퇴하시겠습니까?");
			if(op) {
				var chkID = prompt("탈퇴하실 아이디를 입력하시면 성공적으로 탈퇴가 완료됩니다.");
				if(chkID == userid) {
					$.ajax({
						type : "post",
						url : "deleteMember",
						data : {
							userid : userid
						},
						success : function(x) {
							if(x == "success") {
								alert("탈퇴가 성공적으로 완료되었습니다.");
								location.href = "logout";
							} else {
								alert("다시 시도해주세요.");
							}
						}
					})
				} else if(chkID == null){
					
				} else {
					alert("입력하신 값과 아이디가 일치하지않습니다.")
				}
			}
		})
	})
</script>
</head>
<body>
	<div>
		<!-- 사이드바 -->
		<div class="col-2 is-border is-shadow">
			<jsp:include page="../main/sidebar.jsp"></jsp:include>
			<img src="../resources/img/logo.png" style="width: 90%;" onclick="location.href='../main/main.jsp'">
			<ul class="menu-group">
				<li class="menu active"><i class="fi fi-rr-home"></i> 메인페이지</li>
				<li class="menu"><i class="fi fi-rr-add"></i> 수입/지출 관리</li>		
				<li class="menu"><i class="fi fi-rr-coins"></i> 자산관리</li>		
				<li class="menu"><i class="fi fi-rs-calendar-check"></i> 캘린더</li>		
				<li class="menu"><i class="fi fi-rs-chart-histogram"></i> 목표 관리</li>
			</ul>
		</div>
		
		<!-- 컨텐츠 -->
		<div class="col-8 is-center">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<div class="container margin-medium is-border width-50">
					<h2 class="h-normal fs-35"><i class="fi fi-rs-user"></i> <%= session.getAttribute("userid") %></h2>
				<table class="table">
					<tr>
						<th>비밀번호</th>
						<td><button class="btn medium outline-gray" id="chgPwBtn">비밀번호 변경</button></td>
					</tr>
					<tr>
						<th>이름</th>
						<td>
							<input class="input" type="text" id="username" maxlength="10">
							<div id="nameCheck"></div>					
						</td>
					</tr>
					<tr>
						<th>성별</th>
						<td>
							<div class="select">
								<input type="radio" name="gender" id="male" value="남"><label for="male">남자</label>
								<input type="radio" name="gender" id="female" value="여"><label for="female">여자</label>
							</div>
						</td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>
							<input class="input small" type="text" id="year" placeholder="년(4자)" maxlength="4">
							<select class="input small" id="month">
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
							<input class="input small" type="text" id="date" placeholder="일" maxlength="2">
							<div id="birthCheck"></div>
						</td>
					</tr>
				</table>
				<button class="btn medium green" id="updateMemBtn">개인정보 수정</button>
				<button class="btn medium outline-green" id="deleteMemBtn">회원탈퇴</button>
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