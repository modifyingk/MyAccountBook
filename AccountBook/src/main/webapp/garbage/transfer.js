document.write('<script src="../resources/js/asset/transferFunc.js"></script>'); // 이체 함수
document.write('<script src="../resources/js/function/dateFunc.js"></script>'); // 날짜 함수
document.write('<script src="../resources/js/function/htmlFunc.js"></script>'); // html 함수
document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 유효성 검사 함수

$(function() {
	var date;
	var today; // yyyy-mm 변수
	
	$(document).ready(function() {
		// 현재 날짜 가져오기
		date = $.createDate();
		today = $.getYearMonth(date);
		year = date.getFullYear();
		month = date.getMonth() + 1;

		// 날짜 세팅
		$.setDate(year, month);
		
		// 이체 내역 가져오기
		$.showTransfer(today, userid);
	})
	
	// 자산 이체 내역 보여주기
	$(document).on("click", "#open-transfer-list", function() {
		location.href = "transfer.jsp";
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
		today = $.selectDate($("#current-year").text(), $(this).text());
		year = $.getYear(today);
		month = $.getMonth(today);
		
		// 해당 날짜의 이체 내역
		$.setDate(year, month);
		$.showTransfer(today, userid);
		
		$("#select-month").hide();
	})
	
	// 이전 달 클릭
	$(document).on("click", "#before", function() {
		// 이전 달로 month-div 세팅
		today = $.beforeDate(today);
		year = $.getYear(today);
		month = $.getMonth(today);
		$.setDate(year, month);
		
		// 해당 날짜의 이체 내역
		$.showTransfer(today, userid);
	})
	
	// 다음 달 클릭
	$(document).on("click", "#after", function() {
		// 다음 달로  month-div 세팅
		today = $.afterDate(today);
		year = $.getYear(today);
		month = $.getMonth(today);
		$.setDate(year, month);
		
		// 해당 날짜의 이체 내역
		$.showTransfer(today, userid);;
	})
	
	// 이체 내역 div 닫기
	$(document).on("click", "#close-transfer-div", function() {
		$("#transfer-div").hide();
	})
	
	// 이체 내역 수정 div 열기
	$(document).on("click", ".tr-content", function() {
		var d = $(this).children().eq(0).text();
		var id = $(this).children().eq(1).text();
		var withdraw = $(this).children().eq(2).children().eq(0).text();
		var deposit = $(this).children().eq(2).children().eq(1).text();
		var total = $(this).children().eq(3).children().eq(0).text();
		var memo = $(this).children().eq(4).text();
		
		$("#update-transfer-date").attr("value", d);
		$("#update-transfer-id").attr("value", id);
		$("#update-withdraw").attr("value", withdraw);
		$("#update-deposit").attr("value", deposit);
		$("#update-transfer-total").attr("value", total);
		$("#update-transfer-memo").val(memo);
		
		$("#update-transfer-div").show();
	})
	
	// 이체 수정 div 닫기
	$(document).on("click", "#close-update-transfer", function() {
		$("#update-transfer-div").hide();
	})
	
	// 이체 수정
	$(document).on("click", "#update-transfer-btn", function() {
		$.ajax({
			type: "post",
			url : "../transfer/updateTransfer",
			data : {
				date: $("#update-transfer-date").val(),
				transferid: $("#update-transfer-id").val(),
				total: $("#update-transfer-total").val().replace(",", ""),
				memo: $("#update-transfer-memo").val(),
				userid: userid
			},
			success: function(res) {
				if(res == true)
					window.location.reload();
				else
					alert("다시 시도해주세요")
			}
		})
	})
	
	// 이체 삭제
	$(document).on("click", "#delete-transfer-btn", function() {
		$.ajax({
			type: "post",
			url : "../transfer/deleteTransfer",
			data : {
				transferid: $("#update-transfer-id").val(),
				userid: userid
			},
			success: function(res) {
				if(res == true)
					window.location.reload();
				else
					alert("다시 시도해주세요")
			}
		})
	})
})
