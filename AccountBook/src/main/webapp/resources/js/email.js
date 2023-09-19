$(function() {
	// 이메일 주소 선택
	$.selectAddress = function(chgID, attrID) {
		$(document).on("change", chgID, function() {
			// 직접입력을 선택한 경우
			if($(this).val() == "self") {
				$(attrID).attr("value", "");
			} else { // 직접입력이 아닌 주소를 선택한 경우
				$(attrID).attr("value", $(this).val());
			}
		})
	}
	
	// 인증번호 생성
	$.makeCode = function(emailID) {
		var code;
		$.ajax({
			type : "post",
			url : "sendCode",
			async : false,
			data : {
				email : emailID
			},
			success : function(x) {
				alert("인증메일이 발송되었습니다.");
				code = x;
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