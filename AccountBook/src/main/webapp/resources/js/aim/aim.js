document.write('<script src="../resources/js/function/htmlFunc.js"></script>'); // html 함수
document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 유효성 검사 함수
document.write('<script src="../resources/js/function/dateFunc.js"></script>'); // 날짜 함수

$(function() {
	$(document).ready(function() {
		// 현재 날짜 가져오기
		let date = createDate();
		let today = getYearMonth(date); // yyyymm
		
		// 숫자만 입력되도록
		onlyNum("#add-year");
		onlyNum("#add-total");
		onlyNum("#up-total");
		onlyNum("#add-aimtotal");
		onlyNum("#update-aimtotal");
		
		// 금액 세 자리마다 콤마
		moneyFmt("#add-total");
		moneyFmt("#up-total");
		moneyFmt("#add-aimtotal");
		moneyFmt("#update-aimtotal");
		
		if(selectTotal() == '0') { // 총 목표 금액을 설정하지 않은 경우
			$("#add-aimtotal-modal").show();
		} else {
			selectAim(today);
			selectAimTotal(today);
			selectBalance();
		}
		
		autoClose(".select-add-bigcate"); // 분류 선택 닫기
	})
	
	// 총 목표 값 추가
	$(document).on("click", "#add-aimtotal-btn", function() {
		let total = $("#add-aimtotal").val().replaceAll(",", "");
		if(!checkMustReg(total)) {
			alert("입력 값을 확인해주세요.");
		} else {
			$.ajax({
				type : "post",
				url : "insertTotal",
				data : {
					moneytype: "지출",
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
	$(document).on("click", "#total-aim #aim", function() {
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
				url : "updateTotal",
				data : {
					moneytype: "지출",
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
	
})

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
function selectAim(today) {
	$.ajax({
		type: "post",
		url: "selectAim",
		data: {
			date: today,
			userid: userid
		},
		success: function(res) {
			$("#div3").html(res);
		}
	})
}

// 총 목표 값 가져오기
function selectTotal() {
	let result;
	$.ajax({
		type: "post",
		url: "selectTotal",
		async: false,
		data: {
			moneytype: "지출",
			userid: userid
		},
		success: function(res) {
			result = res;
		}
	})
	return result;
}

// 총 목표 및 지출 가져오기
function selectAimTotal(today) {
	$.ajax({
		type: "post",
		url: "selectAimTotal",
		data: {
			moneytype: "지출",
			date: today,
			userid: userid
		},
		success: function(res) {
			$("#div1").html(res);
		}
	})
}

// 분배 가능한 금액
function selectBalance() {
	$.ajax({
		type: "post",
		url: "selectBalance",
		data: {
			userid: userid
		},
		success: function(res) {
			$("#div2").html(res);
		}
	})
}
