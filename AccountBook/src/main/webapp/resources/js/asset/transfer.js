document.write('<script src="../resources/js/asset/transfer_list.js"></script>'); // 이체 목록 js
document.write('<script src="../resources/js/cal_date.js"></script>'); // 이전 달, 다음 달 구하기 js

$(function() {
	
	var transToday; // 현재 날짜 저장할 변수

	$(document).ready(function() {
		// 현재 날짜 가져오기(이체용)
		transToday = $.currentYM();

		// 이체 내역 가져오기
		$.transferList(transToday, userid, "#month-div", "#transfer-list-div");
	})
	
	// 이체 내역 이전 달 클릭
	$(document).on("click", "#before", function() {
		transToday = $.beforeDate(transToday); // 날짜 이전 달로 setting
		$.transferList(transToday, userid, "#month-div", "#transfer-list-div");
	})
	
	// 이체 내역 다음 달 클릭
	$(document).on("click", "#after", function() {
		transToday = $.afterDate(transToday); // 날짜 다음 달로 setting
		$.transferList(transToday, userid, "#month-div", "#transfer-list-div");
	})
	
	// 이체 추가 모달 열기
	$(document).on("click", "#add-transfer-page", function() {
		// 현재 날짜 가져오기
		var dateValue = $.currentDate();

		// 값 다 비우고 추가 날짜만 현재 날짜로 setting
		$("#add-transfer-date").attr("value", dateValue);
		$("#add-withdraw-asset").attr("value", "");
		$("#add-deposit-asset").attr("value", "");
		$("#add-transfer-modal").show();
	})
	
	// 이체 추가
	$(document).on("click", "#add-transfer-btn", function() {
		$.ajax({
			type : "post",
			url : "../transfer/insertTransfer",
			data : {
				date : $("#add-transfer-date").val(),
				withdraw : $("#add-withdraw-asset").val(),
				deposit : $("#add-deposit-asset").val(),
				total : $("#add-transfer-total").val(),
				memo : $("#add-transfer-memo").val(),
				userid : userid
			},
			success : function(x) {
				if(x == "success") {
					window.location.reload();
				} else {
					alert("다시 시도해주세요.");
				}
			}
		})
	})
	
	// 이체 내역 날짜 tr 클릭 시 현재 날짜로 이체 추가 모달 열기
	$(document).on("click", ".tr-transfer-date", function() {
		$("#add-transfer-modal").show();
		$("#add-transfer-date").attr("value", $(this).text());
	})
	
	// 이체 내역 내용 tr 클릭 시 해당 내역 수정 모달 열기
	$(document).on("click", ".tr-transfer-content", function() {
		var date = $(this).parent().children().eq(0).text();
		var transferid = $(this).children().eq(0).text();
		var withdraw = $(this).children().eq(1).children().eq(0).text();
		var deposit = $(this).children().eq(1).children().eq(1).text();
		var total = $(this).children().eq(2).text();
		var memo = $(this).children().eq(3).text();

		$("#up-transfer-id").attr("value", transferid);
		$("#up-transfer-date").attr("value", date);
		$("#up-withdraw-asset").attr("value", withdraw);
		$("#up-deposit-asset").attr("value", deposit);
		$("#up-transfer-total").attr("value", total);
		$("#up-total-memo").attr("value", memo);
		$("#up-transfer-modal").show();
	})
	
	// 이체 수정
	$(document).on("click", "#up-transfer-btn", function() {
		$.ajax({
			type : "post",
			url : "../transfer/updateTransfer",
			data : {
				transferid : $("#up-transfer-id").val(),
				date : $("#up-transfer-date").val(),
				withdraw : $("#up-withdraw-asset").val(),
				deposit : $("#up-deposit-asset").val(),
				total : $("#up-transfer-total").val().replaceAll(",", ""),
				memo : $("#up-transfer-memo").val(),
				userid : userid
			},
			success : function(x) {
				if(x == "success") {
					window.location.reload();
				} else {
					alert("다시 시도해주세요.");
				}
			}
		})
	})
	
	// 이체 삭제
	$(document).on("click", "#del-transfer-btn", function() {
		$.ajax({
			type : "post",
			url : "../transfer/deleteTransfer",
			data : {
				transferid : $("#up-transfer-id").val(),
				userid : userid
			},
			success : function(x) {
				if(x == "success") {
					window.location.reload();
				} else {
					alert("다시 시도해주세요.");
				}
			}
		})
	})
})