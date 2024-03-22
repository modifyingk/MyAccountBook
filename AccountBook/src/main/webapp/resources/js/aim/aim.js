document.write('<script src="../resources/js/function/htmlFunc.js"></script>'); // html 함수
document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 유효성 검사 함수
document.write('<script src="../resources/js/function/dateFunc.js"></script>'); // 날짜 함수

//목표 중복 확인 함수
function overlapAim(bigcateVal) {
	var result;
	$.ajax({
		type: "post",
		url: "overlapAim",
		async: false,
		data: {
			bigcate: bigcateVal,
			userid: userid
		},
		success: function(res) {
			result = res;
		}
	})
	return result;
}

// 목표 가져오기
function aimList(today) {
	$.ajax({
		type: "post",
		url: "selectAim",
		data: {
			date: today,
			userid: userid
		},
		success: function(res) {
			$("#div1").html(res);
		}
	})
}

$(function() {
	$(document).ready(function() {
		// 현재 날짜 가져오기
		let date = createDate();
		let today = getYearMonth(date); // yyyymm
		
		// 숫자만 입력되도록
		onlyNum("#add-year");
		onlyNum("#add-total");
		onlyNum("#up-total");
		
		// 금액 세 자리마다 콤마
		moneyFmt("#add-total");
		moneyFmt("#up-total");
		
		aimList(today);
		
		autoClose(".select-add-bigcate"); // 분류 선택 닫기
	})
	
	// 목표 추가
	$(document).on("click", "#open-add-aim", function() {
		$("#add-aim-modal").show();
	})
	
	// 목표 추가 모달 닫기
	$(document).on("click", "#close-add-aim", function() {
		$("#add-aim-modal").hide();
	})
	
	// 목표 추가 - 뷴류 선택
	$(document).on("click", "#add-bigcate", function() {
		$(".select-div").show();
	})
	$(document).on("click", ".select-add-bigcate td", function() {
		let categoryVal = $(this).text();
		$("#add-bigcate").attr("value", categoryVal);
		$(".select-add-bigcate").hide();
	})
	
	// 목표 추가
	$(document).on("click", "#add-aim-btn", function() {
		let bigcate = $("#add-bigcate").val();
		let total = $("#add-total").val().replaceAll(",", "");
		
		if(!checkMustReg(bigcate) || !checkMustReg(total)) { // 입력값 확인
			alert("입력 값을 확인해주세요.");
		} else {
			if(overlapAim(bigcate)) { // 중복확인
				$.ajax({
					type : "post",
					url : "insertAim",
					data : {
						bigcate : bigcate,
						total : total,
						userid : userid
					},
					success : function(res) {
						if(res == true) {
							window.location.reload();
						} else {
							alert("다시 시도해주세요.");
						}
					}
				})
			} else {
				alert("이미 목표가 존재합니다.")
			}
		}
		
	})
	
	// 목표 수정 모달 열기
	$(document).on("click", ".gage-div", function() {
		let bigcate = $(this).children().eq(1).text();
		let total = $(this).children().eq(2).text().split("/ ")[1];

		$("#update-bigcate").attr("value", bigcate);
		$("#update-total").attr("value", total);

		$("#update-aim-modal").show();
	})
	
	// 목표 수정 모달 닫기
	$(document).on("click", "#close-update-aim", function() {
		$("#update-aim-modal").hide();
	})
	
	// 목표 수정
	$(document).on("click", "#update-aim-btn", function() {
		let bigcate = $("#update-bigcate").val();
		let total = $("#update-total").val().replaceAll(",", "");
		
		$.ajax({
			type: "post",
			url: "updateAim",
			data: {
				bigcate: bigcate,
				total: total,
				userid: userid
			},
			success: function(res) {
				if(res == true) {
					window.location.reload();
				} else {
					alert("다시 시도해주세요.");
				}
			}
		})
	})
	
	// 목표 삭제
	$(document).on("click", "#delete-aim-btn", function() {
		let bigcate = $("#update-bigcate").val();
		let total = $("#update-total").val().replaceAll(",", "");
		
		let op = confirm("정말로 삭제하시겠습니까?");
		if(op) {
			$.ajax({
				type: "post",
				url: "deleteAim",
				data: {
					bigcate: bigcate,
					userid: userid
				},
				success: function(res) {
					if(res == true) {
						window.location.reload();
					} else {
						alert("다시 시도해주세요.");
					}
				}
			})
		}
	})
	
	/*
	// 목표 수정 모달 닫기
	$(document).on("click", "#close-up-aim", function() {
		$("#up-aim-modal").hide();
	})
	
	// 이전 달 목표
	$(document).on("click", "#before", function() {
		today = $.beforeDate(today); // 날짜 이전 달로 setting
		$.aimList(today, userid, "#month-div", "#aim-list-div"); // 지출 목표
		$.inaimList(today, userid, "#aim-in-list-div"); // 수입 목표
	})
	
	// 다음 달 목표
	$(document).on("click", "#after", function() {
		today = $.afterDate(today); // 날짜 이전 달로 setting
		$.aimList(today, userid, "#month-div", "#aim-list-div"); // 지출 목표
		$.inaimList(today, userid, "#aim-in-list-div"); // 수입 목표
	})
	
	// 날짜 선택
	$(document).on("click", "#month-div", function() {
		$.showSelectDate(year);
	})
	
	// 날짜 선택에서 이전 연도 클릭
	$(document).on("click", "#before-year", function() {
		year = $.selectBeforeYear(year);
	})
	
	// 날짜 선택에서 다음 연도 클릭
	$(document).on("click", "#after-year", function() {
		year = $.selectAfterYear(year);
	})
	
	// 날짜 월 선택 시 보여줄 연월 값 변경
	$(document).on("click", ".month-td", function() {
		today = $("#current-year").text().split("년")[0] + "-" + $(this).text().split("월")[0];
		year = $.getYear(today);
		
		$.aimList(today, userid, "#month-div", "#aim-list-div"); // 지출 목표
		$.inaimList(today, userid, "#aim-in-list-div"); // 수입 목표
		
		$("#select-month").hide();
	})
	
	// 목표 추가 모달 열기
	$(document).on("click", "#add-aim-page", function() {
		$("#add-aim-modal").show();

		var yearVal = $.getYear(today);
		var monthVal = $.getMonth(today);

		$("#add-year").attr("value", yearVal);
		$("#add-month").val(monthVal).prop("selected");
		
		$.pickCategory("#add-catename", "select-mtype");
	})
	
	// 카테고리 선택 및 값 자동 입력
	$.pickCategory = function(categoryID, mtypeName) {
		$(document).on("click", categoryID, function() {
			var mtype = $("input[name=" + mtypeName + "]:checked").val(); // 선택된 값 변수에 저장
			$.showSelectCategory(mtype, ".select-category-list");
			$(".select-category-div").show();
		})
		$(document).on("click", ".select-category-div tr", function() {
			var categoryVal = $(this).children().eq(1).text();
			$(categoryID).attr("value", categoryVal);
			$(".select-category-div").hide();
		})
	}
	
	// 목표 추가
	$(document).on("click", "#add-aim-btn", function() {
		var mtype = $("input[name=select-mtype]:checked").val();
		var y = $("#add-year").val();
		var d = $.monthFmt($("#add-month").val());
		var aimdate = year + "-" + d;

		if(!$.checkMustReg("#add-catename") || !$.checkMustReg("#add-year") || !$.checkMustReg("#add-month") || !$.checkMustReg("#add-total")){ // 정규식에 맞지 않을 때 (빈 값인 경우)
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
					success : function(res) {
						if(res == true) {
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
		if(!$.checkMustReg("#up-total")){ // 정규식에 맞지 않을 때 (빈 값인 경우)
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
				success : function(res) {
					if(res == true) {
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
			success : function(res) {
				if(res == true) {
					window.location.reload();
				} else {
					alert("다시 시도해주세요.");
				}
			}
		})
	})*/
})