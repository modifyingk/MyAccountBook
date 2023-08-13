<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 회원가입</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	var idChk = false;
	var pwChk = false;
	var pwChk2 = false;
	var nameChk = false;
	var genderChk = false;
	var birthChk = false;
	var emailChk = false;
	
	$(function() {
		
		// 아이디 형식 확인
		$("#userid").blur(function() {
			// 영문자, 숫자, 언더바(_), 점(.) 조합 5~20자
			var idReg = RegExp(/^[a-zA-Z0-9_\.]{5,20}$/);
			
			if(!idReg.test($("#userid").val())){ // 정규식에 맞지 않을 때
				$("#idCheck").html("<p class='warningMsg'>영문자, 숫자, 언더바(_), 점(.)을 이용한 5~20자</p>");
				idChk = false;
			} else {
				$("#idCheck").html("<p class='infoMsg'>영문자, 숫자, 언더바(_), 점(.)을 이용한 5~20자</p>");
				
				// 아이디 중복 확인
				$("#overlapBtn").click(function() {
					$.ajax({
						type : "post",
						url : "isOverlapId",
						data : {
							userid : $("#userid").val()
						},
						success : function(x) {
							if(x == "possible") {
								$("#idCheck").html("<p class='safeMsg'>사용 가능한 아이디입니다</p>");
								idChk = true;
							}
							else {
								$("#idCheck").html("<p class='warningMsg'>사용할 수 없는  아이디입니다</p>");
								idChk = false;
							}
						}
					})
				})
			}
		})
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
		$("#username").keyup(function() {
			var nameReg = /[^a-zA-zㄱ-ㅎㅏ-ㅣ가-힣]/g; // 영어, 한글이 아닌 값 정규식
			$(this).val($("#username").val().replace(nameReg, ""));
		})	
		$("#username").blur(function() {
			var nameReg = RegExp(/^[a-zA-Z가-힣]{2,10}$/); // 한글, 영어 2~10글자
			if(!nameReg.test($("#username").val())) {
				$("#nameCheck").html("<p class='warningMsg'>이름이 정확한지 확인해주세요</p>");
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
				$("#birthCheck").html("<p class='warningMsg'> 생년월일이 정확한지 확인해주세요</p>");
				birthChk = false;
			} else if($("#year").val() == today.getFullYear()) { // 현재연도와 입력연도가 같을 때
				if($("#month").val() > today.getMonth() + 1) { // 현재 월보다 클 때
					$("#birthCheck").html("<p class='warningMsg'> 생년월일이 정확한지 확인해주세요</p>");
					birthChk = false;
				} else if($("#month").val() == today.getMonth() + 1) { // 현재 월과 같을 때
					if($("#date").val() > today.getDate()) { // 현재 일보다 크면
						$("#birthCheck").html("<p class='warningMsg'> 생년월일이 정확한지 확인해주세요</p>");
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
				$("#birthCheck").html("<p class='warningMsg'> 생년월일이 정확한지 확인해주세요</p>");
				birthChk = false;
			} else {
				$("#birthCheck").html("");
				birthChk = true;
			}
		})
		// 인증번호 받기 버튼 클릭
		$("#makeCodeBtn").click(function() {
			var email = $("#email1").val() + "@" + $("#email2").val();
			$.ajax({
				type : "post",
				url : "sendCode",
				data : {
					email : email
				},
				success : function(x) {
					alert("인증메일이 발송되었습니다.")
					// 인증번호 확인 버튼
					$("#verifCodeBtn").click(function() {
						var code = $("#inputCode").val();
						if(x == code) {
							alert("인증되었습니다.");
							emailChk = true;
						}
						else {
							alert("인증에 실패하였습니다.");
							emailChk = false;
						}
					})
				}
			})
		})		
		// 회원가입 버튼 클릭
		$("#signUpBtn").click(function() {
			// 성별 선택 체크
			var gender = $("input[name=gender]:checked").val(); // 선택된 성별 값 gender 변수에 저장
			if(gender == "남" || gender == "여") { // gender가 남 또는 여라는 값을 가진다면
				genderChk = true;
			} else {
				genderChk = false;
			}
			// 회원가입
			if(idChk && pwChk && pwChk2 && nameChk && genderChk && birthChk && emailChk) {	// 모든 입력값에 문제가 없다면
				if($("#date").val().length == 1) {
					var date = "0" + $("#date").val();
				} else {
					var date = $("#date").val();
				}
				var birth = $("#year").val() + $("#month").val() + date;
				var email = $("#email1").val() + "@" + $("#email2").val();
				$.ajax({
					type : "post",
					url : "insertMember",
					data : {
						userid : $("#userid").val(),
						pw : $("#pw").val(),
						username : $("#username").val(),
						gender : gender,
						birth : birth,
						tel : $("#tel").val(),
						email : email
					},
					success : function(x) {
						if(x == "success") {
							location.href = "../main/main.jsp"
						} else {
							alert("회원가입에 실패했습니다. 다시 시도해주세요!)");
						}
					}
				})
			} else {
				alert("입력 값들을 확인해주세요")
			}
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
					<li class="menu active"><i class="fi fi-rs-user-add"></i> 회원가입</li>
					<li class="menu"><i class="fi fi-rs-user"></i> 로그인</li>		
					<li class="menu"><i class="fi fi-rr-search"></i> 아이디 찾기</li>		
					<li class="menu"><i class="fi fi-rr-search"></i> 비밀번호 찾기</li>		
				</ul>
			</div>

			<!-- 컨텐츠 -->
			<div class="right-70">
				<div class="signup-container">
				<h2 class="h2"><i class="fi fi-rs-user-add"></i> 회원가입</h2>
				<br>
				<table class="signup-table">
					<tr>
						<td class="field">아이디</td>
						<td>
							<div>
								<input class="signup-input" type="text" id="userid" maxlength="20">
								<button type="button" class="btn green" id="overlapBtn">중복확인</button>
							</div>
							<div class="checkDiv" id="idCheck"><p class='infoMsg'>영문자, 숫자, 언더바(_), 점(.)을 이용한 5~20자</p></div>
						</td>
					</tr>
					<tr>
						<td class="field">비밀번호</td>
						<td>
							<div>
								<input class="signup-input" type="password" id="pw" maxlength="20">
							</div>
							<div class="checkDiv" id="pwRegCheck"><p class='infoMsg'>10 ~ 20자 영문, 숫자, 특수문자 조합</p></div>
						</td>
					</tr>
					<tr>
						<td class="field">비밀번호 확인</td>
						<td>
							<div>
								<input class="signup-input" type="password" id="pw2" maxlength="16">
							</div>
							<div class="checkDiv" id="pwCheck"></div>
						</td>
					</tr>
					<tr>
						<td class="field">이름</td>
						<td>
							<div>
								<input class="signup-input" type="text" id="username" maxlength="10">
							</div>
							<div class="checkDiv" id="nameCheck"></div>
						</td>
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
							<div class="checkDiv" id="birthCheck"></div>
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
								<button class="btn green" id="makeCodeBtn">인증번호 받기</button>
							</div>
							<div style="margin-top: 10px;">
								<input class="signup-input" type="text" id="inputCode">
								<button class="btn outline-green" id="verifCodeBtn">인증하기</button>
							</div>
						</td>
					</tr>
				</table>
				<button type="submit" class="btn green" id="signUpBtn">회원가입</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>