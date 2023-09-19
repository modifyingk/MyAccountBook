$(function () {
	// 숫자만 입력 가능
	$.onlyNum = function (docID) {
		$(document).on("keyup", docID, function() {
			var numReg = /[^0-9]/g;	// 숫자가 아닌 값 정규식
			$(this).val($(this).val().replace(numReg, ""));
		})
	}
	
	// 영어, 한글만 입력 가능
	$.onlyLetter = function(docID) {
		$(document).on("keyup", docID, function() {
			var letterReg = /[^a-zA-z가-힣]/g; // 영어, 한글이 아닌 값 정규식
			$(this).val($(this).val().replace(letterReg, "")); // 영어, 한글이 아닌 값 지우기
		})
	}
	
	// 아이디 형식 확인
	$.checkIDReg = function(docID) {
		var idReg = RegExp(/^[a-zA-Z0-9_\.]{5,20}$/);
		return idReg.test($(docID).val());
	}
	
	// 비밀번호 형식 확인
	$.checkPwReg = function(docID) {
		var pwReg = RegExp(/^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{10,20}/);
		return pwReg.test($(docID).val());
	}
	
	// 이름 형식 확인
	$.checkNameReg = function(docID) {
		var nameReg = RegExp(/^[a-zA-Z가-힣]{2,10}$/); // 한글, 영어 2~10글자
		return nameReg.test($(docID).val());
	}
	
	// 아이디 확인
	$.checkID = function(userid, chkDiv) {
		// 아이디 확인
		if(!$.checkIDReg(userid)){ // 정규식에 맞지 않을 때
			$(chkDiv).html("<p class='msg warning'>영문자, 숫자, 언더바(_), 점(.)을 이용한 5~20자</p>");
			return false;
		} else {
			$(chkDiv).html("<p class='msg info'>영문자, 숫자, 언더바(_), 점(.)을 이용한 5~20자</p>");
			return true;
		}
	}
	
	// 아이디 중복 확인
	$.checkOverlapID = function(userid, chkDiv, overlapBtn) {
		$.ajax({
			type : "post",
			url : "isOverlapId",
			data : {
				userid : $(userid).val()
			},
			success : function(x) {
				if(x == "possible") {
					$(chkDiv).html("<p class='msg safe'>사용 가능한 아이디입니다</p>");
					return true;
				}
				else {
					$(chkDiv).html("<p class='msg warning'>사용할 수 없는  아이디입니다</p>");
					return false;
				}
			}
		})
	}
	
	// 비밀번호 확인
	$.checkPw = function(pwID, pwRegChkID) {
		if(!$.checkPwReg(pwID)){ // 정규식에 맞지 않을 때
			$(pwRegChkID).html("<p class='msg warning'>10 ~ 20자 영문, 숫자, 특수문자 조합</p>");
			return false;
		} else {
			$(pwRegChkID).html("<p class='msg info'>10 ~ 20자 영문, 숫자, 특수문자 조합</p>");
			return true;
		}
	}
	$.checkPw2 = function(pwID, pwID2, pwChkID) {
		if($(pwID2).val() != $(pwID).val()) { // 비밀번호 확인 값이 일치하지 않는 경우
			$(pwChkID).html("<p class='msg warning'>비밀번호가 일치하지 않습니다</p>");
			return false;
		} else {
			$(pwChkID).html("");
			return true;
		}
	}
	
	// 생년월일 잘못된 값 입력방지
	$.checkBirth = function(yearID, monthID, dateID, chkDiv) {
		var today = new Date();
		if($(yearID).val() > today.getFullYear() || $(yearID).val() < today.getFullYear() - 100) { // 현재연도보다 늦은 연도를 입력하거나 현재연도로부터 100년전 연도를 입력할 경우
			$(chkDiv).html("<p class='msg warning'> 생년월일이 정확한지 확인해주세요</p>");
			return false;
		} else if($(yearID).val() == today.getFullYear()) { // 현재연도와 입력연도가 같을 때
			if($(monthID).val() > today.getMonth() + 1) { // 현재 월보다 클 때
				$(chkDiv).html("<p class='msg warning'> 생년월일이 정확한지 확인해주세요</p>");
				return false;
			} else if($(monthID).val() == today.getMonth() + 1) { // 현재 월과 같을 때
				if($(dateID).val() > today.getDate()) { // 현재 일보다 크면
					$(chkDiv).html("<p class='msg warning'> 생년월일이 정확한지 확인해주세요</p>");
					return false;
				} else {
					$(chkDiv).html("");
					return true;
				}
			} else {
				$(chkDiv).html("");
				return true;
			}
		} else {
			$(chkDiv).html("");
			return true;
		}
	}
	$.checkDate = function(dateID, chkDiv) {
		// 일 값이 1에서 31까지만 입력 가능하도록
		if($(dateID).val() > 31 || $(dateID).val() < 1) {
			$(chkDiv).html("<p class='msg warning'> 생년월일이 정확한지 확인해주세요</p>");
			return false;
		} else {
			$(chkDiv).html("");
			return true;
		}
	}
})