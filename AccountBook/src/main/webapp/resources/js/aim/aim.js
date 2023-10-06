document.write('<script src="../resources/js/reg_exp.js"></script>'); // 정규식 js
document.write('<script src="../resources/js/main.js"></script>'); // 모달 및 카테고리 설정 js
document.write('<script src="../resources/js/cal_date.js"></script>'); // 이전 달, 다음 달 구하기 js
document.write('<script src="../resources/js/account/category_list.js"></script>'); // 카테고리 목록 js
document.write('<script src="../resources/js/aim/aim_list.js"></script>'); // 목표 목록 js

$(function() {
	var todayAll; // 현재 날짜 저장할 변수
	var todayYear;
	
	// 목표 중복 확인 함수
	$.overlapAim = function(aimdate) {
		var result;
		$.ajax({
			type : "post",
			url : "isOverlapAim",
			async : false,
			data : {
				aimdate : aimdate,
				catename : $("#add-catename").val(),
				userid : userid
			},
			success : function(x) {
				if(x == "possible") {
					result = true;
				} else {
					result = false;
				}
			}
		})
		return result;
	}
	
	$(document).ready(function() {
		// 현재 날짜 가져오기
		todayAll = $.currentYM();
		todayYear = todayAll.split("-")[0];
		
		// 숫자만 입력되도록
		$.onlyNum("#add-year");
		$.onlyNum("#add-total");
		$.onlyNum("#up-total");
		
		// 금액 세 자리마다 콤마
		$.moneyFmt("#add-total");
		$.moneyFmt("#up-total");
		
		// 목표 가져오기
		$.aimList(todayAll, userid, "#month-div", "#aim-list-div"); // 지출 목표
		$.inaimList(todayAll, userid, "#aim-in-list-div"); // 수입 목표
		
		// 목표 선택 및 값 자동 입력
		$.pickAim("#out-aim-table tr");
		$.pickAim("#in-aim-table tr");
		
		// 카테고리 목록 가져오기
		$.categoryList(userid, "#in-category-list-div", "#out-category-list-div"); // 카테고리 목록
		$.categoryList(userid, "#select-incate-list-div", "#select-outcate-list-div"); // 카테고리 선택 모달
		
		// 카테고리 선택 및 값 자동 입력 (목표 추가)
		$.openSelectCate("#add-catename", "select-mtype");
		$.pickCategory("#in-category-table tr", "#add-catename", "#select-incate-modal");
		$.pickCategory("#out-category-table tr", "#add-catename", "#select-outcate-modal");
		
		// 모달 닫기
		$.closeModal("#close-add-aim", "#add-aim-modal"); // 목표 추가 모달 닫기
		$.closeModal("#close-up-aim", "#up-aim-modal"); // 목표 수정 모달 닫기
		$.closeModal("#close-select-incate", "#select-incate-modal"); // 수입 카테고리 선택 모달 닫기
		$.closeModal("#close-select-outcate", "#select-outcate-modal"); // 지출 카테고리 선택 모달 닫기
		
		// 다른 영역 클릭 시 창 닫기
		$.autoClose("#select-month"); // 날짜 선택 닫기
	})
	
	// 이전 달 목표
	$(document).on("click", "#before", function() {
		todayAll = $.beforeDate(todayAll); // 날짜 이전 달로 setting
		$.aimList(todayAll, userid, "#month-div", "#aim-list-div"); // 지출 목표
		$.inaimList(todayAll, userid, "#aim-in-list-div"); // 수입 목표
	})
	
	// 다음 달 목표
	$(document).on("click", "#after", function() {
		todayAll = $.afterDate(todayAll); // 날짜 이전 달로 setting
		$.aimList(todayAll, userid, "#month-div", "#aim-list-div"); // 지출 목표
		$.inaimList(todayAll, userid, "#aim-in-list-div"); // 수입 목표
	})
	
	// 날짜 선택
	$(document).on("click", "#month-div", function() {
		$.selectDate(todayYear);
	})
	
	// 날짜 선택에서 이전 연도 클릭
	$(document).on("click", "#before-year", function() {
		todayYear = $.selectBeforeYear(todayYear);
	})
	
	// 날짜 선택에서 다음 연도 클릭
	$(document).on("click", "#after-year", function() {
		todayYear = $.selectAfterYear(todayYear);
	})
	
	// 날짜 월 선택 시 보여줄 연월 값 변경
	$(document).on("click", ".month-td", function() {
		todayAll = $("#current-year").text().split("년")[0] + "-" + $(this).text().split("월")[0];
		todayYear = todayAll.split("-")[0];
		
		$.aimList(todayAll, userid, "#month-div", "#aim-list-div"); // 지출 목표
		$.inaimList(todayAll, userid, "#aim-in-list-div"); // 수입 목표
		
		$("#select-month").hide();
	})
	
	// 목표 추가 모달 열기
	$(document).on("click", "#add-aim-page", function() {
		$("#add-aim-modal").show();

		var yearVal = todayAll.split("-")[0]; // 연도
		var monthVal = todayAll.split("-")[1]; // 월

		$("#add-year").attr("value", yearVal);
		$("#add-month").val(monthVal).prop("selected");
	})
	
	// 목표 추가
	$(document).on("click", "#add-aim-btn", function() {
		var mtype = $("input[name=select-mtype]:checked").val();
		var year = $("#add-year").val();
		var date = $("#add-month").val();
		if(date.length == 1) {
			date = "0" + date;
		}
		var aimdate = year + "-" + date;

		if(!$.noEmpty("#add-catename") || !$.noEmpty("#add-year") || !$.noEmpty("#add-month") || !$.noEmpty("#add-total")){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			var chkAim = $.overlapAim(aimdate); // 목표 중복 확인
			if(chkAim) { // 중복되지 않으면 추가
				$.ajax({
					type : "post",
					url : "insertAim",
					data : {
						moneytype : mtype,
						aimdate : aimdate,
						catename : $("#add-catename").val(),
						total : $("#add-total").val().replaceAll(",", ""),
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
			} else {
				alert("이미 존재하는 카테고리 목표입니다.");
			}
		}
	})
	
	// 목표 선택 및 값 자동 입력
	$.pickAim = function(selectID) {
		$(document).on("click", selectID, function() {
			$("#up-aimid").attr("value", $(this).children().eq(0).text());
			$("#up-catename").attr("value", $(this).children().eq(1).text());
			$("#up-total").attr("value", $(this).children().eq(3).text().split("원 / ")[1].split("원")[0]);
			$("#up-aim-modal").show();
		})
	}
	
	// 목표 수정
	$(document).on("click", "#up-aim-btn", function() {
		if(!$.noEmpty("#up-total")){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			$.ajax({
				type : "post",
				url : "updateAim",
				data : {
					aimid : $("#up-aimid").val(),
					total : ($("#up-total").val()).replaceAll(",", ""),
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
		}
	})
	
	// 목표 삭제
	$(document).on("click", "#del-aim-btn", function() {
		$.ajax({
			type : "post",
			url : "deleteAim",
			data : {
				aimid : $("#up-aimid").val(),
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