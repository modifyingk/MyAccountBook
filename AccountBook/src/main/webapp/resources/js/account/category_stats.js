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

		// 날짜 세팅
		setDate(year, month);
		
		// 카테고리 통계
		//showStats($.categoryStatsList(today, userid, "spend"));
		
		// 다른 영역 클릭 시 창 닫기
		autoClose("#select-month"); // 날짜 선택 닫기
		autoClose(".select-asset-div"); // 자산 선택 닫기
		autoClose(".select-category-div"); // 분류 선택 닫기
		
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
		$("#mini-calendar td").removeClass("active");
		$(".show-range").removeClass("active");
		$("#show-all").addClass("active");
		
		today = selectDate($("#select-year").text(), $(this).text());
		year = getYear(today);
		month = getMonth(today);
		
		// 월별 수입/지출 목록
		setDate(year, month);
		//showStats($.categoryStatsList(today, userid, "spend"));
		
		$("#select-date").hide();
		//$("#details-category-div").hide();
	})
	
	// 이전 달 클릭
	$(document).on("click", "#last-month", function() {
		$("#mini-calendar td").removeClass("active");
		$(".show-range").removeClass("active");
		$("#show-all").addClass("active");
		
		today = lastMonth(today);
		year = getYear(today);
		month = getMonth(today);

		// 월별 수입/지출 목록
		setDate(year, month);
		//showStats($.categoryStatsList(today, userid, "spend"));
		
		$("#select-date").hide();
		//$("#details-category-div").hide();
	})
	
	// 다음 달 클릭
	$(document).on("click", "#next-month", function() {
		$("#mini-calendar td").removeClass("active");
		$(".show-range").removeClass("active");
		$("#show-all").addClass("active");
		
		today = nextMonth(today);
		year = getYear(today);
		month = getMonth(today);
		
		// 월별 수입/지출 목록
		setDate(year, month);
		//showStats($.categoryStatsList(today, userid, "spend"));
		
		$("#select-date").hide();
		//$("#details-category-div").hide();
	})
	
	// 수입 통계 보여주기
	$(document).on("click", "#in-stats-btn", function() {
		$.activeBtn("#out-stats-btn", "", "#in-stats-btn"); // 수입 버튼 활성화
		$.showStats($.categoryStatsList(today, userid, "income"));
		$(".td-statsTotal").attr("class", "blue");
	})
	
	// 지출 통계 보여주기
	$(document).on("click", "#out-stats-btn", function() {
		$.activeBtn("#in-stats-btn", "", "#out-stats-btn"); // 지출 버튼 활성화
		$.showStats($.categoryStatsList(today, userid, "spend"));
	})
	
	// 통계 카테고리 클릭 시 해당 카테고리 지출 내역
	$(document).on("click", ".tr-statsName", function() {
		var catename = $(this).children().eq(0).text();
		var moneytype;
		if($(this).children().eq(1).hasClass("blue")) {
			moneytype = "수입";
		} else {
			moneytype = "지출";
		}
		var html = $.accountHtml($.detailsOfCategory(catename, moneytype, today, userid));
		$("#account-list-div").html(html);
		$("#name-div").html("<i class='fi fi-rr-usd-circle'></i> " + catename); // 카테고리명 html
		$.showStatsTotal(moneytype); // 카테고리별 합계 html
		$("#details-div").show();
	})
	
	// 카테고리 내역 div 닫기
	$(document).on("click", "#close-category-account", function() {
		$("#details-div").hide();
	})

})