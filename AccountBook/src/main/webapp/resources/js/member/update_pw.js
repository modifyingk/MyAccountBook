document.write('<script src="../resources/js/function/pwFunc.js"></script>'); // 비밀번호 확인 함수

$(function () {
	var pwChk = false;
	var pwChk2 = false;
	
	// 비밀번호 확인
	$(document).on("blur", "#pw, #pw2", function () {
		pwChk = checkPw("#pw", "#pwRegCheck");
		pwChk2 = checkPw2("#pw", "#pw2", "#pwCheck");
	})
	
	// 비밀번호 변경
	$(document).on("click", "#updatePwBtn", function() {
		if(pwChk && pwChk2) {
			$.ajax({
				type : "post",
				url : "updatePw",
				data : {
					userid : userid,
					pw : $("#pw").val()
				},
				success : function(res) {
					if(res == true) {
						alert("비밀번호가 성공적으로 변경되었습니다.");
						location.href = "myInfo.jsp";
					} else {
						alert("다시 시도해주세요");
					}
				}
			})
		} else {
			alert("입력 값을 다시 확인해주세요.");		
		}
	})
	
})