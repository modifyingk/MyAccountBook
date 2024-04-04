document.write('<script src="../resources/js/function/htmlFunc.js"></script>'); // html 함수
document.write('<script src="../resources/js/function/dateFunc.js"></script>'); // 날짜 함수

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
		makeBigcateStats(today, "#top-div1") // 카테고리 통계
		
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
		makeBigcateStats(today, "#top-div1") // 카테고리 통계
		
		$("#select-date").hide();
	})
	
	// 이전 달 클릭
	$(document).on("click", "#last-month", function() {
		today = lastMonth(today);
		year = getYear(today);
		month = getMonth(today);

		setDate(year, month);
		makeBigcateStats(today, "#top-div1") // 카테고리 통계
		
		$("#select-date").hide();
	})
	
	// 다음 달 클릭
	$(document).on("click", "#next-month", function() {
		today = nextMonth(today);
		year = getYear(today);
		month = getMonth(today);
		
		setDate(year, month);
		makeBigcateStats(today, "#top-div1") // 카테고리 통계
		
		$("#select-date").hide();
	})
	
	// 수입 통계로 넘기기 (옆으로)
	$(document).on("click", "#scroll-instats", function() {
		let offset = $("#in-stats-div").offset();
		$("#div2").scrollLeft(offset.left);
	})
	
	// 지출 통계로 넘기기 (옆으로)
	$(document).on("click", "#scroll-outstats", function() {
		let offset = $("#out-stats-div").offset();
		$("#div2").scrollLeft(offset.left);
	})
	
	// 대분류 선택 시 상세 내역
	$(document).on("click", "#top-div1 .stats-list tr", function() {
		let divType = $(this).closest("div").parent().attr("id");
		let totalVal = $(this).children().eq(1).text();

		let bigcate = $(this).children().eq(0).text();
		let mtype;
		if(divType == "out-stats-div") {
			mtype = "지출";
			detailsOfBigcate(today, mtype, bigcate, totalVal, "#top-div2 #inner-div1");
			makeSmallcateStats(today, mtype, bigcate, "#top-div3 #inner-div1");
		} else if(divType == "in-stats-div") {
			mtype = "수입";
			detailsOfBigcate(today, mtype, bigcate, totalVal, "#top-div2 #inner-div2");
			makeSmallcateStats(today, mtype, bigcate, "#top-div3 #inner-div2");
		}
		$("#top-div2").show();
		$("#top-div3").show();
		let offset = $("#top-div2").offset();
		$("html, body").animate({scrollTop:offset.top-270}, 400);
	})
	
	// 스크롤 제일 위로 이동
	$(document).on("click", "#scroll-top", function() {
		$("html, body").animate({scrollTop:0}, 400);
	})
	
	// 소분류 통계
	$(document).on("click", "#scroll-smallcate", function() {
		let offset = $("#top-div3").offset();
		$("html, body").animate({scrollTop:offset.top-270}, 400);
	})
	
	// 소분류 선택 시 상세 내역
	$(document).on("click", "#top-div3 .stats-list tr", function() {
		let divType = $(this).closest("div").parent().parent().attr("id");
		let totalVal = $(this).children().eq(1).text();
		let bigcate = $(this).closest("div").parent().children().eq(0).text().split(" 통계")[0];
		let smallcate = $(this).children().eq(0).text();
		if(smallcate == "분류없음")
			smallcate = "";
		let mtype;
		if(divType == "inner-div1") { // 지출
			mtype = "지출";
			detailsOfSmallcate(today, mtype, bigcate, smallcate, totalVal, "#top-div4 #inner-div1");
		} else if(divType == "inner-div2"){ // 수입
			mtype = "수입";
			detailsOfSmallcate(today, mtype, bigcate, smallcate, totalVal, "#top-div4 #inner-div2");
		}
		$("#top-div4").show();
		let offset = $("#top-div4").offset();
		$("html, body").animate({scrollTop:offset.top}, 400);
	})
})

// 대분류 통계
function makeBigcateStats(dateVal, divID) {
	$.ajax({
		type: "post",
		url: "makeBigcateStats",
		data: {
			date: dateVal,
			userid: userid
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
function detailsOfBigcate(dateVal, typeVal, bigcateVal, totalVal,divID) {
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
			let html = "<div class='total-div'>" +
						"<table><tr><td><p>" + bigcateVal + "</p></td>" +
						"<td><i>"+ totalVal + "</i></td></tr></table></div>";
			html += "<div id='account-list-div'>" + res + "</div>";
			$(divID).html(html);
		}
	})
}

// 소분류 상세
function detailsOfSmallcate(dateVal, typeVal, bigcateVal, smallcateVal, totalVal,divID) {
	$.ajax({
		type: "post",
		url: "detailsOfSmallcate",
		data: {
			date: dateVal,
			moneytype: typeVal,
			bigcate: bigcateVal,
			smallcate: smallcateVal,
			userid: userid
		},
		success: function(res) {
			if(smallcateVal == "") {
				smallcateVal = "분류없음";
			}
			let html = "<div class='total-div'>" +
			"<table><tr><td><p>" + smallcateVal + "</p></td>" +
			"<td><i>"+ totalVal + "</i></td></tr></table></div>";
			html += "<div id='account-list-div'>" + res + "</div>";
			$(divID).html(html);
		}
	})
}