
// 인증번호 전송
function sendCode(emailVal) {
	$.ajax({
		type : "post",
		url : "sendCode",
		data : {
			email : emailVal
		},
		success : function(res) {
			alert("인증메일이 발송되었습니다.");
		}
	})
}

