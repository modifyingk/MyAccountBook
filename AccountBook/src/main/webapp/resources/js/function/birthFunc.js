$(function() {
	$.checkBirth = function(birthVal) {
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
	/*
	// 생년월일 잘못된 값 입력방지
	$.checkBirth = function(yearID, monthID, dateID, chkDiv) {
		var today = new Date();
		if(yearID > today.getFullYear() || yearID < today.getFullYear() - 100) { // 현재연도보다 늦은 연도를 입력하거나 현재연도로부터 100년전 연도를 입력할 경우
			$(chkDiv).html("<p class='msg warning'> 생년월일이 정확한지 확인해주세요</p>");
			return false;
		} else if(yearID == today.getFullYear()) { // 현재연도와 입력연도가 같을 때
			if(monthID > today.getMonth() + 1) { // 현재 월보다 클 때
				$(chkDiv).html("<p class='msg warning'> 생년월일이 정확한지 확인해주세요</p>");
				return false;
			} else if(monthID == today.getMonth() + 1) { // 현재 월과 같을 때
				if(dateID > today.getDate()) { // 현재 일보다 크면
					$(chkDiv).html("<p class='msg warning'> 생년월일이 정확한지 확인해주세요</p>");
					return false;
				} else {
					if(dateID > 31 || dateID < 1) {
						$(chkDiv).html("<p class='msg warning'> 생년월일이 정확한지 확인해주세요</p>");
						return false;
					} else {
						$(chkDiv).html("");
						return true;
					}
				}
			} else { // 나머지 경우는 날짜가 1~31 사이여야함
				if(dateID > 31 || dateID < 1) {
					$(chkDiv).html("<p class='msg warning'> 생년월일이 정확한지 확인해주세요</p>");
					return false;
				} else {
					$(chkDiv).html("");
					return true;
				}
			}
		} else {
			if(dateID > 31 || dateID < 1) {
				$(chkDiv).html("<p class='msg warning'> 생년월일이 정확한지 확인해주세요</p>");
				return false;
			} else {
				$(chkDiv).html("");
				return true;
			}
		}
	}*/
})

