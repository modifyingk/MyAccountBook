$(function() {
	// 월별 수입/지출 내역
	// parameter : 전송 url(전체, 수입만, 지출만), 날짜, 아이디, 날짜 Div, 수입/지출 내역 Div, 총 합계 Div, 총 수입 Div, 총 지출 Div
	$.accountList = function(ajaxURL, todayAll, userid, monthDiv, accountListDiv, totalDiv, inTotalDiv, outTotalDiv) {
		$.ajax({
			type : "post",
			url : ajaxURL,
			data : {
				date : todayAll,
				userid : userid
			},
			success : function(map) {
				if(Object.keys(map) != "no") {
					var date = Object.keys(map)[0].substr(0, 7).split("-");
					var month_html = "<i class='h-normal fs-28'>" + date[0] + "년 " + date[1] + "월</i>";
					
					var account_html = "<table class='list-table'>";
					var income_total = 0;
					var spend_total = 0;
					
					for(var key in map) {
						account_html += "<tr class='tr-date'><td colspan='5' style='font-weight: bold;'>" + key + "</td></tr>";
						var value = map[key].split(",");
						for(var i = 0; i < value.length; i++) {
							var account = value[i].split("#");
							account_html += "<tr class='tr-content'><td style='display:none;'>" + key + "</td>"; // 날짜
							account_html += "<td style='display:none;'>" + account[0] + "</td>"; // 수입/지출 ID
							account_html += "<td style='display:none;'>" + account[1] + "</td>"; // 수입 또는 지출(moneytype)
							account_html += "<td>" + account[3] + "</td>"; // 카테고리
							account_html += "<td><div>" + account[4] + "</div><div><span class='fs-16 info'>" + account[2] + "</span></div></td>"; // 내용, 자산
							if(account[1] == "수입") {
								account_html += "<td class='text-right blue'>" + parseInt(account[5]).toLocaleString() + "원</td>"; // 돈
								income_total += parseInt(account[5]);
							} else {
								account_html += "<td class='text-right red'>" + parseInt(account[5]).toLocaleString() + "원</td>";
								spend_total += parseInt(account[5]);
							}
							account_html += "<td style='display:none;'>" + account[6] + "</td></tr>"; // 메모
						}
						account_html += "<tr style='border : 0;'></tr>";
					}
					
					account_html += "</table>";
				} else {
					var date = todayAll.split("-");
					var month_html = "<i class='h-normal fs-28'>" + date[0] + "년 " + date[1] + "월</i>";
					var account_html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
					income_total = 0;
					spend_total = 0;
				}
				
				var total_html = "<h4 class='h-normal fs-18 info'>합계</h4><i class='h-normal fs-20'>" + (income_total - spend_total).toLocaleString() + "</i>";
				var income_html = "<h4 class='h-normal fs-18 info'>총 수입</h4><i class='blue h-normal fs-20'>" + income_total.toLocaleString() + "</i>";
				var spend_html = "<h4 class='h-normal fs-18 info'>총 지출</h4><i class='red h-normal fs-20'>" + spend_total.toLocaleString() + "</i>";
				
				$(monthDiv).html(month_html);
				$(accountListDiv).html(account_html);
				$(totalDiv).html(total_html);
				$(inTotalDiv).html(income_html);
				$(outTotalDiv).html(spend_html);
			}
		})
	}
	
	// 월별 지출 통계
	// parameter : 날짜, 아이디, 통계 Div
	$.accountStats = function(todayAll, userid, statsDiv) {
		$.ajax({
			type : "post",
			url : "cateSpend",
			data : {
				date : todayAll,
				userid : userid
			},
			success : function(map) {
				google.charts.load("current", {packages:["corechart"]});
				google.charts.setOnLoadCallback(drawChart);
				var category = Object.keys(map);
				var catedata = new Array(category.length + 1);
				for(var i = 0; i < catedata.length; i++) {
					catedata[i] = Array(2);
				}
				
				catedata[0][0] = "지출";
				catedata[0][1] = "카테고리별 지출 내역";
				
				for(var i = 1; i <= category.length; i++) {
					catedata[i][0] = category[i - 1];
					catedata[i][1] = parseInt(map[category[i - 1]]);
				}
				
				function drawChart() {
			        var data = google.visualization.arrayToDataTable(catedata);

			        var options = {
			                legend: 'none',
			                pieSliceText: 'label',
			                pieStartAngle: 0,
			                chartArea:{left:0,top:0,width:'50%',height:'75%'}
			              };

			        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

			        chart.draw(data, options);
				}
				
				var stats_html = "<table class='list-table'>";
				for(var key in map) {
					stats_html += "<tr class='tr-statscate'><td>" + key + "</td>";
					stats_html += "<td class='red h-normal'>" + map[key].toLocaleString() + "원</td></tr>";
				}
				stats_html += "</table>";
				$(statsDiv).html(stats_html);
			}
		})
	}
	
	// 월별, 자산별 수입/지출 목록 가져오기
	$.astAccountList = function(todayAll, astname, userid, monthDiv, accountListDiv, totalDiv, inTotalDiv, outTotalDiv) {
		$.ajax({
			type : "post",
			url : "assetAccount",
			data : {
				date : todayAll,
				astname : astname,
				userid : userid
			},
			success : function(map) {
				if(Object.keys(map) != "no") {
					var date = Object.keys(map)[0].substr(0, 7).split("-");
					var month_html = "<i class='h-normal fs-23'>" + date[0] + "년 " + date[1] + "월</i>";
					
					var account_html = "<table class='list-table'>";
					var income_total = 0;
					var spend_total = 0;
					
					for(var key in map) {
						account_html += "<tr class='tr-date'><td colspan='5' style='font-weight: bold;'>" + key + "</td></tr>";
						var value = map[key].split(",");
						for(var i = 0; i < value.length; i++) {
							var account = value[i].split("#");
							account_html += "<tr class='tr-content'><td style='display:none;'>" + key + "</td>"; // 날짜
							account_html += "<td style='display:none;'>" + account[0] + "</td>"; // 수입/지출 ID
							account_html += "<td style='display:none;'>" + account[1] + "</td>"; // 수입 또는 지출(moneytype)
							account_html += "<td>" + account[3] + "</td>"; // 카테고리
							account_html += "<td><div>" + account[4] + "</div><div><span class='fs-16 info'>" + account[2] + "</span></div></td>"; // 내용, 자산
							if(account[1] == "수입") {
								account_html += "<td class='text-right blue'>" + parseInt(account[5]).toLocaleString() + "원</td>"; // 돈
								income_total += parseInt(account[5]);
							} else {
								account_html += "<td class='text-right red'>" + parseInt(account[5]).toLocaleString() + "원</td>";
								spend_total += parseInt(account[5]);
							}
							account_html += "<td style='display:none;'>" + account[6] + "</td></tr>"; // 메모
						}
						account_html += "<tr style='border : 0;'></tr>";
					}
					
					account_html += "</table>";
				} else {
					var date = todayAll.split("-");
					var month_html = "<i class='h-normal fs-23'>" + date[0] + "년 " + date[1] + "월</i>";
					var account_html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
					income_total = 0;
					spend_total = 0;
				}
				var total_html = "<h4 class='h-normal fs-18 info'>합계</h4><i class='h-normal fs-20'>" + (income_total - spend_total).toLocaleString() + "</i>";
				var income_html = "<h4 class='h-normal fs-18 info'>총 수입</h4><i class='blue h-normal fs-20'>" + income_total.toLocaleString() + "</i>";
				var spend_html = "<h4 class='h-normal fs-18 info'>총 지출</h4><i class='red h-normal fs-20'>" + spend_total.toLocaleString() + "</i>";
				
				$(monthDiv).html(month_html);
				$(accountListDiv).html(account_html);
				$(totalDiv).html(total_html);
				$(inTotalDiv).html(income_html);
				$(outTotalDiv).html(spend_html);
				/*$("#modal-month-div").html(month_html);
				$("#total-div").html(total_html);
				$("#total-income-div").html(income_html);
				$("#total-spend-div").html(spend_html);
				$("#asset-account-list-div").html(account_html);*/
				
				$("#asset-account-modal").show();
			}
		})
	}
	
})