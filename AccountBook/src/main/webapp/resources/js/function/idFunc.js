$(function() {
	// 아이디 중복 확인
	$.checkOverlapID = function(idVal) {
		var ovlpChk;
		$.ajax({
			type : "post",
			url : "isOverlapId",
			data : {
				userid : idVal
			},
			async : false,
			success : function(res) {
				if(res == true) {
					ovlpChk = true;
				}
				else {
					ovlpChk = false;
				}
			}
		})
		return ovlpChk;
	}
})

