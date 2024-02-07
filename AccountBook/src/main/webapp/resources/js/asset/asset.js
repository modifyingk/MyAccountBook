document.write('<script src="../resources/js/function/htmlFunc.js"></script>'); // html 함수
document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 유효성 검사 함수
document.write('<script src="../resources/js/function/dateFunc.js"></script>'); // 날짜 함수
document.write('<script src="../resources/js/asset/assetFunc.js"></script>'); // 자산 함수
document.write('<script src="../resources/js/asset/transferFunc.js"></script>'); // 이체

$(function() {
	var date;
	var today; // yyyy-mm 변수

	var before_assetname;
	
	$(document).ready(function() {
		// 현재 날짜 가져오기
		date = $.createDate();
		
		// 금액에 숫자만 입력되도록
		$.onlyNum("#update-asset-total");
		$.onlyNum("#add-asset-total");
		$.onlyNum("#add-transfer-total");
		
		// 금액 세 자리마다 콤마
		$.moneyFmt("#update-asset-total");
		$.moneyFmt("#add-asset-total");
		$.moneyFmt("#add-transfer-total");
		
		// 전체 자산 목록 및 금액 그룹별로 가져오기
		$.showAsset(userid);
		
		$.autoClose(".select-group-div"); // 자산 그룹 선택 닫기

	})
	
	// 자산 추가 div 열기
	$(document).on("click", "#open-add-asset", function() {
		$("#add-asset-group").attr("value","");
		$("#add-asset-name").attr("value", "");
		$("#add-asset-memo").val("");
		$("#add-asset-total").attr("value", "0");
		
		$("#transfer-div").hide();
		$("#update-asset-div").hide();
		$("#hide-asset-div").hide();
		$("#add-transfer-div").hide();
		$("#add-asset-div").show(); // 자산 추가 div 열기
		$.pickGroup("#add-asset-group");
	})
	
	// 자산 추가
	$(document).on("click", "#add-asset-btn", function() {
		if(!$.checkMustReg("#add-asset-name") || !$.checkMustReg("#add-asset-group") || !$.checkMustReg("#add-asset-total")){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			var chkName = $.overlapAsset($("#add-asset-name").val()); // 자산명 중복 확인
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
	
	// 자산 추가 div 닫기
	$(document).on("click", "#close-add-asset", function() {
		$("#add-asset-div").hide();
	})
	
	// 자산 수정 div 열기
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
		
		$("#transfer-div").hide();
		$("#add-asset-div").hide();
		$("#hide-asset-div").hide();
		$("#add-transfer-div").hide();
		$("#update-asset-div").show(); // 자산 수정 div 열기
		$.pickGroup("#update-asset-group");
	})

	// 자산 수정
	$(document).on("click", "#update-asset-btn", function() {
		if(!$.checkMustReg($("#update-asset-name").val()) || !$.checkMustReg($("#update-asset-group").val()) || !$.checkMustReg($("#update-asset-total").val())){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			var chkName;
			if(before_assetname != $("#update-asset-name").val()) { // 자산명이 변경되었다면
				chkName = $.overlapAsset($("#update-asset-name").val()); // 중복 확인
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
		var p = prompt("** 자산을 삭제하면 해당 자산과 관련된 모든 내역이 삭제됩니다. **\n\n내역을 남겨두고 싶으시다면 [비활성화]를 입력해주시고,\n내역을 모두 삭제하시려면 입력란에 [삭제]를 입력해주세요.");
		if(p == "삭제") {
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
		} else if(p == "비활성화") {
			// 숨기기
			$.ajax({
				type : "post",
				url : "activeAsset",
				data : {
					assetid : $("#update-assetid").val(),
					userid : userid,
					active : false
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
	
	// 자산 수정 div 닫기
	$(document).on("click", "#close-update-asset", function() {
		$("#update-asset-div").hide();
	})
	
	// 숨겨진 자산 가져오기
	$(document).on("click", "#open-hide-asset", function() {
		$.ajax({
			type : "post",
			url : "groupByGroup",
			data : {
				userid : userid,
				active : false
			},
			success : function(map) {
				if(Object.keys(map).length > 0) {
					var html = "<table class='select-table'>"; // 자산 목록 테이블 만들기
					
					for(const [key, valList] of Object.entries(map)){
						html += "<tr><td>" + key + "</td></tr>"; // key 값인 자산그룹 출력
						for(var i = 0; i < valList.length; i++) {
							html += "<tr class='tr-asset'><td class='hide'>" + valList[i].assetid + "</td>"; // 자산id
							html += "<td class='td-select is-border td-hide-asset'><div class='col-5'>" + valList[i].assetname + "</div>"; // 자산명
							if(parseInt(valList[i].total) < 0) { // 금액이 음수면 빨간색으로 출력 
								html += "<div class='col-5 text-right red'><money>" + parseInt(valList[i].total).toLocaleString() + "</money>원</div></td>" // 금액
							} else { // 금액이 양수면 파란색으로 출력 
								html += "<div class='col-5 text-right blue'><money>" + parseInt(valList[i].total).toLocaleString() + "</money>원</div></td>"
							}
							html += "<td id='active-asset-btn'><button><i class='i fi-rr-eye'></i></button></td></tr>"; // 숨김 취소
						}
						html += "<tr><td></td></tr>";
					}
					html += "</table>";
				} else {
					var html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
				}
				$("#hide-asset-list-div").html(html);
			}
		})
		
		$("#transfer-div").hide();
		$("#add-asset-div").hide();
		$("#add-transfer-div").hide();
		$("#update-asset-div").hide();
		$("#hide-asset-div").show();
	})
	
	// 숨겨진 자산 div 닫기
	$(document).on("click", "#close-hide-asset", function() {
		$("#hide-asset-div").hide();
	})
	
	// 자산 활성화
	$(document).on("click", "#active-asset-btn", function() {
		var idVal = $(this).parent().children().eq(0).text();
		$.ajax({
			type: "post",
			url: "activeAsset",
			data: {
				assetid: idVal,
				userid: userid,
				active: true
			},
			success: function(res) {
				if(res == 1) {
					window.location.reload();
				} else {
					alert("다시 시도해주세요")
				}
			}
		})
	})
	
	// 자산 이체 div 열기
	$(document).on("click", ".transfer-icon", function() {
		var id = $(this).parent().parent().children().eq(0).text();
		var withdraw = $(this).parent().parent().children().eq(2).children().eq(0).text();
		$("#add-transfer-date").attr("value", $.getFullDate(date));
		$("#add-withdraw-id").attr("value", id);
		$("#add-withdraw").attr("value", withdraw);
		
		$("#transfer-div").hide();
		$("#add-asset-div").hide();
		$("#update-asset-div").hide();
		$("#hide-asset-div").hide();
		$("#add-transfer-div").show(); // 자산 추가 div 열기
		
		$.pickAsset("#add-deposit-id", "#add-deposit");
	})
	
	// 자산 이체 div 닫기
	$(document).on("click", "#close-add-transfer", function() {
		$("#add-transfer-div").hide();
	})
	
	// 자산 이체
	$(document).on("click", "#add-transfer-btn", function() {
		if($("#add-withdraw-id").val() == $("#add-deposit-id").val()) {
			alert("이체가 불가능합니다.")
		} else {
			$.ajax({
				type : "post",
				url : "../transfer/insertTransfer",
				data : {
					date: $("#add-transfer-date").val(),
					withdrawid: $("#add-withdraw-id").val(),
					withdraw: $("#add-withdraw").val(),
					depositid: $("#add-deposit-id").val(),
					deposit: $("#add-deposit").val(),
					total: $("#add-transfer-total").val().replaceAll(",", ""),
					memo: $("#add-transfer-memo").val(),
					userid: userid
				},
				success: function(res) {
					if(res == true) {
						window.location.reload();
					} else {
						alert("다시 시도해주세요")
					}
				}
			})
		}
	})
	
	// 자산 이체 내역 페이지 열기
	$(document).on("click", "#open-transfer-list", function() {
		location.href = "transfer.jsp";
	})
})