$(function() {
	// 날짜 세팅
	$.setDate = function(year, month) {
		$("#month-div").html("<i class='h-normal fs-28'>" + year + "년 " + month + "월</i>")
	}
	
	// 이체 내역 가져오기
	$.transferList = function(dateVal, useridVal) {
		var result;
		$.ajax({
			type: "post",
			url: "../transfer/transferList",
			async: false,
			data: {
				date : dateVal,
				userid : useridVal
			},
			success: function(res) {
				result = res;
			}
		})
		return result;
	}
	
	$.showTransfer = function(dateVal, useridVal) {
		var map = $.transferList(dateVal, useridVal);
		
		if(Object.keys(map).length > 0) {
			var html = "<table class='list-table'>";
			
			for(const [key, valList] of Object.entries(map)){
				html += "<tr class='tr-date'><td colspan='5' style='font-weight: bold;'>" + $.getDay(key) + "일</td></tr>";
				for(var i = 0; i < valList.length; i++) {
					html += "<tr class='tr-content'><td style='display:none;'>" + key + "</td>";
					html += "<td style='display:none;'>" + valList[i].transferid + "</td>";
					html += "<td class='info'><span>" + valList[i].withdraw + "</span> → <span>" + valList[i].deposit + "</span></td>"; // 출금 입금
					html += "<td><money>" + parseInt(valList[i].total).toLocaleString() + "</money>원</td>";
					html += "<td style='display:none;'>" + valList[i].memo + "</td></tr>"; // 메모
				}
				html += "<tr style='border : 0;'></tr>";
			}
			html += "</table>";
		} else {
			var html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
		}
		
		$("#transfer-list-div").html(html);
	}
})