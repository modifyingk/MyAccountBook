// 현재 날짜
function createDate() {
	let date = new Date();
	return date;
}

// 연도 (yyyy-mm-dd 에서)
function getYear(today) {
	return today.substring(0, 4);
}

// 월 (yyyy-mm-dd 에서)
function getMonth(today) {
	return today.substring(4, 6);
}

// 일 (yyyy-mm-dd 에서)
function getDay(today) {
	return today.substring(6, 8);
}

// 날짜 형식으로 슬래시 추가 (yyyy-mm-dd 에서)
function getDateFmt(today) {
	return getYear(today) + "-" + getMonth(today) + "-" + getDay(today);
}

// 날짜 형식으로 슬래시 추가 (date type 에서)
function makeDateFmt(date) {
	let y = date.getFullYear(); // 년
	let m = twoDigits(date.getMonth() + 1); // 형식 지정 월
	let d = twoDigits(date.getDate());
	return y + "-" + m + "-" + d;
}

// 월/일 두 자리 형식
function twoDigits(date) {
	let dateStr = date + ''; // 인자가 숫자일수도 있으므로 문자로 변환
	if(dateStr.length == 1) // 월을 두자리 숫자로 표현
		dateStr = '0' + dateStr;
	return dateStr;
}

// 월/일 한 자리  형식
function oneDigits(date) {
	if(date.length > 1)
		if(date.substring(0, 1) == 0)
			return date.substr(1, 1);
		else
			return date;
	else
		return date;
}

// 연도와 월 반환 (yyyymm 형식)
function getYearMonth(date) {
	let y = date.getFullYear(); // 년
	let m = twoDigits(date.getMonth() + 1); // 형식 지정 월
	return y + m;
}

// 이전 달 계산
function lastMonth(today) {
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
	beforeMonth = twoDigits(beforeMonth);
	return beforeYear + beforeMonth;
}

// 다음 달 계산
function nextMonth(today) {
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
	afterMonth = twoDigits(afterMonth);
	return afterYear + afterMonth;
}

// 날짜 선택 창 보여주기 & 현재 연도 세팅
function showSelectDate(year) {
	$("#select-date").show();
	$("#select-year").html(year + "년");
}

// 날짜 선택 창에서 이전 연도 클릭
function selectLastYear(year) {
	year = parseInt(year) - 1;
	$("#select-year").html(year + "년");
	return year;
}

// 날짜 선택 창에서 다음 연도 클릭
function selectNextYear(year) {
	year = parseInt(year) + 1;
	$("#select-year").html(year + "년");
	return year;
}

//날짜 선택 창에서 선택한 날짜 반환
function selectDate(yearText, monthText) {
	var y = yearText.split("년")[0];
	var m = twoDigits(monthText.split("월")[0]);
	return y + m;
}

$(function() {
	/*
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
	*/
	
})