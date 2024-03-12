document.write('<script src="../resources/js/function/htmlFunc.js"></script>'); // html 함수
document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 유효성 검사 함수
document.write('<script src="../resources/js/function/dateFunc.js"></script>'); // 날짜 함수

$(function() {
	var date;
	var today; // 현재 날짜 저장할 변수 yyyymm
	var year;
	var month;

	$(document).ready(function() {
		// 현재 날짜 가져오기
		date = createDate();
		today = getYearMonth(date);
		year = date.getFullYear();
		month = date.getMonth() + 1;
		
		setDate(year, month); // 날짜 세팅
		makeCalendar(today); // 달력 생성
		
		// 모달 닫기
		//$.closeModal("#close-date-account", "#date-account-modal");
		
		// 다른 영역 클릭 시 창 닫기
		autoClose("#select-date"); // 날짜 선택 닫기
		autoClose("#side-div1"); // 상세 내역 닫기
	})
	
	// 날짜 선택 창 보여주기
	$(document).on("click", "#date-div", function() {
		showSelectDate(year);
	})
	
	// 날짜 선택 창에서 이전 연도 클릭
	$(document).on("click", "#last-year", function() {
		year = selectLastYear(year);
	})
	
	// 날짜 선택 창에서 다음 연도 클릭
	$(document).on("click", "#next-year", function() {
		year = selectNextYear(year);
	})
	
	// 날짜 선택 창에서 월 선택
	$(document).on("click", ".select-month td", function() {
		today = selectDate($("#select-year").text(), $(this).text());
		year = getYear(today);
		month = getMonth(today);

		setDate(year, month);
		makeCalendar(today);
		
		$("#select-date").hide();
	})
	
	// 이전 달 클릭
	$(document).on("click", "#last-month", function() {
		today = lastMonth(today); // 날짜 이전 달로 세팅
		year = getYear(today);
		month = getMonth(today);
		
		setDate(year, month);
		makeCalendar(today);
	})
	
	// 다음 달 클릭
	$(document).on("click", "#next-month", function() {
		today = nextMonth(today); // 날짜 다음 달로 세팅
		year = getYear(today);
		month = getMonth(today);
		
		setDate(year, month);
		makeCalendar(today);
	})
	
	// 달력 날짜 선택
	$(document).on("click", "#calendar .il", function() {
		let day = $(this).children().children().eq(0).text();
		let date = today + twoDigits(day);
		
		$.ajax({
			type: "post",
			url: "../account/detailsOfDate",
			data: {
				date: date,
				userid: userid
			},
			success: function(res) {
				$("#account-list-div").html(res);
			}
		})
		$("#side-div1").show();
	})
	
	$(document).on("click", "#close-side-div1", function() {
		$("#side-div1").hide();
	})
})

// 달력 생성 함수
function makeCalendar(today) {
	$.ajax({
		type: "post",
		url: "../account/makeCalendar",
		data: {
			date: today,
			userid: userid,
			type: "calendar"
		},
		success: function(res) {
			$("#div2").html(res);
		}
	})
}

// 날짜 세팅
function setDate(year, month) {
	$("#month").html(oneDigits(month) + "월");
	$("#year").html(year);
}
