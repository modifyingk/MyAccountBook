$(function() {
	// 월별 이체 내역
	// parameter : 날짜, 아이디, 날짜 Div, 이체 내역 Div
	$.transferList = function(todayAll, userid, monthDiv, transferListDiv) {
		$.ajax({
			type : "post",
			url : "../transfer/transferInfo",
			data : {
				date : todayAll,
				userid : userid
			},
			success : function(map) {
				var date = todayAll.split("-");
				var month_html = "<i class='h-normal fs-28'>" + date[0] + "년 " + date[1] + "월</i>";
				var transfer_html = "";
				
				if(Object.keys(map) != "no") {
					transfer_html = "<table class='list-table'>";
					for(var key in map) {
						transfer_html += "<tr class='tr-transfer-date'><td colspan='2' style='font-weight: bold;'>" + key + "</td></tr>";
						var value = map[key].split(",");
						for(var i = 0; i < value.length; i++) {
							var transfer = value[i].split("#");
							transfer_html += "<tr class='tr-transfer-content'><td style='display:none;'>" + transfer[0] + "</td>"; // 이체 아이디
							transfer_html += "<td class='info'><span>" + transfer[1] + "</span> → <span>" + transfer[2] + "</span></td>"; // 출금 입금
							transfer_html += "<td>" + parseInt(transfer[3]).toLocaleString() + "</td>"; // 금액
							transfer_html += "<td style='display:none;'>" + transfer[4] + "</td></tr>"; // 메모
						}
					}
					
				} else {
					transfer_html = "<div class='no-data-div' style='margin-right:15%;'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
				}
				$(monthDiv).html(month_html);
				$(transferListDiv).html(transfer_html);
			}
		})
	}
})