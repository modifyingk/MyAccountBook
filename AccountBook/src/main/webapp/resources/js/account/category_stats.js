document.write('<script src="../resources/js/function/htmlFunc.js"></script>'); // html 함수
document.write('<script src="../resources/js/function/dateFunc.js"></script>'); // 날짜 함수
document.write('<script src="../resources/js/account/accountFunc.js"></script>'); // 수입/지출 내역 함수

$(function() {
	var year; // 현재 연도 저장할 변수
	var month;
	
	$(document).ready(function() {
		
		year = $.getYear(today);
		month = $.getMonth(today);

		// 날짜 세팅
		$.setDate(year, month);
		
		// 카테고리 통계
		$.showStats($.categoryStatsList(today, userid, "spend"));
		
		// 다른 영역 클릭 시 창 닫기
		$.autoClose("#select-month"); // 날짜 선택 닫기
		$.autoClose(".select-asset-div"); // 자산 선택 닫기
		$.autoClose(".select-category-div"); // 분류 선택 닫기
		
	})

	// 날짜 선택 창 보여주기
	$(document).on("click", "#month-div", function() {
		$.showSelectDate(year);
	})
	
	// 날짜 선택 창에서 이전 연도 클릭
	$(document).on("click", "#before-year", function() {
		year = $.selectBeforeYear(year);
	})
	
	// 날짜 선택 창에서 다음 연도 클릭
	$(document).on("click", "#after-year", function() {
		year = $.selectAfterYear(year);
	})
	
	// 날짜 선택 창에서 월 선택
	$(document).on("click", ".month-td", function() {
		$.activeBtn("#in-account-btn", "#out-account-btn", "#total-account-btn"); // 전체 보기 버튼 활성화
		$.activeBtn("#in-stats-btn", "", "#out-stats-btn"); // 통계 지출 버튼 활성화
		
		today = $.selectDate($("#current-year").text(), $(this).text());
		year = $.getYear(today);
		month = $.getMonth(today);
		
		// 월별 수입/지출 목록
		$.setDate(year, month);
		$.showStats($.categoryStatsList(today, userid, "spend"));
		
		$("#select-month").hide();
		$("#details-category-div").hide();
	})
	
	// 이전 달 클릭
	$(document).on("click", "#before", function() {
		$.activeBtn("#in-account-btn", "#out-account-btn", "#total-account-btn"); // 전체 보기 버튼 활성화
		$.activeBtn("#in-stats-btn", "", "#out-stats-btn"); // 통계 지출 버튼 활성화
		
		// 이전 달로 month-div 세팅
		today = $.beforeDate(today);
		year = $.getYear(today);
		month = $.getMonth(today);
		$.setDate(year, month);
		
		$.showStats($.categoryStatsList(today, userid, "spend"));
		$("#details-category-div").hide();
	})
	
	// 다음 달 클릭
	$(document).on("click", "#after", function() {
		$.activeBtn("#in-account-btn", "#out-account-btn", "#total-account-btn"); // 전체 보기 버튼 활성화
		$.activeBtn("#in-stats-btn", "", "#out-stats-btn"); // 통계 지출 버튼 활성화
		
		// 다음 달로  month-div 세팅
		today = $.afterDate(today);
		year = $.getYear(today);
		month = $.getMonth(today);
		$.setDate(year, month);
		
		// 해당 날짜의 수입/지출 내역
		$.showStats($.categoryStatsList(today, userid, "spend"));
		$("#details-category-div").hide();
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