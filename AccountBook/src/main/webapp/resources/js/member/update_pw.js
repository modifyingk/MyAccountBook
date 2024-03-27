document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 비밀번호 확인 함수

$(function () {
	var pwChk = false;
	var pwChk2 = false;
	
	// 비밀번호 확인
	$(document).on("blur", "#pw, #pw2", function () {
		checkPw();
		checkPw2();
	})
	
	// 비밀번호 변경
	$(document).on("click", "#update-pw-btn", function() {
		if(checkPw() && checkPw2()) {
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
			alert("비밀번호를 다시 확인해주세요.");
		}
	})
})

function checkPw() {
	let pw = $("#pw").val();
	let div = $("#pw-check-div");
	
	let pwChk = checkPwReg(pw);
	if(pwChk) {
		div.html("");
		return true;
	} else {
		div.html("<p class='red'>8~16자 영문, 숫자, 특수문자 조합</p>");
		return false;
	}
}

function checkPw2() {
	let pw = $("#pw").val();
	let pw2 = $("#pw2").val();
	let div = $("#pw-equal-div");
	
	if(pw != pw2) {
		div.html("<p class='red'>비밀번호가 일치하지 않습니다.</p>");
		return false;
	} else {
		div.html("");
		return true;
	}
}