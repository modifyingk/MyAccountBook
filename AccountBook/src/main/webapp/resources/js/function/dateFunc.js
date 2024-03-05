$(function() {
	// 현재 날짜
	$.createDate = function() {
		let date = new Date();
		return date;
	}
	
	// 년
	$.getYear = function(today) {
		return today.substring(0, 4);
	}
	
	// 월
	$.getMonth = function(today) {
		return today.substring(4, 6);
	}
	
	// 일
	$.getDay = function(today) {
		return today.substring(6, 8);
	}
	
	// yyyy-mm-dd 형식
	$.getDateFmt = function(date) {
		return $.getYear(date) + "-" + $.getMonth(date) + "-" + $.getDay(date);
	}
	
	// 
	$.insertZero = function(date) {
		let dateStr = date + ''; // 인자가 숫자일수도 있으므로 문자로 변환
		if(dateStr.length == 1) // 월을 두자리 숫자로 표현
			dateStr = '0' + dateStr;
		return dateStr;
	}
	
	// 월 형식 지정
	$.monthFmt = function(month) {
		let monthStr = month + ''; // 인자가 숫자일수도 있으므로 문자로 변환
		if(monthStr.length == 1) // 월을 두자리 숫자로 표현
			monthStr = '0' + monthStr;
		return monthStr;
	}
	
	$.removeZero = function(date) {
		if(date.length > 1)
			if(date.substring(0, 1) == 0)
				return date.substr(1, 1);
			else
				return date;
		else
			return date;
	}
	
	// 일 형식 지정
	$.dayFmt = function(day) {
		let dayStr = day + '';
		if(dayStr.length == 1)
			dayStr = '0' + dayStr;
		return dayStr;
	}
	
	// yyyy-mm-dd
	$.getFullDate = function(date) {
		let y = date.getFullYear(); // 년
		let m = $.insertZero(date.getMonth() + 1); // 형식 지정 월
		let d = $.dayFmt(date.getDate());
		return y + "-" + m + "-" + d;
	}
	
	// yyyy-mm
	$.getYearMonth = function(date) {
		let y = date.getFullYear(); // 년
		let m = $.insertZero(date.getMonth() + 1); // 형식 지정 월
		return y + m;
	}
	
	// 이전 달 계산
	// parameter : 현재 날짜
	$.beforeDate = function(today) {
		let currentYear = today.substring(0, 4);
		let currentMonth = today.substring(4, 6);
		
		let beforeYear;
		let beforeMonth;
		
		if(currentMonth == "01") {
			beforeYear = (parseInt(currentYear) - 1) + "";
			beforeMonth = "12";
		} else {
			beforeYear = currentYear;
			beforeMonth = (parseInt(currentMonth) - 1) + "";
		}
		beforeMonth = $.insertZero(beforeMonth);
		return beforeYear + beforeMonth;
	}
	
	// 다음 달 계산
	// parameter : 현재 날짜
	$.afterDate = function(today) {
		let currentYear = today.substring(0, 4);
		let currentMonth = today.substring(4, 6);
		
		let afterYear;
		let afterMonth;
		
		if(currentMonth == "12") {
			afterYear = (parseInt(currentYear) + 1) + "";
			afterMonth = "01";
		} else {
			afterYear = currentYear;
			afterMonth = (parseInt(currentMonth) + 1) + "";
		}
		afterMonth = $.insertZero(afterMonth);
		return afterYear + afterMonth;
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
	
	// 날짜 선택 창 보여주기 & 현재 연도 세팅
	$.showSelectDate = function(year) {
		$("#select-date").show();
		$("#current-year").html(year + "년");
	}
	
	// 날짜 선택 창에서 이전 연도 클릭
	$.selectBeforeYear = function(year) {
		year = parseInt(year) - 1;
		$("#current-year").html(year + "년");
		return year;
	}
	
	// 날짜 선택 창에서 다음 연도 클릭
	$.selectAfterYear = function(year) {
		year = parseInt(year) + 1;
		$("#current-year").html(year + "년");
		return year;
	}
	
	// 날짜 선택 창에서 선택한 날짜 반환
	$.selectDate = function(yearText, monthText) {
		var y = yearText.split("년")[0];
		var m = $.insertZero(monthText.split("월")[0]);
		return y + m;
	}
	
	$.getDayOfWeek = function(date) {
		let yyyymmdd = $.getYear(date) + "-" + $.getMonth(date) + "-" + $.getDay(date);;
		let dayOfWeek = new Date(yyyymmdd).getDay();
		switch(dayOfWeek) {
			case 0: dayOfWeek = "일"; break;
			case 1: dayOfWeek = "월"; break;
			case 2: dayOfWeek = "화"; break;
			case 3: dayOfWeek = "수"; break;
			case 4: dayOfWeek = "목"; break;
			case 5: dayOfWeek = "금"; break;
			case 6: dayOfWeek = "토"; break;
		}
		return dayOfWeek;
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