document.write('<script src="../resources/js/function/dateFunc.js"></script>'); // 날짜 함수
document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 유효성 검사 함수

$(function () {
	$(document).ready(function() {
		// 현재 날짜 가져오기
		let date = createDate();
		let today = getYearMonth(date); // yyyymm
		
		onlyNum("#add-aimtotal");
		moneyFmt("#add-aimtotal");
		
		recentAccount(today);
		selectAimTotal(today);
	})
	
	// 목표 등록 모달 열기
	$(document).on("click", "#add-aim-btn", function() {
		$("#add-aimtotal-modal").show();
	})
	
	// 목표 등록 모달 닫
	$(document).on("click", "#close-add-aimtotal", function() {
		$("#add-aimtotal-modal").hide();
	})
	
	// 목표 등록
	$(document).on("click", "#add-aimtotal-btn", function() {
		let total = $("#add-aimtotal").val().replaceAll(",", "");
		console.log(total);
		if(!checkMustReg(total)) {
			alert("입력 값을 확인해주세요.");
		} else {
			$.ajax({
				type : "post",
				url : "../aim/insertTotal",
				data : {
					moneytype: "수입",
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
		}
	})
	
	// 총 목표 값 수정 모달 열기
	$(document).on("click", "#aim", function() {
		let total = $(this).text().split("원")[0];
		$("#update-aimtotal").attr("value", total);
		$("#update-aimtotal-modal").show();
	})
	
	// 총 목표 값 수정 모달 닫기
	$(document).on("click", "#close-update-aimtotal", function() {
		$("#update-aimtotal-modal").hide();
	})
	
	// 총 목표 값 수정
	$(document).on("click", "#update-aimtotal-btn", function() {
		let total = $("#update-aimtotal").val().replaceAll(",", "");
		
		if(!checkMustReg(total)) {
			alert("입력 값을 확인해주세요.");
		} else {
			$.ajax({
				type : "post",
				url : "../aim/updateTotal",
				data : {
					moneytype: "수입",
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
		}
	})
})

// 이번 달 수입/지출 및 최근 그래프
function recentAccount(today) {
	$.ajax({
		type: "post",
		url: "recentAccount",
		data: {
			date: nextMonth(today),
			userid: userid
		},
		success: function(res) {
			$("#left #div1").html(res);
		}
	})
}

//총 목표 및 지출 가져오기
function selectAimTotal(today) {
	$.ajax({
		type: "post",
		url: "selectAim",
		data: {
			date: today,
			moneytype: "지출",
			userid: userid
		},
		success: function(res) {
			$("#right #div1").html(res);
		}
	})
}