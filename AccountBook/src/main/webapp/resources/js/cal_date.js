$(function() {
	// 현재 연도와 월 가져오기
	$.currentYM = function() {
		var today = new Date();
		var todayYear = today.getFullYear();
		var todayMonth = today.getMonth() + 1 + "";
		
		if(todayMonth.length == 1) { // 한자리 숫자일 경우 앞에 0 붙여주기
			todayMonth = "0" + todayMonth;
		}
		var todayAll = todayYear + "-" + todayMonth;
		
		return todayAll;
	}
	
	// 현재 날짜 가져오기
	$.currentDate = function() {
		var today = new Date();
		var todayYear = today.getFullYear(); // 연도
		var todayMonth = today.getMonth() + 1 + ""; // 월
		
		if(todayMonth.length == 1) { // 한자리 숫자일 경우 앞에 0 붙여주기
			todayMonth = "0" + todayMonth;
		}
		var todayDate = today.getDate(); // 일
		
		var todayAll = todayYear + "-" + todayMonth + "-" + todayDate;
		
		return todayAll;
	}
	
	// 이전 달 계산
	// parameter : 현재 날짜
	$.beforeDate = function(todayAll) {
		var current = todayAll.split("-");
		var beforeYear;
		var beforeMonth;
		var beforeAll;
		
		if(current[1] == "01") {
			beforeYear = (parseInt(current[0]) - 1) + "";
			beforeMonth = "12";
		} else {
			beforeYear = current[0];
			beforeMonth = (parseInt(current[1]) - 1) + "";
		}
		if(beforeMonth.length == 1) {
			beforeMonth = "0" + beforeMonth;
		}
		beforeAll = beforeYear + "-" + beforeMonth;
		
		return beforeAll;
	}
	
	// 다음 달 계산
	// parameter : 현재 날짜
	$.afterDate = function(todayAll) {
		var current = todayAll.split("-");
		var afterYear;
		var afterMonth;
		var afterAll;
		
		if(current[1] == "12") {
			afterYear = (parseInt(current[0]) + 1) + "";
			afterMonth = "01";
		} else {
			afterYear = current[0];
			afterMonth = (parseInt(current[1]) + 1) + "";
		}
		if(afterMonth.length == 1) {
			afterMonth = "0" + afterMonth;
		}
		afterAll = afterYear + "-" + afterMonth;
		
		return afterAll;
	}
})