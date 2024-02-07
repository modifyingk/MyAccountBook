$(function() {
	// 비밀번호 형식 확인
	$.checkPw = function(pwVal, divID) {
		if(!$.checkPwReg(pwVal)){ // 정규식에 맞지 않을 때
			$(divID).children().removeClass("info"); 
			$(divID).children().addClass("warning"); // 붉은색으로 경고
			return false;
		} else {
			$(divID).children().removeClass("warning"); 
			$(divID).children().addClass("info"); // 붉은색 경고 지우기
			return true;
		}
	}
	
	// 비밀번호 확인값 일치 확인
	$.checkPw2 = function(pwVal, pw2Val, divID) {
		if(pwVal != pw2Val) { // 비밀번호 확인 값이 일치하지 않는 경우
			$(divID).html("<p class='msg warning'>비밀번호가 일치하지 않습니다</p>");
			return false;
		} else {
			$(divID).html("");
			return true;
		}
	}
})

