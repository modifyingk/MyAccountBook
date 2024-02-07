$(function() {
	// 이메일 주소 선택
	$.selectAddress = function(chgVal, attrVal) {
		$(document).on("change", chgVal, function() {
			// 직접입력을 선택한 경우
			if($(this).val() == "self") {
				$(attrVal).attr("value", "");
			} else { // 직접입력이 아닌 주소를 선택한 경우
				$(attrVal).attr("value", $(this).val());
			}
		})
	}
	
	// 인증번호 생성
	$.makeCode = function(emailVal) {
		var code;
		$.ajax({
			type : "post",
			url : "sendCode",
			async : false,
			data : {
				email : emailVal
			},
			success : function(res) {
				alert("인증메일이 발송되었습니다.");
				code = res;
			}
		})
		return code;
	}
	
	// 인증번호 확인
	$.verifCode = function(code, inputCodeID) {
		var inputCode = $(inputCodeID).val();
		if(code == inputCode) {
			alert("인증되었습니다.");
			return true;
		}
		else {
			alert("인증에 실패하였습니다.");
			return false;
		}
	}
})