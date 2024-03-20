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
		makeAssetStats(today, "#top-div1"); // 자산 통계
		
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
		makeAssetStats(today, "#top-div1");
		
		$("#select-date").hide();
	})
	
	// 이전 달 클릭
	$(document).on("click", "#last-month", function() {
		today = lastMonth(today);
		year = getYear(today);
		month = getMonth(today);

		setDate(year, month);
		makeAssetStats(today, "#top-div1");
		
		$("#select-date").hide();
	})
	
	// 다음 달 클릭
	$(document).on("click", "#next-month", function() {
		today = nextMonth(today);
		year = getYear(today);
		month = getMonth(today);
		
		setDate(year, month);
		makeAssetStats(today, "#top-div1");
		
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
	
	// 자산 선택 시 상세 내역
	$(document).on("click", "#top-div1 .stats-list tr", function() {
		let divType = $(this).closest("div").parent().attr("id");
		let totalVal = $(this).children().eq(1).text();

		let asset = $(this).children().eq(0).text();
		let mtype;
		console.log(divType + " " + totalVal + " " + asset)
		
		if(divType == "out-stats-div") {
			mtype = "지출";
			detailsOfAsset(today, mtype, asset, totalVal, "#top-div2 #inner-div1");
		} else if(divType == "in-stats-div") {
			mtype = "수입";
			detailsOfAsset(today, mtype, asset, totalVal, "#top-div2 #inner-div2");
		}
		$("#top-div2").show();
		let offset = $("#top-div2").offset();
		$("html, body").animate({scrollTop:offset.top}, 400);
	})
})

// 자산 통계
function makeAssetStats(dateVal, divID) {
	$.ajax({
		type: "post",
		url: "../account/makeAssetStats",
		data: {
			date: dateVal,
			userid: userid
		},
		success: function(res) {
			$(divID).html(res);
		}
	})
}

// 자산 상세
function detailsOfAsset(dateVal, typeVal, assetVal, totalVal,divID) {
	$.ajax({
		type: "post",
		url: "../account/detailsOfAsset",
		data: {
			date: dateVal,
			moneytype: typeVal,
			assetname: assetVal,
			userid: userid
		},
		success: function(res) {
			let html = "<div class='total-div'>" +
						"<table><tr><td><p>" + assetVal + "</p></td>" +
						"<td><i>"+ totalVal + "</i></td></tr></table></div>";
			html += "<div id='account-list-div'>" + res + "</div>";
			$(divID).html(html);
		}
	})
}