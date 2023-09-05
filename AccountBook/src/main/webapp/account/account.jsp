<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 수입/지출 관리</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-solid-rounded/css/uicons-solid-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
	$(function() {
		var userid = "<%= session.getAttribute("userid") %>";

		// 월별로 수입/지출 목록 가져오기
		var today = new Date();
		var todayYear = today.getFullYear();
		var todayMonth = today.getMonth() + 1 + "";
		
		if(todayMonth.length == 1) {
			todayMonth = "0" + todayMonth;
		}
		var todayAll = todayYear + "-" + todayMonth;
		
		// 전체 지출 내역
		$.ajax({
			type : "post",
			url : "monthAccount",
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
								account_html += "<td class='text-right blue'>" + account[5] + "원</td>"; // 돈
								income_total += parseInt(account[5]);
							} else {
								account_html += "<td class='text-right red'>" + account[5] + "원</td>";
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
				
				var total_html = "<h4 class='h-normal fs-18 info'>합계</h4><i class='h-normal fs-20'>" + (income_total - spend_total) + "</i>";
				var income_html = "<h4 class='h-normal fs-18 info'>총 수입</h4><i class='blue h-normal fs-20'>" + income_total + "</i>";
				var spend_html = "<h4 class='h-normal fs-18 info'>총 지출</h4><i class='red h-normal fs-20'>" + spend_total + "</i>";
				
				$("#month-div").html(month_html);
				$("#month-account-list-div").html(account_html);
				$("#total-div").html(total_html);
				$("#total-income-div").html(income_html);
				$("#total-spend-div").html(spend_html);
			}
		})
		// 통계
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
					stats_html += "<td class='red h-normal'>" + map[key] + "원</td></tr>";
				}
				stats_html += "</table>";
				$("#category-stats-div").html(stats_html);
			}
		})
		// 이전 달
		$("#before").click(function() {
			if($("#in-account-btn").hasClass("active")) {
				$("#in-account-btn").removeClass("active");
				$("#total-account-btn").addClass("active");
			} else if($("#out-account-btn").hasClass("active")) {
				$("#out-account-btn").removeClass("active");
				$("#total-account-btn").addClass("active");
			}
			
			var current = todayAll.split("-");
			var beforeYear;
			var beforeMonth;
			var beforeAll;
			
			if(current[1] == "01") {
				beforeYear = (parseInt(current[0]) - 1) + "";
				beforeMonth = "12";
			} else {
				beforeYear = current[0];
				beforeMonth = (parseInt(current[1]) - 1) + "";
			}
			if(beforeMonth.length == 1) {
				beforeMonth = "0" + beforeMonth;
			}
			beforeAll = beforeYear + "-" + beforeMonth;
			todayAll = beforeAll;			
			$.ajax({
				type : "post",
				url : "monthAccount",
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
									account_html += "<td class='text-right blue'>" + account[5] + "원</td>"; // 돈
									income_total += parseInt(account[5]);
								} else {
									account_html += "<td class='text-right red'>" + account[5] + "원</td>";
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
					var total_html = "<h4 class='h-normal fs-18 info'>합계</h4><i class='h-normal fs-20'>" + (income_total - spend_total) + "</i>";
					var income_html = "<h4 class='h-normal fs-18 info'>총 수입</h4><i class='blue h-normal fs-20'>" + income_total + "</i>";
					var spend_html = "<h4 class='h-normal fs-18 info'>총 지출</h4><i class='red h-normal fs-20'>" + spend_total + "</i>";
					
					$("#month-div").html(month_html);
					$("#month-account-list-div").html(account_html);
					$("#total-div").html(total_html);
					$("#total-income-div").html(income_html);
					$("#total-spend-div").html(spend_html);
				}
			})
			
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
						stats_html += "<td class='red h-normal'>" + map[key] + "원</td></tr>";
					}
					stats_html += "</table>";
					$("#category-stats-div").html(stats_html);
				}
			})
		})
		// 다음 달
		$("#after").click(function() {
			if($("#in-account-btn").hasClass("active")) {
				$("#in-account-btn").removeClass("active");
				$("#total-account-btn").addClass("active");
			} else if($("#out-account-btn").hasClass("active")) {
				$("#out-account-btn").removeClass("active");
				$("#total-account-btn").addClass("active");
			}
			
			var current = todayAll.split("-");
			var afterYear;
			var afterMonth;
			var afterAll;
			
			if(current[1] == "12") {
				afterYear = (parseInt(current[0]) + 1) + "";
				afterMonth = "01";
			} else {
				afterYear = current[0];
				afterMonth = (parseInt(current[1]) + 1) + "";
			}
			if(afterMonth.length == 1) {
				afterMonth = "0" + afterMonth;
			}
			afterAll = afterYear + "-" + afterMonth;
			todayAll = afterAll;	
			
			$.ajax({
				type : "post",
				url : "monthAccount",
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
									account_html += "<td class='text-right blue'>" + account[5] + "원</td>"; // 돈
									income_total += parseInt(account[5]);
								} else {
									account_html += "<td class='text-right red'>" + account[5] + "원</td>";
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
					var total_html = "<h4 class='h-normal fs-18 info'>합계</h4><i class='h-normal fs-20'>" + (income_total - spend_total) + "</i>";
					var income_html = "<h4 class='h-normal fs-18 info'>총 수입</h4><i class='blue h-normal fs-20'>" + income_total + "</i>";
					var spend_html = "<h4 class='h-normal fs-18 info'>총 지출</h4><i class='red h-normal fs-20'>" + spend_total + "</i>";
					
					$("#month-div").html(month_html);
					$("#month-account-list-div").html(account_html);
					$("#total-div").html(total_html);
					$("#total-income-div").html(income_html);
					$("#total-spend-div").html(spend_html);
				}
			})
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
						stats_html += "<td class='red h-normal'>" + map[key] + "원</td></tr>";
					}
					stats_html += "</table>";
					$("#category-stats-div").html(stats_html);
				}
			})
		})
		$(document).on("click", ".tr-statscate", function() {
			var catename = $(this).children().eq(0).text();
			$.ajax({
				type : "post",
				url : "monthCateSpend",
				data : {
					catename : catename,
					date : todayAll,
					userid : userid
				},
				success : function(map) {
					if(Object.keys(map) != "no") {
						var spend_total = 0;
						var catepend_html = "<table class='list-table'>";
						
						for(var key in map) {
							catepend_html += "<tr class='tr-date'><td colspan='5' style='font-weight: bold;'>" + key + "</td></tr>";
							var value = map[key].split(",");
							for(var i = 0; i < value.length; i++) {
								var account = value[i].split("#");
								catepend_html += "<tr class='tr-content'><td style='display:none;'>" + key + "</td>"; // 날짜
								catepend_html += "<td style='display:none;'>" + account[0] + "</td>"; // 수입/지출 ID
								catepend_html += "<td style='display:none;'>" + account[1] + "</td>"; // 수입 또는 지출(moneytype)
								catepend_html += "<td>" + account[3] + "</td>"; // 카테고리
								catepend_html += "<td><div>" + account[4] + "</div><div><span class='fs-16 info'>" + account[2] + "</span></div></td>"; // 내용, 자산
								catepend_html += "<td class='text-right red'>" + account[5] + "원</td>";
								spend_total += parseInt(account[5]);
								catepend_html += "<td style='display:none;'>" + account[6] + "</td></tr>"; // 메모
							}
							catepend_html += "<tr style='border : 0;'></tr>";
						}
						catepend_html += "</table>";
						
					} else {
						var catepend_html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
					}
					$("#catespend-total-div").html("<h4 class='h-normal fs-23'>총 지출 <i class='red h-normal fs-20'>" + spend_total + "원</i></h4><br>");
					$("#catename-div").html("<h3 class='h-normal fs-28'><i class='fi fi-rr-money-check-edit'></i> " + catename + "</h3>");
					$("#catespend-list-div").html(catepend_html);
				}
			})
			$("#catespend-modal").show();
		})
		$("#close-catespend").click(function() {
			$("#catespend-modal").hide();
		})
		// 전체 내역, 수입 내역, 지출 내역
		$("#total-account-btn").click(function() {
			if($("#in-account-btn").hasClass("active")) {
				$("#in-account-btn").removeClass("active");
				$("#total-account-btn").addClass("active");
			} else if($("#out-account-btn").hasClass("active")) {
				$("#out-account-btn").removeClass("active");
				$("#total-account-btn").addClass("active");
			}
			$.ajax({
				type : "post",
				url : "monthAccount",
				data : {
					date : todayAll,
					userid : userid
				},
				success : function(map) {
					if(Object.keys(map) != "no") {
						var date = Object.keys(map)[0].substr(0, 7).split("-");
						var month_html = "<i class='h-normal fs-28'>" + date[0] + "년 " + date[1] + "월</i>";
						
						var account_html = "<table class='list-table'>";
		
						for(var key in map) {
							account_html += "<tr class='tr-date'><td colspan='5' style='font-weight: bold;'>" + key + "</td></tr>";
							var value = map[key].split(",");
							for(var i = 0; i < value.length; i++) {
								var account = value[i].split("#");
								account_html += "<tr class='tr-content'><td style='display:none;'>" + key + "</td>"; // 날짜
								account_html += "<td style='display:none;'>" + account[0] + "</td>"; // 수입/지출 ID
								account_html += "<td style='display:none;'>" + account[1] + "</td>"; // 수입 또는 지출(moneytype)
								account_html += "<td style='display:none;'>" + account[2] + "</td>"; // 자산
								account_html += "<td>" + account[3] + "</td>"; // 카테고리
								account_html += "<td>" + account[4] + "</td>"; // 내용
								if(account[1] == "수입") {
									account_html += "<td class='text-right blue'>" + account[5] + "원</td>"; // 돈
								} else {
									account_html += "<td class='text-right red'>" + account[5] + "원</td>";
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
					}
					$("#month-div").html(month_html);
					$("#month-account-list-div").html(account_html);
				}
			})
		})
		$("#in-account-btn").click(function() {
			if($("#total-account-btn").hasClass("active")) {
				$("#total-account-btn").removeClass("active");
				$("#in-account-btn").addClass("active");
			} else if($("#out-account-btn").hasClass("active")) {
				$("#out-account-btn").removeClass("active");
				$("#in-account-btn").addClass("active");
			}
			$.ajax({
				type : "post",
				url : "monthIncome",
				data : {
					date : todayAll,
					userid : userid
				},
				success : function(map) {
					if(Object.keys(map) != "no") {
						var date = Object.keys(map)[0].substr(0, 7).split("-");
						var month_html = "<i class='h-normal fs-28'>" + date[0] + "년 " + date[1] + "월</i>";
						
						var account_html = "<table class='list-table'>";
		
						for(var key in map) {
							account_html += "<tr class='tr-date'><td colspan='5' style='font-weight: bold;'>" + key + "</td></tr>";
							var value = map[key].split(",");
							for(var i = 0; i < value.length; i++) {
								var account = value[i].split("#");
								account_html += "<tr class='tr-content'><td style='display:none;'>" + key + "</td>"; // 날짜
								account_html += "<td style='display:none;'>" + account[0] + "</td>"; // 수입/지출 ID
								account_html += "<td style='display:none;'>" + account[1] + "</td>"; // 수입 또는 지출(moneytype)
								account_html += "<td style='display:none;'>" + account[2] + "</td>"; // 자산
								account_html += "<td>" + account[3] + "</td>"; // 카테고리
								account_html += "<td>" + account[4] + "</td>"; // 내용
								if(account[1] == "수입") {
									account_html += "<td class='text-right blue'>" + account[5] + "원</td>"; // 돈
								} else {
									account_html += "<td class='text-right red'>" + account[5] + "원</td>";
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
					}
					$("#month-div").html(month_html);
					$("#month-account-list-div").html(account_html);
				}
			})
		})
		$("#out-account-btn").click(function() {
			if($("#total-account-btn").hasClass("active")) {
				$("#total-account-btn").removeClass("active");
				$("#out-account-btn").addClass("active");
			} else if($("#in-account-btn").hasClass("active")) {
				$("#in-account-btn").removeClass("active");
				$("#out-account-btn").addClass("active");
			}
			$.ajax({
				type : "post",
				url : "monthSpend",
				data : {
					date : todayAll,
					userid : userid
				},
				success : function(map) {
					if(Object.keys(map) != "no") {
						var date = Object.keys(map)[0].substr(0, 7).split("-");
						var month_html = "<i class='h-normal fs-28'>" + date[0] + "년 " + date[1] + "월</i>";
						
						var account_html = "<table class='list-table'>";
		
						for(var key in map) {
							account_html += "<tr class='tr-date'><td colspan='5' style='font-weight: bold;'>" + key + "</td></tr>";
							var value = map[key].split(",");
							for(var i = 0; i < value.length; i++) {
								var account = value[i].split("#");
								account_html += "<tr class='tr-content'><td style='display:none;'>" + key + "</td>"; // 날짜
								account_html += "<td style='display:none;'>" + account[0] + "</td>"; // 수입/지출 ID
								account_html += "<td style='display:none;'>" + account[1] + "</td>"; // 수입 또는 지출(moneytype)
								account_html += "<td style='display:none;'>" + account[2] + "</td>"; // 자산
								account_html += "<td>" + account[3] + "</td>"; // 카테고리
								account_html += "<td>" + account[4] + "</td>"; // 내용
								if(account[1] == "수입") {
									account_html += "<td class='text-right blue'>" + account[5] + "원</td>"; // 돈
								} else {
									account_html += "<td class='text-right red'>" + account[5] + "원</td>";
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
					}
					$("#month-div").html(month_html);
					$("#month-account-list-div").html(account_html);
				}
			})
		})
		
		/* ---------------------------- 수입/지출 목록 ---------------------------- */
		// 수입/지출 목록 가져오기
		/* $.ajax({
			type : "post",
			url : "accountInfo",
			data : {
				userid : userid
			},
			success : function(map) {
				var account_html = "<table class='list-table'>";

				for(var key in map) {
					account_html += "<tr class='tr-date'><td colspan='5' style='font-weight: bold;'>" + key + "</td></tr>";
					var value = map[key].split(",");
					for(var i = 0; i < value.length; i++) {
						var account = value[i].split("/");
						account_html += "<tr class='tr-content'><td style='display:none;'>" + key + "</td>"; // 날짜
						account_html += "<td style='display:none;'>" + account[0] + "</td>"; // 수입/지출 ID
						account_html += "<td style='display:none;'>" + account[1] + "</td>"; // 수입 또는 지출(moneytype)
						account_html += "<td style='display:none;'>" + account[2] + "</td>"; // 자산
						account_html += "<td>" + account[3] + "</td>"; // 카테고리
						account_html += "<td>" + account[4] + "</td>"; // 내용
						if(account[1] == "수입") {
							account_html += "<td class='text-right blue'>" + account[5] + "원</td>"; // 돈
						} else {
							account_html += "<td class='text-right red'>" + account[5] + "원</td>";
						}
						account_html += "<td style='display:none;'>" + account[6] + "</td></tr>"; // 메모
					}
					account_html += "<tr style='border : 0;'><td></td></tr>";
				}
				
				account_html += "</table>";
				$("#account-list-div").html(account_html);
			}
		}) */
		// 날짜 tr 클릭 시
		$(document).on("click", ".tr-date", function() {
			var date = $(this).text();
			$("#add-account-modal").show();
			$("#add-actdate").attr("value", date);
		})
		// 내용 tr 클릭 시
		$(document).on("click", ".tr-content", function() {
			var actdate = $(this).children().eq(0).text();
			var actid = $(this).children().eq(1).text();
			var actmoneytype = $(this).children().eq(2).text();
			var actasset = $(this).children().eq(4).children().eq(1).text();
			var actcatename = $(this).children().eq(3).text();
			var actcontent = $(this).children().eq(4).children().eq(0).text();
			var acttotal = $(this).children().eq(5).text();
			var actmemo = $(this).children().eq(6).text();
			
			$("#up-account-modal").show();
			$("#up-actdate").attr("value", actdate);
			$("#up-actid").attr("value", actid);
			$("#up-actasset").attr("value", actasset);
			$("#up-actcatename").attr("value", actcatename);
			$("#up-actcontent").attr("value", actcontent);
			$("#up-acttotal").attr("value", acttotal.split("원")[0]);
			$("#up-actmemo").html(actmemo);
			
			if(actmoneytype == "수입") {
				$("input:radio[name='up-mtype'][value='수입']").attr("checked", true);
			} else {
				$("input:radio[name='up-mtype'][value='지출']").attr("checked", true);
			}
		})
		// 수입/지출 수정 - 자산 선택
		$("#up-actasset").click(function() {
			$("#select-asset-modal").show();
		})
		$(document).on("click", "#asset-table tr", function() {
			var assetName = $(this).text();
			$("#up-actasset").attr("value", assetName);
			$("#select-asset-modal").hide();
		})
		// 수입/지출 수정 - 카테고리 선택
		$("#up-actcatename").click(function() {
			var mtype = $("input[name=up-mtype]:checked").val(); // 선택된 값 변수에 저장
			if(mtype == "수입") {
				// 수입 카테고리 리스트 모달
				$("#select-incate-modal").show();
			} else {
				// 지출 카테고리 리스트 모달
				$("#select-outcate-modal").show();
			}
		})
		// 수입/지출 수정에서 수입/지출 radio 클릭 시 카테고리 선택 모닯 띄우기
		$("input:radio[name='up-mtype']").click(function() {
			$("#up-actcatename").attr("value", "");
			var mtype = $("input[name=up-mtype]:checked").val(); // 선택된 값 변수에 저장
			if(mtype == "수입") {
				// 수입 카테고리 리스트 모달
				$("#select-incate-modal").show();
			} else {
				// 지출 카테고리 리스트 모달
				$("#select-outcate-modal").show();
			}
		})
		$(document).on("click", "#select-incate-list-div #in-category-table tr", function() {
			originName = $(this).children().eq(1).text();
			$("#up-actcatename").attr("value", originName); // 수정 모달 input에 현재 이름 값 삽입
			$("#select-incate-modal").hide();
		})
		$(document).on("click", "#select-outcate-list-div #out-category-table tr", function() {
			originName = $(this).children().eq(1).text();
			$("#up-actcatename").attr("value", originName); // 수정 모달 input에 현재 이름 값 삽입
			$("#select-outcate-modal").hide();
		})
		// 수입/지출 수정 모달 닫기
		$("#close-up-account").click(function() {
			$("#up-account-modal").hide();
		})
		// 수정 버튼 클릭
		$("#up-account-btn").click(function() {
			$.ajax({
				type : "post",
				url : "updateAccount",
				data : {
					moneytype :  $("input[name=up-mtype]:checked").val(),
					date : $("#up-actdate").val(),
					astname : $("#up-actasset").val(),
					catename : $("#up-actcatename").val(),
					content : $("#up-actcontent").val(),
					total : $("#up-acttotal").val(),
					memo : $("#up-actmemo").val(),
					accountid : $("#up-actid").val(),
					userid : userid
				},
				success : function(x) {
					if(x == "success") {
						window.location.reload();
					} else {
						alert("다시 시도해주세요.");
					}
				}
			})
		})
		// 수입/지출 삭제
		$("#del-account-btn").click(function() {
			var op = confirm("내역을 삭제하시겠습니까?")
			if(op) {
				$.ajax({
					type : "post",
					url : "deleteAccount",
					data : {
						accountid : $("#up-actid").val(),
						userid : userid
					},
					success : function(x) {
						if(x == "success") {
							window.location.reload();
						} else {
							alert("다시 시도해주세요.");
						}
					}
				})
			}
		})
		// 금액에 숫자만 입력되도록
		$("#up-acttotal, #add-acttotal").keyup(function() {
			var numReg = /[^0-9]/g;	// 숫자가 아닌 값 정규식
			$(this).val($(this).val().replace(numReg, ""));
		})
		/* ---------------------------- 카테고리 ---------------------------- */
		// 전체 카테고리 목록 가져오기
		$.ajax({
			type : "post",
			url : "categoryInfo",
			data : {
				userid : userid
			},
			success : function(cateList) {
				var in_html = "<table class='modal-table' id='in-category-table' style='width: 100%;'>";

				for(let i = 0; i < cateList.length; i++) {
					if(cateList[i].moneytype == "수입") {
						in_html += "<tr><td style='display: none;'>" + cateList[i].moneytype + "</td>";
						in_html += "<td class='group-list is-border'>" + cateList[i].catename + "</td></tr>";
					}
				}
				in_html += "</table>";

				var out_html = "<table class='modal-table' id='out-category-table' style='width: 100%;'>";
				for(let i = 0; i < cateList.length; i++) {
					if(cateList[i].moneytype == "지출") {
						out_html += "<tr><td style='display: none;'>" + cateList[i].moneytype + "</td>";
						out_html += "<td class='group-list is-border'>" + cateList[i].catename + "</td></tr>";
					}
				}
				out_html += "</table>";
				
				$("#in-category-list-div").html(in_html);
				$("#out-category-list-div").html(out_html);
				$("#select-incate-list-div").html(in_html);
				$("#select-outcate-list-div").html(out_html);
			}
		})
		// 수입 카테고리 모달 열기
		$("#in-category-btn").click(function() {
			$("#in-category-modal").show();
		})
		// 수입 카테고리 모달 닫기
		$("#close-in-category").click(function() {
			$("#in-category-modal").hide();
		})
		// 지출 카테고리 모달 열기
		$("#out-category-btn").click(function() {
			$("#out-category-modal").show();
		})	
		// 지출 카테고리 모달 닫기
		$("#close-out-category").click(function() {
			$("#out-category-modal").hide();
		})
		// 카테고리 추가 모달 열기
		$("#add-in-category-page").click(function() { // 수입 추가
			$("#add-category-modal").show();
			$("#moneytype").attr("value", "수입");
		})	
		$("#add-out-category-page").click(function() { // 지출 추가
			$("#add-category-modal").show();
			$("#moneytype").attr("value", "지출");
		})
		
		var cateReg = RegExp(/^[a-zA-Z가-힣0-9\s]{1,10}$/); // 카테고리 이름 정규식
		
		$("#add-category-btn").click(function() { // 카테고리 추가 버튼 클릭 시
			if(!cateReg.test($("#catename").val())){ // 정규식에 맞지 않을 때
				$("#add-catename-check-div p").attr("class", "msg warning");
			} else {
				$("#add-catename-check-div p").attr("class", "msg info");
				$.ajax({	// 카테고리가 중복되는지 확인
					type : "post",
					url : "isOverlapCate",
					data : {
						moneytype : $("#moneytype").val(),
						catename : $("catename").val(),
						userid : userid
					},
					success : function(x) {
						if(x == "possible") { // 카테고리가 중복되지 않는 경우
							$.ajax({
								type : "post",
								url : "insertCategory",
								data : {
									moneytype : $("#moneytype").val(),
									catename : $("#catename").val(),
									userid : userid
								},
								success : function(x) {
									if(x == "success") { // 카테고리 추가 성공
										window.location.reload();
									} else { // 카테고리 추가 실패
										alert("다시 시도해주세요");
									}
								}
							})
						} else { // 카테고리가 중복되는 경우
							alert("중복되는 카테고리입니다.");
						}
					}
				})
			}
		})
		// 카테고리 추가 모달 닫기
		$("#close-add-category").click(function() {
			$("#add-category-modal").hide();
		})
		
		// 카테고리 수정 모달 열기
		var originCate;
		var originName;
		
		$(document).on("click", "#in-category-list-div #in-category-table tr", function() {
			originCate = $(this).children().eq(0).text();
			originName = $(this).children().eq(1).text();
			$("#up-moneytype").attr("value", originCate); // 수정 모달 input에 현재 분류 값 삽입
			$("#up-catename").attr("value", originName); // 수정 모달 input에 현재 이름 값 삽입
			
			$("#up-category-modal").show(); // 모달 열기
		})
		$(document).on("click", "#out-category-list-div #out-category-table tr", function() {
			originCate = $(this).children().eq(0).text();
			originName = $(this).children().eq(1).text();
			$("#up-moneytype").attr("value", originCate); // 수정 모달 input에 현재 분류 값 삽입
			$("#up-catename").attr("value", originName); // 수정 모달 input에 현재 이름 값 삽입
			
			$("#up-category-modal").show(); // 모달 열기
		})
		
		$("#up-category-btn").click(function() { // 수정 버튼 클릭
			if(!cateReg.test($("#up-catename").val())){ // 정규식에 맞지 않을 때
				$("#up-catename-check-div p").attr("class", "msg warning");
			} else {
				$("#up-catename-check-div p").attr("class", "msg info");
				$.ajax({	// 카테고리가 중복되는지 확인
					type : "post",
					url : "isOverlapCate",
					data : {
						moneytype : $("#up-moneytype").val(),
						catename : $("#up-catename").val(),
						userid : userid
					},
					success : function(x) {
						if(x == "possible") { // 카테고리가 중복되지 않는 경우
							$.ajax({
								type : "post",
								url : "updateCategory",
								data : {
									originType : originCate,
									originName : originName,
									updateType : $("#up-moneytype").val(),
									updateName : $("#up-catename").val(),
									userid : userid
								},
								success : function(x) {
									if(x == "success") {
										window.location.reload();
									} else {
										alert("다시 시도해주세요");
									}
								}
							})
						} else { // 카테고리가 중복되는 경우
							alert("중복되는 카테고리입니다.");
						}
					}
				})
			}
		})
		$("#del-category-btn").click(function() {
			// 삭제 버튼 클릭
			var op = confirm($("#up-catename").val() + " 카테고리를 삭제하시겠습니까?");
			if(op) {
				$.ajax({
					type : "post",
					url : "deleteCategory",
					data : {
						moneytype : $("#up-moneytype").val(),
						catename : $("#up-catename").val(),
						userid : userid
					},
					success : function(x) {
						if(x == "success") {
							window.location.reload();
						} else {
							alert("다시 시도해주세요");
						}
					}
				})
			}
		})
		// 카테고리 수정 모달 닫기
		$("#close-up-category").click(function() {
			$("#up-category-modal").hide();
		})
		
		// 수입/지출 선택 모달
		$("#moneytype, #up-moneytype").click(function() {
			$("#select-moneytype-modal").show();
			$("#in").click(function() {
				$("#moneytype").attr("value", "수입");
				$("#up-moneytype").attr("value", "수입");
				$("#select-moneytype-modal").hide();
			})
			$("#out").click(function() {
				$("#moneytype").attr("value", "지출");
				$("#up-moneytype").attr("value", "지출");
				$("#select-moneytype-modal").hide();
			})
		})
		// 수입/지출 선택 모달 닫기
		$("#close-select-moneytype").click(function() {
			$("#select-moneytype-modal").hide();
		})
		
		/* ---------------------------- 수입/지출 추가 ---------------------------- */
		// 수입/지출 추가 모달 열기
		$("#add-account-page").click(function() {
			// 자산, 카테고리 값 다 비우고 추가 (수입/지출내역 수정할 때 자산, 카테고리 선택하면 같이 변경되므로)
			$("#add-actasset").attr("value", "");
			$("#add-actcatename").attr("value", "");
			$("#add-actcontent").attr("value", "");
			$("#add-acttotal").attr("value", "");

			$("#add-account-modal").show();
		})
		// 수입/지출 추가 모달 닫기
		$("#close-add-account").click(function() {
			$("#add-account-modal").hide();
		})
		// 수입/지출 추가 - 카테고리 선택
		$("#add-actcatename").click(function() {
			var mtype = $("input[name=select-mtype]:checked").val(); // 선택된 값 변수에 저장
			if(mtype == "수입") {
				// 수입 카테고리 리스트 모달
				$("#select-incate-modal").show();
			} else {
				// 지출 카테고리 리스트 모달
				$("#select-outcate-modal").show();
			}
		})
		$(document).on("click", "#select-incate-list-div #in-category-table tr", function() {
			originName = $(this).children().eq(1).text();
			$("#add-actcatename").attr("value", originName); // 수정 모달 input에 현재 이름 값 삽입
			$("#select-incate-modal").hide();
		})
		$(document).on("click", "#select-outcate-list-div #out-category-table tr", function() {
			originName = $(this).children().eq(1).text();
			$("#add-actcatename").attr("value", originName); // 수정 모달 input에 현재 이름 값 삽입
			$("#select-outcate-modal").hide();
		})
		// 카테고리 선택 모달 닫기
		$("#close-select-incate").click(function() {
			$("#select-incate-modal").hide();
		})
		$("#close-select-outcate").click(function() {
			$("#select-outcate-modal").hide();
		})
		// 자산 목록가져오기
		$.ajax({
			type : "post",
			url : "../asset/assetInfo",
			dataType : "json",
			data : {
				userid : userid
			},
			success : function(map) {
				var html = "<table class='modal-table' id='asset-table'>"; // 자산 목록 테이블 만들기
				for(var key in map ) {
					var value = map[key].split(","); // 자산 그룹에 해당하는 자산이 여러 개이면 ,로 구분되어 있으므로 ,를 기준으로 분리하여 value 변수에 저장
					for(var i = 0; i < value.length; i++) {
						var asset = value[i].split("#"); // 자산이름과 자산메모는 #로 구분되어 있으므로 #를 기준으로 분리하여 asset 변수에 저장
							html += "<tr class='asset-name'><td class='group-list is-border'>" + asset[0] + "</td></tr>"; // asset[0]은 자산 이름
					}
				}
				html += "</table>";
				$("#asset-list-div").html(html);
			}
		})
		// 수입/지출 추가 - 자산 선택
		$("#add-actasset").click(function() {
			$("#select-asset-modal").show();
		})
		$("#close-select-asset").click(function() {
			$("#select-asset-modal").hide();
		})
		$(document).on("click", "#asset-table tr", function() {
			var assetName = $(this).text();
			$("#add-actasset").attr("value", assetName);
			$("#select-asset-modal").hide();
		})
		// 수입/지출 추가 버튼
		$("#add-account-btn").click(function() {
			var mtype = $("input[name=select-mtype]:checked").val();
			$.ajax({
				type : "post",
				url : "insertAccount",
				data : {
					date : $("#add-actdate").val(),
					moneytype : mtype,
					astname : $("#add-actasset").val(),
					catename : $("#add-actcatename").val(),
					total : $("#add-acttotal").val(),
					content : $("#add-actcontent").val(),
					memo : $("#add-actmemo").val(),
					userid : userid
				},
				success : function(x) {
					if(x == "success") {
						window.location.reload();
					} else {
						alert("다시 시도해주세요.")
					}
				}
			})
		})
		/* ---------------------------- 즐겨찾기 ---------------------------- */
		// 즐겨찾기 모달 열기
		$("#bookmark-page").click(function() {
			$("#bookmark-modal").show();
		})
		// 즐겨찾기 모달 닫기
		$("#close-bookmark").click(function() {
			$("#bookmark-modal").hide();
		})
		// 즐겨찾기 추가 모달 열기
		$("#add-bookmark-page").click(function() {
			$("#add-bookmark-modal").show();
		})
		$("#close-add-bookmark").click(function() {
			$("#add-bookmark-modal").hide();
		})
		$.ajax({
			type : "post",
			url : "addBookmarkInfo",
			data : {
				userid : userid
			},
			success : function(addmarkList) {
				var addmark_html = "<table class='list-table' style='width:450px;'>";
				for(var i = 0; i < addmarkList.length; i++) {
					addmark_html += "<tr class='tr-addmark'><td>" + addmarkList[i].catename + "</td>";
					addmark_html += "<td>" + addmarkList[i].content + "</td>";
					addmark_html += "<td class='text-right red'>" + addmarkList[i].total + "원</td></tr>";
				}
				addmark_html += "</table>";
				$("#add-bookmark-list-div").html(addmark_html);
			}
		})
		// 수입/지출 내역 tr 클릭 시 즐겨찾기에 추가되도록
		$(document).on("click", ".tr-addmark", function() {
			var catename = $(this).children().eq(0).text();
			var content = $(this).children().eq(1).text();
			var total = $(this).children().eq(2).text().split("원")[0];
			
			// 즐겨찾기 추가
			$.ajax({
				type : "post",
				url : "insertBookmark",
				data : {
					catename : catename,
					content : content,
					total : total,
					userid : userid
				},
				success : function(x) {
					if(x == "success") {
						window.location.reload();
					} else {
						alert("즐겨찾기 추가에 실패하였습니다.")
					}
				}
			})
		})
		// 즐겨찾기 리스트
		$.ajax({
			type : "post",
			url : "bookmarkInfo",
			data : {
				userid : userid
			},
			success : function(bookmarkList) {
				mark_html = "<table class='list-table' style='width:450px;'>";
				for(var i = 0; i < bookmarkList.length; i++) {
					mark_html += "<tr><td class='td-bookmark' style='display:none;'>" + bookmarkList[i].bookmarkid + "</td>";
					mark_html += "<td class='td-bookmark'>" + bookmarkList[i].catename + "</td>";
					mark_html += "<td class='td-bookmark'>" + bookmarkList[i].content + "</td>";
					mark_html += "<td class='td-bookmark text-right red'>" + bookmarkList[i].total + "원</td>";
					mark_html += "<td class='td-delmark'><i class='fi fi-sr-minus-circle del-icon'></i></td></tr>";
				}
				
				$("#bookmark-list-div").html(mark_html);
			}
		})
		// tr 클릭 시
		$(document).on("click", ".td-bookmark", function() {
			var catename = $(this).parent().children().eq(1).text();
			var content = $(this).parent().children().eq(2).text();
			var total = $(this).parent().children().eq(3).text().split("원")[0];
			
			$("#bookmark-modal").hide();
			$("#add-account-modal").show();
			
			$("#add-actcatename").attr("value", catename);
			$("#add-actcontent").attr("value", content);
			$("#add-acttotal").attr("value", total);
		})
		// 삭제 클릭 시
		$(document).on("click", ".td-delmark", function() {
			var bookmarkid = $(this).parent().children().eq(0).text();
			var op = confirm("즐겨찾기를 삭제하시겠습니까?");
			if(op) {
				$.ajax({
					type : "post",
					url : "deleteBookmark",
					data : {
						bookmarkid : bookmarkid,
						userid : userid
					},
					success : function(x) {
						if(x == "success") {
							window.location.reload();
						} else {
							alert("다시 시도해주세요.");
						}
					}
				})
			}
		})
		var clickNum = 0;
		$("#open-cate-setting").click(function() {
			clickNum++;
			if(clickNum % 2 != 0) {
				$("#cate-setting").show();
			} else {
				$("#cate-setting").hide();
			}
		})
	})
</script>
</head>
<body>
	<div>
		<!-- 사이드바 -->
		<div class="col-2 is-border is-shadow">
			<jsp:include page="../main/sidebar.jsp"></jsp:include>
			<img src="../resources/img/logo.png" style="width: 90%;" onclick="location.href='../main/main.jsp'">
			<ul class="menu-group">
				<li class="menu"><i class="fi fi-rr-home"></i> 메인페이지</li>
				<li class="menu active"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 관리</li>		
				<li class="menu"><i class="fi fi-rr-coins"></i> 자산관리</li>		
				<li class="menu"><i class="fi fi-rs-calendar-check"></i> 캘린더</li>		
				<li class="menu"><i class="fi fi-rs-chart-histogram"></i> 목표 관리</li>
			</ul>
		</div>

		<!-- 컨텐츠 -->
		<div class="col-8">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
			<div>
				<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 관리</h3>
				<div class="fix-col5-left-br">
					<button class="btn medium green font-18 is-shadow" id="add-account-page"><i class="fi fi-rr-add"></i> 추가</button>
					<button class="btn small outline-green font-18 is-shadow" id="bookmark-page"><i class="fi fi-rr-star"></i> 즐겨찾기</button>
				</div>
				<div class="fix-right-tr-1">
					<button class="btn green font-18 is-shadow" id="open-cate-setting" style="width: 60px;"><i class="fi fi-rr-menu-burger"></i></button>
				</div>
				<div class="fix-right-tr-2" id="cate-setting" hidden>
					<button class="btn small outline-green font-18 is-shadow" id="in-category-btn">수입 분류</button>
					<br>
					<button class="btn small outline-green font-18 is-shadow" id="out-category-btn">지출 분류</button>
				</div>
				
				<!-- 날짜 보여주기 -->
				<div style="margin-left: 37%; margin-bottom: 3%;">
					<table>
						<tr>
							<td>
								<i class="fi fi-rr-angle-circle-left fs-28 click-icon" id="before"></i>
							</td>
							<td>
								<div id="month-div" style="width: 100%; margin: 10px;"></div>
							</td>
							<td>
								<i class="fi fi-rr-angle-circle-right fs-28 click-icon" id="after"></i>
							</td>
						</tr>
					</table>
				</div>
				<!-- 월별 수입/지출 내역 -->
				<div>
					<div class="col-5">
						<!-- 전체, 수입, 지출 선택 -->
						<div>
							<table class="select-table">
								<tr>
									<td class="active" id="total-account-btn">전체</td>
									<td class="" id="in-account-btn">수입</td>
									<td class="" id="out-account-btn">지출</td>
								</tr>
							</table>
						</div>
						<br>
						<!-- 총 금액 -->
						<div>
							<table style="width: 500px; margin-left: 6%; text-align: center;">
								<tr>
									<td><div id="total-div">합계</div></td>
									<td><div id="total-income-div">총 수입</div></td>
									<td><div id="total-spend-div">총 지출</div></td>
								</tr>
							</table>
						</div>
						<br>
						<div class="is-scroll" id="month-account-list-div" style="margin-left: 2%;"></div>
					</div>
					<div class="col-5">
						<h4 class="h-normal fs-23">지출 통계</h4> <br>
						<div id="piechart" style="width: 800px; height: 400px;"></div>
						<div id="category-stats-div"></div>
					</div>			
				</div>
				
				<!-- 수입 카테고리 모달 -->
				<div class="modal" id="in-category-modal" hidden="true">
					<div class="modal-content">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 수입 카테고리 관리</h3>
						</div>
						<button class="btn medium green" id="add-in-category-page" style="margin-left: 10px;"><i class="fi fi-rr-add"></i> 추가</button>
						<button class="btn small outline-green" id="reset-incate-btn" style="margin-left: 10px; height: 48px;"><i class="fi fi-rr-rotate-right"></i> 초기화</button>
						<div class="modal-body">
							<div id="in-category-list-div"></div>
						</div>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-in-category">닫기</button>
						</div>
					</div>
				</div>
				<!-- 지출 카테고리 모달 -->
				<div class="modal" id="out-category-modal" hidden="true">
					<div class="modal-content">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 지출 카테고리 관리</h3>
						</div>
						<button class="btn medium green" id="add-out-category-page" style="margin-left: 10px;"><i class="fi fi-rr-add"></i> 추가</button>
						<button class="btn small outline-green" id="reset-outcate-btn" style="margin-left: 10px; height: 48px;"><i class="fi fi-rr-rotate-right"></i> 초기화</button>
						<div class="modal-body">
							<div id="out-category-list-div"></div>
						</div>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-out-category">닫기</button>
						</div>
					</div>
				</div>
				
				<!-- 카테고리 수정 모달 -->
				<div class="modal" id="up-category-modal" hidden="true">
					<div class="modal-content small">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 카테고리 수정</h3>
						</div>
						<hr>
						<div class="modal-body small">
							<h5 class='h-normal fs-20'><i class="fi fi-rr-pencil"></i> 카테고리명</h5>
							<div id="up-in-category-div">
								<table class='table'>
									<tr>
										<th>분류</th>
										<td><input type="text" class="input" id='up-moneytype' readonly></td>
									</tr>
									<tr>
										<th>이름</th>
										<td><input type="text" class="input" id='up-catename'></td>
									</tr>
								</table>
								<div id="up-catename-check-div">
									<p class="msg info">이름은 특수문자 제외, 한 글자 이상 입력</p>
								</div>
								<br>
								<button class="btn medium green" id="up-category-btn">수정</button>
								<button class="btn outline-green" id="del-category-btn" style='height: 48px;'>삭제</button>
							</div>
						</div>
						<hr>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-up-category">닫기</button>
						</div>
					</div>
				</div>
				
				<!-- 카테고리 추가 모달 -->
				<div class="modal" id="add-category-modal" hidden="true">
					<div class="modal-content small">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 카테고리 추가</h3>
						</div>
						<hr>
						<div class="modal-body small">
							<h5 class='h-normal fs-20'><i class="fi fi-rr-pencil"></i> 카테고리명</h5>
							<div id="add-category-div">
								<table class='table'>
									<tr>
										<th>분류</th>
										<td><input type="text" class="input" id='moneytype' readonly></td>
									</tr>
									<tr>
										<th>이름</th>
										<td><input type="text" class="input" id='catename'></td>
									</tr>
								</table>
								<div id="add-catename-check-div">
									<p class="msg info">이름은 특수문자 제외, 한 글자 이상 입력</p>
								</div>
								<br>
								<button class="btn medium green" id="add-category-btn">추가</button>
							</div>
						</div>
						<hr>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-add-category">닫기</button>
						</div>
					</div>
				</div>
				<!-- 수입/지출 선택 모달 -->
				<div class="modal" id="select-moneytype-modal" hidden="true">
					<div class="modal-content small">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 분류</h3>
						</div>
						<hr>
						<div class="modal-body small">
							<div id="select-moneytype-div">
								<table class='table'>
									<tr>
										<td class='group-list is-border' id="in">수입</td>
									</tr>
									<tr>
										<td class='group-list is-border' id="out">지출</td>
									</tr>
								</table>
							</div>
						</div>
						<hr>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-select-moneytype">닫기</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 수입/지출 추가 모달 -->
			<div class="modal" id="add-account-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 추가</h3>
					</div>
					<hr>
					<div class="modal-body">
						<div id="add-account-div">
							<table class='table'>
								<tr>
									<td colspan="2">
										<div class="select">
											<input type="radio" name="select-mtype" id="select-in" value="수입"><label for="select-in">수입</label>
											<input type="radio" name="select-mtype" id="select-out" value="지출" checked><label for="select-out">지출</label>
										</div>
									</td>
								</tr>
								<tr>
									<td>날짜</td>
									<td><input type="date" class="input" id="add-actdate" ></td>
								</tr>
								<tr>
									<td>자산</td>
									<td><input type="text" class="input" id="add-actasset" placeholder="자산선택" readonly></td>
								</tr>
								<tr>
									<td>분류</td>
									<td><input type="text" class="input" id="add-actcatename" placeholder="분류선택" readonly></td>
								</tr>
								<tr>
									<td>금액</td>
									<td><input type="text" class="input" id="add-acttotal"></td>
								</tr>
								<tr>
									<td>내용</td>
									<td><input type="text" class="input" id="add-actcontent"></td>
								</tr>
								<tr>
									<td>메모</td>
									<td>
										<textarea rows="3" class="input" id="add-actmemo"></textarea>
									</td>
								</tr>
							</table>
							<button class="btn medium green" id="add-account-btn">추가</button>
						</div>
					</div>
					<hr>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-add-account">닫기</button>
					</div>
				</div>
			</div>
			<!-- 카테고리별 지출 모달 -->
			<div class="modal" id="catespend-modal" hidden="true">
				<div class="modal-content wide">
					<div class="modal-title">
						<h3 class="h-normal fs-28" id="catename-div"><i class="fi fi-rr-money-check-edit"></i> 카테고리별 지출</h3>
					</div>
					<div class="modal-body wide">
						<div id="catespend-total-div"></div>
						<div id="catespend-list-div"></div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-catespend">닫기</button>
					</div>
				</div>
			</div>
			<!-- 수입/지출 수정 모달 -->
			<div class="modal" id="up-account-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 수정</h3>
					</div>
					<hr>
					<div class="modal-body">
						<div id="up-account-div">
							<table class='table'>
								<tr hidden="true">
									<td>ID</td>
									<td><input type="text" class="input" id="up-actid" ></td>
								</tr>
								<tr>
									<td colspan="2">
										<div class="select">
											<input type="radio" name="up-mtype" id="up-in" value="수입"><label for="up-in">수입</label>
											<input type="radio" name="up-mtype" id="up-out" value="지출"><label for="up-out">지출</label>
										</div>
									</td>
								</tr>
								<tr>
									<td>날짜</td>
									<td><input type="date" class="input" id="up-actdate" ></td>
								</tr>
								<tr>
									<td>자산</td>
									<td><input type="text" class="input" id="up-actasset" readonly></td>
								</tr>
								<tr>
									<td>분류</td>
									<td><input type="text" class="input" id="up-actcatename" readonly></td>
								</tr>
								<tr>
									<td>금액</td>
									<td><input type="text" class="input" id="up-acttotal"></td>
								</tr>
								<tr>
									<td>내용</td>
									<td><input type="text" class="input" id="up-actcontent"></td>
								</tr>
								<tr>
									<td>메모</td>
									<td>
										<textarea rows="3" class="input" id="up-actmemo"></textarea>
									</td>
								</tr>
							</table>
							<button class="btn medium green" id="up-account-btn">수정</button>
							<button class="btn outline-green" style="height: 48px;" id="del-account-btn">삭제</button>
						</div>
					</div>
					<hr>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-up-account">닫기</button>
					</div>
				</div>
			</div>
			<!-- 자산 선택 모달 -->
			<div class="modal" id="select-asset-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산</h3>
					</div>
					<hr>
					<div class="modal-body">
						<div id="asset-list-div">
						</div>
					</div>
					<hr>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-select-asset">닫기</button>
					</div>
				</div>
			</div>
			<!-- 수입 카테고리 선택 모달 -->
			<div class="modal" id="select-incate-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 수입 카테고리</h3>
					</div>
					<div class="modal-body">
						<div id="select-incate-list-div"></div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-select-incate">닫기</button>
					</div>
				</div>
			</div>
			<!-- 지출 카테고리 선택 모달 -->
			<div class="modal" id="select-outcate-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 지출 카테고리</h3>
					</div>
					<div class="modal-body">
						<div id="select-outcate-list-div"></div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-select-outcate">닫기</button>
					</div>
				</div>
			</div>
			<!-- 즐겨찾기 모달 -->
			<div class="modal" id="bookmark-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-star"></i> 즐겨찾기</h3>
					</div>
					<button class="btn medium green" id="add-bookmark-page" style="margin-left: 10px;">추가</button>
					<div class="modal-body">
						<div id="bookmark-list-div">
							
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-bookmark">닫기</button>
					</div>
				</div>
			</div>
			<!-- 즐겨찾기 추가 모달 -->
			<div class="modal" id="add-bookmark-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 즐겨찾기 추가</h3>
					</div>
					<div class="modal-body">
						<div id="add-bookmark-list-div">
							
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-add-bookmark">닫기</button>
					</div>
				</div>
			</div>
			<% }
			/* 로그인이 되어 있지 않을 때 */
			else { %>
				<script>location.href = "../member/login.jsp";</script>
			<% } %>
		</div>
	</div>
</body>
</html>