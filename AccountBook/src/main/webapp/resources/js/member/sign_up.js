document.write('<script src="../resources/js/function/htmlFunc.js"></script>');
document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 유효성 검사
document.write('<script src="../resources/js/function/emailFunc.js"></script>'); // 이메일
document.write('<script src="../resources/js/function/idFunc.js"></script>'); // 아이디 중복 확인

$(function () {
	$(document).ready(function() {
		$.onlyNum("#birth"); // 생년월일 숫자만 입력
		$.onlyLetter("#username"); // 이름 영어, 한글만 입력
		
		$.autoClose("#select-address-div"); // 이메일 주소 선택 닫기
	})
	
	// 이메일 주소 선택
	$(document).on("click", "#select-address-btn", function() {
		$("#select-address-div").show();
	})
	$(document).on("click", "#address-table tr", function() {
		let address = $(this).text();
		$("#address").val(address);
		$("#select-address-div").hide();
	})
	
	$(document).on("blur", "#userid", function() {
		checkId();
	})
	
	$(document).on("blur", "#pw", function() {
		checkPw();
	})
	
	$(document).on("blur", "#username", function() {
		checkName();
	})
	
	$(document).on("blur", "#birth", function() {
		checkBirth();
	})
	
	$(document).on("click", "#send-code-btn", function () {
		let email = $("#email").val() + "@" + $("#address").val();
		if(checkEmail())
			$.sendCode(email);
		else
			alert("이메일을 정확히 입력해주세요.")
	})

	// 회원가입
	$(document).on("click", "#signup-btn", function() {
		if(checkId() && checkPw && checkName() && checkBirth() && checkEmail()) {
			let id = $("#userid").val();
			let pw = $("#pw").val();
			let name = $("#username").val();
			let gender = $("input[name=gender]:checked").val();
			let birth = $("#birth").val();
			let email = $("#email").val() + "@" + $("#address").val();
			let code = $("#code").val();
			
			$.ajax({
				type : "post",
				url : "insertMember",
				data : {
					userid: id,
					pw: pw,
					username: name,
					gender: gender,
					birth: birth,
					email : email,
					code: code
				},
				success : function(res) {
					if(res == "ok") {
						location.href = "../member/login.jsp"
					} else if(res == "id_error") {
						alert("중복되는 아이디입니다.")
					} else if(res == "code_error") {
						alert("인증번호가 일치하지 않습니다.")
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

function checkId() {
	let id = $("#userid").val();
	let div = $("#id-check-div");
	
	let idChk = $.checkIDReg(id); // 아이디 형식 확인
	if(idChk) {
		div.hide();
		idChk = $.checkOverlapID(id); // 아이디 중복 확인
		if(idChk) {
			div.hide();
			return true;
		} else {
			div.show();
			div.html("<p class='red'>* 사용할 수 없는  아이디입니다</p>");
			return false;
		}
	} else {
		div.show();
		div.html("<p class='red'>* 영문자, 숫자, 언더바(_), 점(.)을 이용한 5~20자</p>");
		return false;
	}
}

function checkPw() {
	let pw = $("#pw").val();
	let div = $("#pw-check-div");
	
	let pwChk = $.checkPwReg(pw);
	if(pwChk) {
		div.hide();
		return true;
	} else {
		div.show();
		div.html("<p class='red'>* 8~16자 영문, 숫자, 특수문자 조합</p>");
		return false;
	}
}

function checkName() {
	let name = $("#username").val();
	let div = $("#name-check-div");
	
	let nameChk = $.checkNameReg(name);
	if(nameChk) {
		div.hide();
		return true;
	} else {
		div.show();
		div.html("<p class='red'>* 이름이 정확한지 확인해주세요</p>");
		return false;
	}
}

function checkBirth() {
	let birth = $("#birth").val();
	let div = $("#birth-check-div");
	
	let birthChk = $.checkBirthReg(birth);
	if(birthChk) {
		div.hide();
		return true;
	} else {
		div.show();
		div.html("<p class='red'>* 생년월일이 정확한지 확인해주세요</p>");
		return false;
	}
}

function checkGender() {
	let gender = $("input[name=gender]:checked").val(); // 선택 성별
	if(gender == "M" || gender == "F") {
		return true;
	} else {
		return false;
	}
}

function checkEmail() {
	let email = $("#email").val();
	let address = $("#address").val();
	
	if(email != "" && address != "")
		return true;
	else
		return false;
}