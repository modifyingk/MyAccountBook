// 비밀번호 형식 확인
function checkPw(pwVal, divID) {
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