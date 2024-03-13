document.write('<script src="../resources/js/function/htmlFunc.js"></script>'); // html 함수
document.write('<script src="../resources/js/function/dateFunc.js"></script>'); // 날짜 함수
document.write('<script src="../resources/js/account/accountFunc.js"></script>'); // 수입/지출 내역 함수

$(function() {
	var date;
	var today;
	var year; // 현재 연도 저장할 변수
	var month;
	
	$(document).ready(function() {
		date = createDate();
		today = getYearMonth(date); // yyyymm
		year = date.getFullYear(); 
		month = date.getMonth() + 1;

		setDate(year, month); // 날짜 세팅
		makeBigcateStats(today, "지출", "#inner-div1") // 카테고리 통계
		
		
		// 다른 영역 클릭 시 창 닫기
		autoClose("#select-date"); // 날짜 선택 닫기
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
		makeBigcateStats(today, "지출", "#inner-div1")
		
		$("#select-date").hide();
		//$("#details-category-div").hide();
	})
	
	// 이전 달 클릭
	$(document).on("click", "#last-month", function() {
		today = lastMonth(today);
		year = getYear(today);
		month = getMonth(today);

		setDate(year, month);
		makeBigcateStats(today, "지출", "#inner-div1")
		
		$("#select-date").hide();
		//$("#details-category-div").hide();
	})
	
	// 다음 달 클릭
	$(document).on("click", "#next-month", function() {
		today = nextMonth(today);
		year = getYear(today);
		month = getMonth(today);
		
		setDate(year, month);
		makeBigcateStats(today, "지출", "#inner-div1")
		
		$("#select-date").hide();
		//$("#details-category-div").hide();
	})
	
	
	// 통계 카테고리 클릭 시 해당 카테고리 지출 내역
	$(document).on("click", "#inner-div1 #stats-list tr", function() {
		let bigcate = $(this).children().eq(0).text();
		let mtype = $("#inner-div1 h2").text().substring(0, 2);
		
		detailsOfBigcate(today, mtype, bigcate, "#inner-div2");

		// 대분류 상세 div로 넘기기 (아래로)
		$("#top-div2").show();
		let offset = $("#top-div2").offset();
		$("html, body").animate({scrollTop:offset.top}, 400);
	})

	// 대분류 통계 div로 넘기기 (위로)
	$(document).on("click", "#up-div", function() {
		$("html, body").animate({scrollTop:0}, 400);
	})
	
	// 소분류 통계 div로 넘기기 (옆으로)
	$(document).on("click", "#next-div2", function() {
		console.log($("#inner-div2 h2").text());
		if($("#inner-div2 h2").text() == "") {
			let typeVal = $("#typeVal").text();
			let bigcateVal = $("#bigcateVal").text();
			makeSmallcateStats(today, typeVal, bigcateVal, "#inner-div2")
		} else {
			let bigcateVal = $("#inner-div2 h2").text().split(" ")[0];
			let typeVal = $("#typeVal").text();
			console.log(bigcateVal + " " + typeVal);
			detailsOfBigcate(today, typeVal, bigcateVal, "#inner-div2");
		}
	})
})

// 대분류 통계
function makeBigcateStats(dateVal, typeVal, divID) {
	$.ajax({
		type: "post",
		url: "makeBigcateStats",
		data: {
			date: dateVal,
			userid: userid,
			moneytype: typeVal
		},
		success: function(res) {
			$(divID).html(res);
		}
	})
}

// 소분류 통계
function makeSmallcateStats(dateVal, typeVal, bigcateVal, divID) {
	$.ajax({
		type: "post",
		url: "makeSmallcateStats",
		data: {
			date: dateVal,
			moneytype: typeVal,
			bigcate: bigcateVal,
			userid: userid
		},
		success: function(res) {
			$(divID).html(res);
		}
	})
}

// 대분류 상세
function detailsOfBigcate(dateVal, typeVal, bigcateVal, divID) {
	$.ajax({
		type: "post",
		url: "detailsOfBigcate",
		data: {
			date: dateVal,
			moneytype: typeVal,
			bigcate: bigcateVal,
			userid: userid
		},
		success: function(res) {
			let html = "<div id='total-div'>" +
						"<table><tr><td><p>합계</p></td>" +
						"<td><i></i></td></tr></table></div>" +
						"<div class='hide' id='typeVal'>" + typeVal + "</div>" +
						"<div class='hide' id='bigcateVal'>" + bigcateVal + "</div>";
			html += "<div id='account-list-div'>" + res + "</div>";
			$(divID).html(html);
		}
	})
}