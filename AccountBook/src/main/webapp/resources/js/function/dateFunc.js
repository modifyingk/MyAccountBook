$(function() {
	// 현재 날짜
	$.createDate = function() {
		var date = new Date();
		return date;
	}
	
	// 년
	$.getYear = function(today) {
		return today.split("-")[0];
	}
	
	// 월
	$.getMonth = function(today) {
		return today.split("-")[1];
	}
	
	// 일
	$.getDay = function(today) {
		return today.split("-")[2];
	}
	
	// 월 형식 지정
	$.monthFmt = function(month) {
		var monthStr = month + ''; // 인자가 숫자일수도 있으므로 문자로 변환
		if(monthStr.length == 1) // 월을 두자리 숫자로 표현
			monthStr = '0' + monthStr;
		return monthStr;
	}
	
	$.dayFmt = function(day) {
		var dayStr = day + '';
		if(dayStr.length == 1)
			dayStr = '0' + dayStr;
		return dayStr;
	}
	
	// yyyy-mm-dd
	$.getFullDate = function(date) {
		var y = date.getFullYear(); // 년
		var m = $.monthFmt(date.getMonth() + 1); // 형식 지정 월
		var d = $.dayFmt(date.getDate());
		return y + "-" + m + "-" + d;
	}
	
	// yyyy-mm
	$.getYearMonth = function(date) {
		var y = date.getFullYear(); // 년
		var m = $.monthFmt(date.getMonth() + 1); // 형식 지정 월
		return y + "-" + m;
	}
	
	// 이전 달 계산
	// parameter : 현재 날짜
	$.beforeDate = function(today) {
		var current = today.split("-");
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
	$.afterDate = function(today) {
		var current = today.split("-");
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
	
	// 평년 윤년 계산
	$.calcYear = function(year) {
		if(((year % 4 == 0) && (year % 100 != 0)) || year % 400 == 0) {
			return 29;
		} else {
			return 28;
		}
	}
	
	// 현재까지의 전체 날 수
	$.calcDay = function(year, month) {
		var dates = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		
		var lastYear = year - 1;
		var totalDays = parseInt(lastYear * 365) + parseInt(lastYear / 4) - parseInt(lastYear / 100) + parseInt(lastYear / 400);
		for(var i = 0; i < parseInt(month) - 1; i++) {
			totalDays += dates[i];
		}
		
		return totalDays;
	}
	
	/*
	// 현재 연도 가져오기
	$.currentYear = function() {
		var today = new Date();
		var todayYear = today.getFullYear();
		
		return todayYear;
	}
	
	// 현재 월 가져오기
	$.currentMonth = function() {
		var today = new Date();
		var todayMonth = today.getMonth() + 1 + "";
		
		return todayMonth;
	}
	// 현재 일 가져오기
	$.currentD = function() {
		var today = new Date();
		var todayDate = today.getDate();
		
		return todayDate;
	}
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
	*/
})