$(function() {
	// 인증번호 전송
	$.sendCode = function(emailVal) {
		const t0 = performance.now();
		$.ajax({
			type : "post",
			url : "sendCode",
			data : {
				email : emailVal
			},
			success : function(res) {
				const t1 = performance.now();
				console.log((t1 - t0) + "ms");
				alert("인증메일이 발송되었습니다.");
			}
		})
	}
})
