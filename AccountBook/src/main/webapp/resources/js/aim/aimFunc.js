$(function() {
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
			success : function(res) {
				result = res;
			}
		})
		return result;
	}
	
	// 지출 목표 가져오기
	$.aimList = function(today, userid, monthDiv, aimListDiv) {
		$.ajax({
			type : "post",
			url : "aimInfo",
			data : {
				moneytype : "지출",
				aimdate : today,
				userid : userid
			},
			success : function(map) {
				var date = today.split("-");
				var month_html = "<i class='h-normal fs-28'>" + date[0] + "년 " + date[1] + "월</i>";

				var aim_html = "";
				if(Object.keys(map).length > 0) {
					var html = "<table class='gage-table' id='in-aim-table'>";
					for(const [key, val] of Object.entries(map)) {
						var percent = Math.round(val.total / val.aim_money * 100);
						
						html += "<tr><td style='display:none;'>" + val.aimid + "</td>";
						if((val.aim_money - val.total) > 0) {
							html += "<td>" + key + "</td><td title='" + (val.aim_money - val.total).toLocaleString() + "원 더 사용할 수 있습니다!'><div class='gage-bar is-border'>";
						} else {
							html += "<td>" + key + "</td><td title='목표를 초과했습니다...'><div class='gage-bar is-border'>";
						}
						
						if(percent < 50) {
							html += "<div class='gage safe-aim is-border' style='width: " + percent + "%;'>" + percent + "%</div>";
							html += "</div></td><td>" + val.total.toLocaleString() + "원 / " + val.aim_money.toLocaleString() + "원</td></tr>";
						} else if(percent < 70) {
							html += "<div class='gage warn-aim is-border' style='width: " + percent + "%;'>" + percent + "%</div>";
							html += "</div></td><td class='yellow'>" + val.total.toLocaleString() + "원 / " + val.aim_money.toLocaleString() + "원</td>";
						} else if(percent <= 100){
							html += "<div class='gage danger-aim is-border' style='width: " + percent + "%;'>" + percent + "%</div>";
							html += "</div></td><td class='red'>" + val.total.toLocaleString() + "원 / " + val.aim_money.toLocaleString() + "원</td>";
						} else {
							html += "<div class='gage danger-aim is-border' style='width: 100%;'>" + percent + "%</div>";
							html += "</div></td><td class='red'>" + val.total.toLocaleString() + "원 / " + val.aim_money.toLocaleString() + "원</td>";
						}
					}
					html += "</table>";
				} else {
					var html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
				}
				$(monthDiv).html(month_html);
				$(aimListDiv).html(html);
			}
		})
	}
	
	// 수입 목표 가져오기
	$.inaimList = function(today, userid, aimlistDiv) {
		$.ajax({
			type : "post",
			url : "aimInfo",
			data : {
				moneytype : "수입",
				aimdate : today,
				userid : userid
			},
			success : function(map) {
				if(Object.keys(map).length > 0) {
					var html = "<table class='gage-table' id='in-aim-table'>";
					for(const [key, val] of Object.entries(map)) {
						var percent = Math.round(val.total / val.aim_money * 100);
						html += "<tr><td style='display:none;'>" + val.aimid + "</td>";
							
						if((val.aim_money - val.total) > 0) {
							html += "<td>" + key + "</td><td title='목표 달성까지 " + (val.aim_money - val.total).toLocaleString() + "원 남았습니다!'><div class='gage-bar is-border'>";
						} else {
							html += "<td>" + key + "</td><td title='목표 달성 성공!'><div class='gage-bar is-border'>";
						}
							
						if(percent < 100) {
							html += "<div class='gage blue-aim is-border' style='width: " + percent + "%;'>" + percent + "%</div>";
						} else {
							html += "<div class='gage blue-aim is-border' style='width: 100%;'>" + percent + "%</div>";
						}
						html += "</div></td>";
						html += "<td>" + val.total.toLocaleString() + "원 / " + val.aim_money.toLocaleString() + "원</td></tr>";
					}
					html += "</table>";
				}
				else {
					var html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
				}
				$(aimlistDiv).html(html);
			}
		})
	}
})