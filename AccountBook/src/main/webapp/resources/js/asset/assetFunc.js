$(function() {
	
	// 자산 중복 확인 함수
	$.overlapAsset = function(nameVal) {
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
	
	// 자산 목록 자산그룹별로 그룹화
	$.assetList = function() {
		var result;
		$.ajax({
			type : "post",
			url : "assetList",
			async : false,
			data : {
				userid : userid,
			},
			success : function(res) {
				result = res;
			}
		})
		return result;
	}
	
	// 자산이름 가져오기
	$.assetnameList = function() {
		var result;
		$.ajax({
			type : "post",
			url : "../asset/assetnameList",
			async : false,
			data : {
				userid : userid,
			},
			success : function(res) {
				result = res;
			}
		})
		return result;
	}
	
	// 자산 선택 목록 html
	$.showSelectAsset = function(listDiv) {
		var list = $.assetnameList();
		var html = "<table class='select-table td-border tr-hover'>";
		for(let i = 0; i < list.length; i++) {
			html += "<tr><td>" + list[i] + "</td></tr>";
		}
		html += "</table>";
		$(listDiv).html(html);
		
	}
	
	// 자산 목록 html
	$.showAsset = function() {
		var map = $.assetList();
		var total = 0;
		
		if(Object.keys(map).length > 0) {
			var html1 = "<table>"; // 자산 목록 테이블 만들기
			var html2 = "<table>"; // 자산 목록 테이블 만들기
			
			for(const [key, valList] of Object.entries(map)){
				if(key == "계좌·현금" || key == "카드" || key == "신용카드" || key == "선불카드") {
					html1 += "<tr><td><div class='key-div'>" + key + "</div></td></tr>";
					for(var i = 0; i < valList.length; i++) {
						html1 += "<tr class='tr-asset'><td class='hide'>" + valList[i].assetid + "</td>"; // 자산id
						html1 += "<td class='hide'>" + key + "</td>"; // 자산그룹
						html1 += "<td class='td-select is-border td-asset'><div class='col-5'>" + valList[i].assetname + "</div>"; // 자산명
						if(parseInt(valList[i].total) < 0) { // 금액이 음수면 빨간색으로 출력 
							html1 += "<div class='col-5 text-right red'><money>" + parseInt(valList[i].total).toLocaleString() + "</money>원</div></td>" // 금액
							total += parseInt(valList[i].total);
						} else { // 금액이 양수면 파란색으로 출력 
							html1 += "<div class='col-5 text-right blue'><money>" + parseInt(valList[i].total).toLocaleString() + "</money>원</div></td>"
							total += parseInt(valList[i].total);
						}
						html1 += "<td class='hide'>" + valList[i].memo + "</td>"; // 메모
						html1 += "<td id='open-update-asset'><button class='transfer-icon'>이체</button></td></tr>";
					}
					html1 += "<tr style='height: 30px;'><td></td></tr>";
				} else {
					html2 += "<tr><td><div class='key-div'>" + key + "</div></td></tr>";
					for(var i = 0; i < valList.length; i++) {
						html2 += "<tr class='tr-asset'><td class='hide'>" + valList[i].assetid + "</td>"; // 자산id
						html2 += "<td class='hide'>" + key + "</td>"; // 자산그룹
						html2 += "<td class='td-select is-border td-asset'><div class='col-5'>" + valList[i].assetname + "</div>"; // 자산명
						if(parseInt(valList[i].total) < 0) { // 금액이 음수면 빨간색으로 출력 
							html2 += "<div class='col-5 text-right red'><money>" + parseInt(valList[i].total).toLocaleString() + "</money>원</div></td>" // 금액
							total += parseInt(valList[i].total);
						} else { // 금액이 양수면 파란색으로 출력 
							html2 += "<div class='col-5 text-right blue'><money>" + parseInt(valList[i].total).toLocaleString() + "</money>원</div></td>"
							total += parseInt(valList[i].total);
						}
						html2 += "<td class='hide'>" + valList[i].memo + "</td>"; // 메모
						html2 += "<td id='open-update-asset'><button class='transfer-icon'>이체</button></td></tr>";
					}
					html2 += "<tr style='height: 30px;'><td></td></tr>";
				}
			}
			html1 += "</table>";
			html2 += "</table>";
			
		} else {
			var html1 = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
		}
		
		$("#asset-total-div").html("<i class='h-normal fs23 gray'>합계</i><i class='h-normal fs23'>" + total.toLocaleString() + "원</i>");
		$("#asset1-div").html(html1);
		$("#asset2-div").html(html2);
	}
	
	// 자산 그룹 선택 및 값 자동 입력
	$.pickGroup = function(groupID) {
		$(document).on("click", groupID, function() { // 자산그룹 선택 클릭 시
			$(".select-group-div").show(); // 자산그룹 선택 div 열기
		})
		$(document).on("click", "#asset-group-table td", function() {
			var idx = $(this).parent().index();
			var option = $("#asset-group-table td").eq(idx).text();
			$(groupID).attr("value", option); // input에 값 삽입
			$(".select-group-div").hide();
		})
	}
	
	// 자산 선택 및 값 자동 입력
	$.pickAsset = function(assetid, asset) {
		$(document).on("click", asset, function() {
			$.showSelectAsset(".select-asset-list");
			$(".select-asset-div").show();
		})
		$(document).on("click", ".select-asset-div tr", function() {
			var assetidVal = $(this).children().eq(0).text();
			var assetVal = $(this).children().eq(1).text();
			
			$(assetid).attr("value", assetidVal);
			$(asset).attr("value", assetVal);
			
			$(".select-asset-div").hide();
		})
	}
	
})