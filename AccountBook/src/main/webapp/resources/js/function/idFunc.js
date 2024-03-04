$(function() {
	// 아이디 중복 확인
	$.checkOverlapID = function(idVal) {
		var ovlpChk;
		$.ajax({
			type : "post",
			url : "overlapId",
			data : {
				userid : idVal
			},
			async : false,
			success : function(res) {
				ovlpChk = res;
			}
		})
		return ovlpChk;
	}
})

