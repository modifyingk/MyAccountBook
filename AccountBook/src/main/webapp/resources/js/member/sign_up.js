document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 유효성 검사 함수
document.write('<script src="../resources/js/function/emailFunc.js"></script>'); // 이메일 함수
document.write('<script src="../resources/js/function/pwFunc.js"></script>'); // 비밀번호 확인 함수
document.write('<script src="../resources/js/function/birthFunc.js"></script>'); // 생년월일 함수
document.write('<script src="../resources/js/function/idFunc.js"></script>'); // 아이디 중복 확인 함수

$(function () {
	
	var idChk = false;
	var pwChk = false;
	var pwChk2 = false;
	var nameChk = false;
	var genderChk = false;
	var birthChk = false;
	var emailChk = false;
	
	$(document).ready(function() {
		// 숫자만 입력
		$.onlyNum("#year"); // 연도
		$.onlyNum("#date"); // 날짜
		
		// 영어, 한글만 입력
		$.onlyLetter("#username"); // 이름
		
		// 이메일 주소 선택
		$.selectAddress($("#selectEmail").val(), "#email2");
	})
	
	// 아이디 확인
	$(document).on("blur", "#userid", function() {
		idChk = $.checkIDReg($("#userid").val()); // 아이디 유효성 검사
		
		if(idChk) { // 정규식에 맞을 때
			$("#idCheck").children().removeClass("warning"); 
			$("#idCheck").children().addClass("info"); // 붉은색 경고 지우기
			
			$(document).on("click", "#overlapBtn", function() { // 아이디 중복 확인
				idChk = $.checkOverlapID($("#userid").val());
				if(idChk) { // 중복 x
					$("#idCheck").html("<p class='msg safe'>사용 가능한 아이디입니다</p>");
				} else { // 중복
					$("#idCheck").html("<p class='msg warning'>사용할 수 없는  아이디입니다</p>");
				}
			})
			
		} else { // 정규식에 맞지 않을 때
			$("#idCheck").children().removeClass("info"); 
			$("#idCheck").children().addClass("warning"); // 붉은색으로 경고
		}
	})
	
	// 비밀번호 확인
	$(document).on("blur", "#pw, #pw2", function () {
		pwChk = $.checkPw($("#pw").val(), "#pwRegCheck");
		pwChk2 = $.checkPw2($("#pw").val(), $("#pw2").val(), "#pwCheck");
	})
	
	// 이름 확인
	$(document).on("blur", "#username", function() {
		if(!$.checkNameReg($("#username").val())) { // 정규식에 맞지 않을 때
			$("#nameCheck").html("<p class='msg warning'>이름이 정확한지 확인해주세요</p>");
			nameChk = false;
		} else {
			$("#nameCheck").html("");
			nameChk = true;
		}
	})
	
	// 생년월일 잘못된 값 입력 방지
	$(document).on("blur", "#year, #month, #date", function() {
		birthChk = $.checkBirth($("#year").val(), $("#month").val(), $("#date").val(), "#birthCheck");
	})

	// 인증번호 받기 버튼 클릭
	var code = 0;
	$(document).on("click", "#makeCodeBtn", function () {
		var email = $("#email1").val() + "@" + $("#email2").val();
		code = $.makeCode(email);
	})
	
	// 인증하기 버튼 클릭
	$(document).on("click", "#verifCodeBtn", function() {
		if(code == 0) {
			alert("인증번호 받기를 클릭한 후 인증해주세요.")
		} else {
			emailChk = $.verifCode(code, inputCode);
		}
	})
	
	// 회원가입 버튼 클릭
	$(document).on("click", "#signUpBtn", function() {
		// 성별 선택 체크
		var gender = $("input[name=gender]:checked").val(); // 선택된 성별 값 gender 변수에 저장
		if(gender == "M" || gender == "F") { // gender가 M 또는 F라는 값을 가진다면
			genderChk = true;
		} else {
			genderChk = false;
		}
			
		// 생년월일 입력값 재확인
		if($("#month").val() == "월") {
			birthChk = false;
		}
		if($("#date").val() == "") {
			birthChk = false;
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
				success : function(res) {
					if(res == true) {
						location.href = "../member/login.jsp"
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