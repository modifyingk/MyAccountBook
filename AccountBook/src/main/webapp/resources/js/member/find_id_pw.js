document.write('<script src="../resources/js/function/emailFunc.js"></script>'); // 이메일 함수

$(function () {
	// 아이디 찾기 / 비밀번호 찾기 선택
	$(document).on("click", "#select-find td", function() {
		$("#select-find td").removeClass("active");
		$(this).addClass("active");
		if($(this).text() == "아이디 찾기") {
			$("#find-id-div").show();
			$("#find-pw-div").hide();
		} else if($(this).text() == "비밀번호 찾기"){
			$("#find-pw-div").show();
			$("#find-id-div").hide();
		}
	})
	
	$(document).ready(function() {
		selectAddress("#select-email-id", "#email2-id");
		selectAddress("#select-email-pw", "#email2-pw");
	})
	
	// 인증번호 전송
	$(document).on("click", "#send-code-btn", function() {
		let email = $("#email1-id").val() + "@" + $("#email2-id").val();
		if($("#email1-id").val() != "" && $("#email2-id").val() != "")
			sendCode(email);
		else
			alert("이메일을 정확히 입력해주세요.")
	})

	// 인증
	$(document).on("click", "#verify-code-btn", function() {
		let email = $("#email1-id").val() + "@" + $("#email2-id").val();
		let code = $("#code").val();
		
		$.ajax({
			type : "post",
			url : "verifyCode",
			data : {
				email: email,
				code: code
			},
			success : function(res) {
				if(res == true) {
					alert("인증되었습니다.");
					$("#find-id-btn").attr("disabled", false);
				}
				else
					alert("인증번호가 일치하지 않습니다.");
			}
		})
	})
	
	// 아이디 찾기
	$(document).on("click", "#find-id-btn", function() {
		let name = $("#username-id").val();
		let email = $("#email1-id").val() + "@" + $("#email2-id").val();
		let code = $("#code").val();
		
		if(name != "" && $("#email1-id").val() != "" && $("#email2-id").val() != "" && code != "") {
			let emailForm = "<input type='hidden' value='" + email + "' name='email' readonly>"
			$("#find-id-form").append(emailForm);
			$("#find-id-form").submit();
		} else
			alert("입력 값들을 확인해주세요.");
	})

	// 임시 비밀번호 발급
	$(document).on("click", "#find-pw-btn", function() {
		let id = $("#userid-pw").val();
		let name = $("#username-pw").val();
		let email = $("#email1-pw").val() + "@" + $("#email2-pw").val();

		if(id != "" && name != "" && $("#email1-pw").val() != "" && $("#email2-pw").val() != "") {
			$("html").css("cursor", "wait");
			$.ajax({
				type : "post",
				url : "findPw",
				data : {
					userid : id,
					username : name,
					email : email
				},
				success : function(res) {
					if(res == "ok") {
						$("html").css("cursor", "default");
						alert("입력하신 이메일로 임시 비밀번호가 전송되었습니다.")
						location.href = "../member/login.jsp";
					} else {
						$("html").css("cursor", "default");
						alert("입력 값들을 확인해주세요");
					}
				}
			})
		} else {
			alert("입력 값들을 확인해주세요");
		}
	})
})

//이메일 주소 선택
function selectAddress(chgVal, attrVal) {
	$(document).on("change", chgVal, function() {
		// 직접입력을 선택한 경우
		if($(this).val() == "self") {
			$(attrVal).val("");
		} else { // 직접입력이 아닌 주소를 선택한 경우
			$(attrVal).val($(this).val());
		}
	})
}