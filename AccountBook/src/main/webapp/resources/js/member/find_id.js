document.write('<script src="../resources/js/function/emailFunc.js"></script>'); // 이메일 함수

$(function () {
	$(document).ready(function() {
		// 이메일 주소 선택
		$.selectAddress("#selectEmail", "#email2");
	})
	
	// DB에 저장된 이름과 이메일 정보가 일치하는지 확인 후 메일 전송
	var code = 0;
	$(document).on("click", "#makeCodeBtn", function() {
		var email = $("#email1").val() + "@" + $("#email2").val();
		$.ajax({
			type : "post",
			url : "findId",
			data : {
				username : $("#username").val(),
				email : email
			},
			success : function(res) {
				if(res != "") { // 이름과 이메일 정보가 일치할 경우
					$("#email").attr("value", res[0].email);
					code = $.makeCode(email);
				} else {
					alert("이름과 이메일을 다시 확인해주세요");
				}
			}
		})	
	})

	// 인증하기 버튼 클릭
	$(document).on("click", "#verifCodeBtn", function() {
		if(code == 0) {
			alert("인증번호 받기를 클릭한 후 인증해주세요.")
		} else {
			var verif = $.verifCode(code, inputCode);
			if(verif) {
				$("#findidBtn").attr("disabled", false);
			} else {
				$("#findidBtn").attr("disabled", true);
			}
		}
	})
})