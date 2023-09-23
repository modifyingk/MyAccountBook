document.write('<script src="../resources/js/account/account_list.js"></script>'); // 수입/지출 내역 js
document.write('<script src="../resources/js/asset/asset_list.js"></script>'); // 자산 목록 js
document.write('<script src="../resources/js/asset/asset_group.js"></script>'); // 자산 그룹 js
document.write('<script src="../resources/js/asset/transfer.js"></script>'); // 이체 js
document.write('<script src="../resources/js/cal_date.js"></script>'); // 이전 달, 다음 달 구하기 js
document.write('<script src="../resources/js/reg_exp.js"></script>'); // 정규식 js
document.write('<script src="../resources/js/main.js"></script>'); // 모달 및 카테고리 설정 js

$(function() {
	var todayAll; // 현재 날짜 저장할 변수
	
	var clickNum = 0; // 설정 클릭 횟수 (횟수에 따라 설정 열고 닫음)
	
	/* 자산 수정 모달 열기  변수 */
	var originAsset; // 자산 수정 시 원래 자산명
	var originActgroup; // 자산 수정 시 원래 자산그룹명
	var originMemo; // 자산 수정 시 원래 메모
	var originTotal; // 자산 수정 시 원래 금액
	
	var astname; // 선택한 자산 저장할 변수 (해당 자산의 수입/지출 목록 가져올 때 사용할 변수)
	
	/* 자산 그룹 수정 모달 열기 변수 */
	var originGroup;
	
	var selectOp; // 이체 시 출금인지 입금인지 저장할 변수
	
	/* 자산 중복 확인 함수
	   parameter : 중복 확인할 자산명 input ID */
	$.overlapAsset = function(astnameID) {
		var result;
		$.ajax({ 
			type : "post",
			url : "isOverlapAsset",
			async : false,
			data : {
				astname : $(astnameID).val(),
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
	
	/* 자산 수정 함수 */
	$.updateAsset = function() {
		$.ajax({
			type : "post",
			url : "updateAsset",
			data : {
				userid : userid,
				originAsset : originAsset,
				originTotal : originTotal.replaceAll(",", ""),
				updateAsset : $("#up-asset-name").val(),
				updateGroup : $("#up-astgroup-name").val(),
				updateTotal : $("#up-asset-total").val().replaceAll(",", ""),
				updateMemo : $("#up-astmemo-name").val()
			},
			success : function(x) {
				if(x == "success") {
					window.location.reload();
				} else {
					alert("다시 시도해주세요")
				}
			}
		})
	}
	
	/* 자산 그룹 선택 및 값 자동 입력
	   parameter : 자산그룹 선택 input ID */
	$.pickGroup = function(astgroupID) {
		//  자산 그룹 선택
		$(document).on("click", astgroupID, function() { // 자산선택 클릭 시
			$("#select-group-modal").show(); // 자산 선택 모달 열기
		})
		// 자산 그룹 선택 시 input에 값 삽입
		$(document).on("click", "#select-table .group-list", function() {
			var idx = $(this).parent().index();
			var option = $("#select-table .group-list").eq(idx).text();
			
			$(astgroupID).attr("value", option);
			$("#select-group-modal").hide();
		})
	}
	
	$(document).ready(function() {
		// 현재 날짜 가져오기
		todayAll = $.currentYM();

		// 금액에 숫자만 입력되도록
		$.onlyNum("#up-asset-total");
		$.onlyNum("#add-asset-total");
		
		// 금액 세 자리마다 콤마
		$.moneyFmt("#up-asset-total");
		$.moneyFmt("#add-asset-total");
		
		// 자산, 자산그룹의 내용, 메모에 #이 들어가지 않도록
		$.noHash("#up-asset-name");
		$.noHash("#up-astmemo-name");
		$.noHash("#add-asset-name");
		$.noHash("#add-astmemo-name");
		$.noHash("#up-group-name");
		$.noHash("#astgroup");
		
		// 자산그룹 설정 열고 닫기 (우측 상단 설정 버튼)
		$.settingDiv(clickNum, "#open-group-setting", "#group-setting");
		
		// 자산 그룹 가져오기
		$.astgroupList();

		// 전체 자산 목록 및 금액 그룹별로 가져오기
		$.assetAllList(userid);

		// 자산 목록 가져오기 (이체 시 자산 선택 모달)
		$.assetList(userid, "#select-asset-div");
		
		// 자산 그룹 선택 및 값 자동 입력
		$.pickGroup("#add-astgroup-name");
		$.pickGroup("#up-astgroup-name");
		
		// 모달 열기
		$.openModal("#astgroup-btn", "#group-modal"); // 자산 그룹 모달 열기
		
		// 모달 닫기
		$.closeModal("#close-asset-account", "#asset-account-modal"); // 자산별 수입/지출 내역 모달 닫기	
		$.closeModal("#close-add-asset", "#add-asset-modal"); // 자산 추가 모달 닫기
		$.closeModal("#close-up-asset", "#up-asset-modal"); // 자산 수정 모달 닫기
		$.closeModal("#close-select-asset", "#select-asset-modal"); // 자산 선택 모달 닫기
		$.closeModal("#close-select-group", "#select-group-modal"); // 자산 수정에서 자산그룹 선택 모달 닫기
		$.closeModal("#close-group", "#group-modal"); // 자산 그룹 모달 닫기
		$.closeModal("#close-add-group", "#add-group-modal"); // 자산 그룹 추가 모달 닫기
		$.closeModal("#close-up-group", "#up-group-modal"); // 자산 그룹 수정 모달 닫기
		$.closeModal("#close-add-transfer", "#add-transfer-modal"); // 이체 추가 모달 닫기
		$.closeModal("#close-up-transfer", "#up-transfer-modal") // 이체 수정 모달 닫기
	})
	
	// 자산별 수입/지출 목록 가져오기
	$(document).on("click", ".asset-name .td-detail", function() { // asset-name 행 클릭 시
		astname = $(this).eq(0).children().eq(0).text();
		$.astAccountList(todayAll, astname, userid, "#modal-month-div", "#asset-account-list-div", "#total-div", "#total-income-div", "#total-spend-div");
	})
	
	// 자산별 수입/지출 내역 이전 달 클릭
	$(document).on("click", "#modal-before", function() {
		todayAll = $.beforeDate(todayAll); // 날짜 이전 달로 setting
		$.astAccountList(todayAll, astname, userid, "#modal-month-div", "#asset-account-list-div", "#total-div", "#total-income-div", "#total-spend-div")
	})
	
	// 자산별 수입/지출 내역 다음 달 클릭
	$(document).on("click", "#modal-after", function() {
		todayAll = $.afterDate(todayAll); // 날짜 다음 달로 setting
		$.astAccountList(todayAll, astname, userid, "#modal-month-div", "#asset-account-list-div", "#total-div", "#total-income-div", "#total-spend-div")
	})
	
	// 자산 추가 모달 열기
	$(document).on("click", "#add-asset-page", function() {
		$("#add-asset-modal").show();
		$("#add-asset-total").attr("value", "0");
	})
	
	// 자산 추가
	$(document).on("click", "#add-asset-btn", function() {
		if(!$.noEmpty("#up-asset-name") || !$.noEmpty("#up-astgroup-name") || !$.noEmpty("#up-asset-total")){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			var chkName = $.overlapAsset("#add-asset-name"); // 자산명 중복 확인
			if(chkName) { // 중복되지 않으면 추가
				$.ajax({
					type : "post",
					url : "insertAsset",
					data : {
						userid : userid,
						astname : $("#add-asset-name").val(),
						astgroup : $("#add-astgroup-name").val(),
						total : $("#add-asset-total").val().replaceAll(",", ""),
						astmemo : $("#add-astmemo-name").val(),
					},
					success : function(x) {
						if(x == "success") {
							window.location.reload();
						} else {
							alert("다시 시도해주세요")
						}
					}
				})
			} else {
				alert("중복되는 자산입니다");
			}
		}
	})
	
	// 자산 수정 아이콘 클릭 시 수정 모달 열기
	$(document).on("click", "#up-asset-page", function() { // 수정 아이콘(#up-asset-page) 클릭 시
		originAsset = $(this).parent().children().eq(0).children().eq(0).text();
		originActgroup = $(this).parent().children().eq(1).text();
		originMemo = $(this).parent().children().eq(2).text();
		originTotal = $(this).parent().children().eq(0).children().eq(1).text().split("원")[0];
		$("#up-asset-modal").show(); // 자산 수정 모달 열기
		
		$("#up-astgroup-name").attr("value",originActgroup);
		$("#up-asset-name").attr("value", originAsset);
		$("#up-astmemo-name").val(originMemo);
		$("#up-asset-total").attr("value", originTotal);
		
	})
	
	// 자산 수정
	$(document).on("click", "#up-asset-btn", function() {
		if(!$.noEmpty("#up-asset-name") || !$.noEmpty("#up-astgroup-name") || !$.noEmpty("#up-asset-total")){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			if($("#up-asset-name").val() != originAsset) { // 자산명이 변경된 경우
				var chkName = $.overlapAsset("#up-asset-name"); // 자산명 중복 확인
				if(chkName) { // 중복되지 않으면
					$.updateAsset(); // 업데이트
				} else {
					alert("중복되는 자산입니다");
				}
			} else { // 자산명이 변경되지 않은 경우
				$.updateAsset();
			}
		}
	})
	
	// 자산 삭제
	$(document).on("click", "#del-asset-btn", function() {
		var op = confirm(originAsset + " 자산을 삭제하시겠습니까?");
		if(op == true) {
			$.ajax({
				type : "post",
				url : "deleteAsset",
				data : {
					astname : $("#up-asset-name").val(),
					userid : userid
				},
				success : function(x) {
					if(x == "success") {
						window.location.reload();
					} else {
						alert("다시 시도해주세요")
					}
				}
			})
		}
	})
		
	// 자산 초기화
	$(document).on("click", "#reset-asset-btn", function() {
		var op = confirm("초기화 시 생성한 자산이 모두 삭제되고 기본값으로 설정됩니다. 정말로 초기화하시겠습니까?");
		if(op) {
			$.ajax({
				type : "post",
				url : "resetAsset",
				data : {
					userid: userid
				},
				success : function(x) {
					window.location.reload();
				}
			})
		}
	})
	
	// 이체 시 자산 선택
	$(document).on("click", "#add-withdraw-asset", function() { // 출금 자산
		selectOp = "addwithdraw";
		$("#select-asset-modal").show();
	})
	$(document).on("click", "#add-deposit-asset", function() { // 입금 자산
		selectOp = "adddeposit";
		$("#select-asset-modal").show();
	})
	
	// 이체 자산 선택 시 값 자동 입력
	$(document).on("click", ".asset-name", function() {
		if(selectOp == "addwithdraw") {
			$("#add-withdraw-asset").attr("value", $(this).text());
		} else if(selectOp == "adddeposit"){
			$("#add-deposit-asset").attr("value", $(this).text());
		}
		$("#select-asset-modal").hide();
	})
		
})