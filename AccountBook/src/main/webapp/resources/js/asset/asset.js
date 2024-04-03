document.write('<script src="../resources/js/function/htmlFunc.js"></script>'); // html 함수
document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 유효성 검사 함수
document.write('<script src="../resources/js/function/dateFunc.js"></script>'); // 날짜 함수
document.write('<script src="../resources/js/asset/assetFunc.js"></script>'); // 자산 함수

$(function() {
	var date;
	var today;

	var before_assetname;
	
	$(document).ready(function() {
		// 현재 날짜 가져오기
		date = createDate();
		
		// 금액에 숫자만 입력되도록
		onlyNumHypen("#update-asset-total");
		onlyNumHypen("#add-asset-total");
		
		// 금액 세 자리마다 콤마
		moneyFmt("#update-asset-total");
		moneyFmt("#add-asset-total");
		//moneyFmt("#add-transfer-total");
		
		// 전체 자산 목록 및 금액 그룹별로 가져오기
		showAsset(userid);
		
		// 다른 영역 클릭 시 창 닫기
		autoClose(".select-group-div"); // 자산 그룹 선택 닫기
		autoClose(".select-asset-div"); // 자산 선택 닫기

	})
	
	
	// 자산 추가 modal 열기
	$(document).on("click", "#open-add-asset", function() {
		$("#add-asset-group").attr("value", "");
		$("#add-asset-name").attr("value", "");
		$("#add-asset-memo").val("");
		$("#add-asset-total").attr("value", "0");
		
		$("#add-asset-modal").show();
		pickGroup("#add-asset-group");
	})
	
	$(document).on("click", ".key-div", function() {
		$("#add-asset-group").attr("value", $(this).text());
		$("#add-asset-name").attr("value", "");
		$("#add-asset-memo").val("");
		$("#add-asset-total").attr("value", "0");
		
		$("#add-asset-modal").show();
		pickGroup("#add-asset-group");
	})
	
	// 자산 추가
	$(document).on("click", "#add-asset-btn", function() {
		if(!checkMustReg("#add-asset-name") || !checkMustReg("#add-asset-group") || !checkMustReg("#add-asset-total")){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			var chkName = overlapAsset($("#add-asset-name").val()); // 자산명 중복 확인
			if(chkName) { // 중복되지 않으면 추가
				$.ajax({
					type : "post",
					url : "insertAsset",
					data : {
						assetgroup : $("#add-asset-group").val(),
						assetname : $("#add-asset-name").val(),
						total : $("#add-asset-total").val().replaceAll(",", ""),
						memo : $("#add-asset-memo").val(),
						userid : userid,
						active : true
					},
					success : function(res) {
						if(res == true) {
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
	
	// 자산 추가 modal 닫기
	$(document).on("click", "#close-add-asset", function() {
		$("#add-asset-modal").hide();
	})
	
	// 자산 수정 modal 열기
	$(document).on("click", ".tr-asset .td-asset", function() { // 수정 아이콘 td 클릭 시
		var assetid = $(this).parent().children().eq(0).text();
		var assetgroup = $(this).parent().children().eq(1).text();
		var assetname = $(this).parent().children().eq(2).children().eq(0).text();
		var assettotal = $(this).parent().children().eq(2).children().eq(1).children().eq(0).text();
		var assetmemo = $(this).parent().children().eq(3).text();
		
		before_assetname = assetname; // 원래 자산이름 값
		
		$("#update-assetid").attr("value",assetid);
		$("#update-asset-group").attr("value",assetgroup);
		$("#update-asset-name").attr("value", assetname);
		$("#update-asset-memo").val(assetmemo);
		$("#update-asset-total").attr("value", assettotal);
		
		$("#update-asset-modal").show(); // 자산 수정 div 열기
		pickGroup("#update-asset-group");
	})

	// 자산 수정
	$(document).on("click", "#update-asset-btn", function() {
		if(!checkMustReg($("#update-asset-name").val()) || !checkMustReg($("#update-asset-group").val()) || !checkMustReg($("#update-asset-total").val())){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			var chkName;
			if(before_assetname != $("#update-asset-name").val()) { // 자산명이 변경되었다면
				chkName = overlapAsset($("#update-asset-name").val()); // 중복 확인
			} else {
				chkName = true;
			}
			if(chkName) { // 중복되지 않으면
				$.ajax({
					type : "post",
					url : "updateAsset",
					data : {
						assetid : $("#update-assetid").val(),
						assetgroup : $("#update-asset-group").val(),
						assetname : $("#update-asset-name").val(),
						memo : $("#update-asset-memo").text(),
						userid : userid,
						total : $("#update-asset-total").val().replaceAll(",", "")
					},
					success : function(res) {
						if(res == true) {
							window.location.reload();
						} else {
							alert("다시 시도해주세요")
						}
					}
				})
			} else {
				alert("중복되는 자산입니다");
				$("#update-asset-name").focus();
			}
		}
	})
	
	// 자산 삭제
	$(document).on("click", "#delete-asset-btn", function() {
		let op = confirm("정말로 삭제하시겠습니까?");
		if(op) {
			$.ajax({
				type : "post",
				url : "deleteAsset",
				data : {
					assetid : $("#update-assetid").val(),
					userid : userid
				},
				success : function(res) {
					if(res == 1) {
						window.location.reload();
					} else {
						alert("다시 시도해주세요")
					}
				}
			})
		}
	})
	
	// 자산 수정 modal 닫기
	$(document).on("click", "#close-update-asset", function() {
		$("#update-asset-modal").hide();
	})
	
	// 자산 이체 modal 열기
	$(document).on("click", ".transfer-icon", function() {
		var id = $(this).parent().parent().children().eq(0).text();
		var withdraw = $(this).parent().parent().children().eq(2).children().eq(0).text();
		$("#add-transfer-date").attr("value", makeDateFmt(date));
		$("#add-withdraw-id").attr("value", id);
		$("#add-withdraw").attr("value", withdraw);
		
		$("#add-transfer-modal").show(); // 자산 추가 div 열기
	})
	
	// 이체 자산 선택
	$(document).on("click", "#add-deposit", function() {
		showSelectAsset(".select-asset-list");
		$(".select-asset-div").show();
	})
	$(document).on("click", ".select-asset-div tr", function() {
		let assetVal = $(this).children().eq(0).text();
		$("#add-deposit").attr("value", assetVal);
		$(".select-asset-div").hide();
	})
	
	// 자산 이체 modal 닫기
	$(document).on("click", "#close-add-transfer", function() {
		$("#add-transfer-modal").hide();
	})
	
	// 자산 이체
	$(document).on("click", "#add-transfer-btn", function() {
		if($("#add-withdraw").val() == $("#add-deposit").val()) {
			alert("같은 자산으로는 이체가 불가능합니다.")
		} else {
			let date = $("#add-transfer-date").val().replaceAll("-", "");
			let asset = $("#add-withdraw").val() + "→" + $("#add-deposit").val();
			let content = $("#add-transfer-memo").val();
			let total = $("#add-transfer-total").val().replaceAll(",", "");
			console.log(date + " " + asset + " " + content + " " + total);
			$.ajax({
				type : "post",
				url : "../account/insertTransfer",
				data : {
					moneytype: "이체",
					date: date,
					assetname: asset,
					bigcate: "이체",
					content: content,
					total: total,
					userid: userid
				},
				success: function(res) {
					if(res == true) {
						alert("이체 내역 등록이 완료되었습니다.");
						window.location.reload();
					} else {
						alert("다시 시도해주세요")
					}
				}
			})
		}
	})
})

// 자산 중복 확인 함수
function overlapAsset(nameVal) {
	var result;
	$.ajax({ 
		type : "post",
		url : "overlapAsset",
		async : false,
		data : {
			assetname : nameVal,
			userid : userid
		},
		success : function(res) {
			result = res;
		}
	})
	return result;
}

// 자산 목록
function showAsset() {
	$.ajax({
		type : "post",
		url : "selectAsset",
		async : false,
		data : {
			userid : userid,
		},
		success : function(res) {
			$("#asset-list-div").html(res);
		}
	})
}