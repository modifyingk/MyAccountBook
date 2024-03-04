$(function () {
	
	// 아이디 형식 확인
	$.checkIDReg = function(idVal) {
		var idReg = RegExp(/^[a-zA-Z0-9_\.]{5,20}$/);
		return idReg.test(idVal);
	}
	
	// 비밀번호 형식 확인
	$.checkPwReg = function(pwVal) {
		var pwReg = RegExp(/^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}/);
		return pwReg.test(pwVal);
	}
	
	// 이름 형식 확인
	$.checkNameReg = function(nameVal) {
		var nameReg = RegExp(/^[가-힣]{2,20}|[a-zA-Z]{2,10}\s?[a-zA-Z]{0,10}$/); // 한글, 영어 2~20 글자
		return nameReg.test(nameVal);
	}

	// 생년월일 확인
	$.checkBirthReg = function(birthVal) {
		if(birthVal.length != 8)
			return false;
		else {
			let year = parseInt(birthVal.substring(0, 4));
			let month = parseInt(birthVal.substring(4, 6));
			let day = parseInt(birthVal.substring(6, 8));
			
			let date = new Date();
			let todayYear = date.getFullYear();
			
			if(year < todayYear && year >= todayYear - 100 && month >= 1 && month <= 12 && day >= 1 && day <= 31)
				return true;
			else
				return false;
		}
	}
	
	// 작명 형식 확인
	$.checkNamingReg = function(nameVal) {
		var cateReg = RegExp(/^.{1,20}$/); // 모든 문자 1글자에서 20글자 사이
		return cateReg.test(nameVal);
	}

	// 한 글자 이상 입력 확인
	$.checkMustReg = function(val) {
		var mustReg = RegExp(/^.{1,}$/);
		return mustReg.test(val);
	}

	// 작명 형식 확인 후 메시지
	$.checkNaming = function(nameVal, chkDiv) {
		if(!$.namingReg(nameVal)) {
			$(chkDiv).attr("class", "msg warning");
			return false;
		} else {
			$(chkDiv).attr("class", "msg info");
			return true;
		}
	}
	
	// 숫자만 입력 가능
	$.onlyNum = function (docID) {
		$(document).on("keyup", docID, function() {
			var numReg = /[^0-9]/g;	// 숫자가 아닌 값 정규식
			$(this).val($(this).val().replace(numReg, ""));
		})
	}
	
	// 금액 입력
	$.onlyNumHypen = function(docID) {
		$(document).on("keyup", docID, function() {
			var numReg = /[^0-9-]/g;	// 숫자가 아닌 값 정규식
			$(this).val($(this).val().replace(numReg, ""));
		})
	}
	
	// 숫자 세자리마다 콤마
	$.moneyFmt = function(docID) {
		$(document).on("keyup", docID, function() {
			if($(this).val().length > 0) {
				if($(this).val() != "-") {
					$(this).val(parseInt($(this).val()).toLocaleString());
				}
			}
		})
	}
	
	// 영어, 한글만 입력 가능
	$.onlyLetter = function(docID) {
		$(document).on("keyup", docID, function() {
			var letterReg = /[^a-zA-z가-힣\s]/g; // 영어, 한글이 아닌 값 정규식 (공백 입력 가능)
			$(this).val($(this).val().replace(letterReg, "")); // 영어, 한글이 아닌 값 지우기
		})
	}
})