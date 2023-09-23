$(function() {
	// 지출 목표 가져오기
	// parameter : 날짜, 아이디, 날짜 Div, 목표 Div
	$.aimList = function(todayAll, userid, monthDiv, aimListDiv) {
		$.ajax({
			type : "post",
			url : "aimInfo",
			data : {
				moneytype : "지출",
				aimdate : todayAll,
				userid : userid
			},
			success : function(map) {
				var date = todayAll.split("-");
				var month_html = "<i class='h-normal fs-28'>" + date[0] + "년 " + date[1] + "월</i>";

				var aim_html = "";
				if(Object.keys(map) != "no") {
					aim_html += "<table class='gage-table' style='width: 1200px;' id='out-aim-table'>";
	
					for(var key in map) {
						var value = map[key].split(",");
						for(var i = 0; i < value.length; i++) {
							var aim = value[i].split("#");
							var percent = Math.round(parseInt(aim[2]) / parseInt(aim[1]) * 100);
							
							aim_html += "<tr><td style='display:none;'>" + aim[0] + "</td>";
							aim_html += "<td>" + key + "</td><td><div class='gage-bar is-border'>";
							
							if(percent < 50) {
								aim_html += "<div class='gage safe-aim is-border' style='width: " + percent + "%;'>" + percent + "%</div>";
								aim_html += "</div></td><td colspan='2'>" + parseInt(aim[2]).toLocaleString() + "원 / " + parseInt(aim[1]).toLocaleString() + "원</td></tr>";
							} else if(percent < 70) {
								aim_html += "<div class='gage warn-aim is-border' style='width: " + percent + "%;'>" + percent + "%</div>";
								aim_html += "</div></td><td>" + parseInt(aim[2]).toLocaleString() + "원 / " + parseInt(aim[1]).toLocaleString() + "원</td>";
								aim_html += "<td class='warn'><i class='fi fi-rr-triangle-warning fs-28'></i> 주의</td></tr>";
							} else if(percent <= 100){
								aim_html += "<div class='gage danger-aim is-border' style='width: " + percent + "%;'>" + percent + "%</div>";
								aim_html += "</div></td><td>" + parseInt(aim[2]).toLocaleString() + "원 / " + parseInt(aim[1]).toLocaleString() + "원</td>";
								aim_html += "<td class='warning'><i class='fi fi-rr-light-emergency-on fs-28'></i> 위험</td></tr>";
							} else {
								aim_html += "<div class='gage danger-aim is-border' style='width: 100%;'>" + percent + "%</div>";
								aim_html += "</div></td><td>" + parseInt(aim[2]).toLocaleString() + "원 / " + parseInt(aim[1]).toLocaleString() + "원</td>";
								aim_html += "<td class='warning'><i class='fi fi-rr-light-emergency-on fs-28'></i> 초과</td></tr>";
							}
						}
					}
					aim_html += "</table>";
				} else {
					aim_html += "<div class='no-aim-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
				}
				$(monthDiv).html(month_html);
				$(aimListDiv).html(aim_html);
			}
		})
	}
	
	// 수입 목표 가져오기
	// parameter : 날짜, 아이디, 목표 Div
	$.inaimList = function(todayAll, userid, aimlistDiv) {
		$.ajax({
			type : "post",
			url : "aimInfo",
			data : {
				moneytype : "수입",
				aimdate : todayAll,
				userid : userid
			},
			success : function(map) {
				var aim_in_html = "";
				if(Object.keys(map) != "no") {
					aim_in_html += "<table class='gage-table' style='width: 1200px;' id='in-aim-table'>";
					
					for(var key in map) {
						var value = map[key].split(",");
						for(var i = 0; i < value.length; i++) {
							var aim = value[i].split("#");
							var percent = Math.round(parseInt(aim[2]) / parseInt(aim[1]) * 100);
							
							aim_in_html += "<tr><td style='display:none;'>" + aim[0] + "</td>";
							aim_in_html += "<td>" + key + "</td><td><div class='gage-bar is-border'>";
							
							if(percent < 100) {
								aim_in_html += "<div class='gage blue-aim is-border' style='width: " + percent + "%;'>" + percent + "%</div>";
							} else {
								aim_in_html += "<div class='gage blue-aim is-border' style='width: 100%;'>" + percent + "%</div>";
							}
							aim_in_html += "</div></td>";
							aim_in_html += "<td>" + parseInt(aim[2]).toLocaleString() + "원 / " + parseInt(aim[1]).toLocaleString() + "원</td></tr>";
						}
					}
					aim_in_html += "</table>";
				} else {
					aim_in_html += "<div class='no-aim-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
				}
				
				$(aimlistDiv).html(aim_in_html);
			}
		})
	}
})