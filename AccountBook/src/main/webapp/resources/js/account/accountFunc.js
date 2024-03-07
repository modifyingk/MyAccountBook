$(function() {
	// 날짜 세팅
	$.setDate = function(year, month) {
		$("#month").html($.removeZero(month) + "월");
		$("#year").html(year);
		$("#month-div").html("<i class='h-normal fs-28'>" + year + "년 " + month + "월</i>")
	}
	
	// 수입/지출 내역
	$.accountList = function(dateVal, useridVal) {
		$.ajax({
			type : "post",
			url : "selectAccount",
			data : {
				date : dateVal,
				userid : useridVal,
			},
			success : function(res) {
				result = res;
				$("#account-list-div").html("");
				$("#account-list-div").append(result);
			}
		})
	}

	// 카테고리별 통계
	$.categoryStatsList = function(dateVal, useridVal, typeVal) {
		var result;
		$.ajax({
			type : "post",
			url : "groupByCategory",
			async : false,
			data : {
				date : dateVal,
				userid : useridVal,
				moneytype : typeVal
			},
			success : function(res) {
				result = res;
			}
		})
		return result;
	}
	
	// 자산별 통계
	$.assetStatsList = function(dateVal, useridVal, typeVal) {
		var result;
		$.ajax({
			type : "post",
			url : "groupByAsset",
			async : false,
			data : {
				date : dateVal,
				userid : useridVal,
				moneytype : typeVal
			},
			success : function(res) {
				result = res;
			}
		})
		return result;
	}
	
	// 통계 html
	$.showStats = function(map) {
		google.charts.load("current", {packages:["corechart"]});
		google.charts.setOnLoadCallback(drawChart);
		var category = Object.keys(map);
		var catedata = new Array(category.length + 1);
		for(var i = 0; i < catedata.length; i++) {
			catedata[i] = Array(2);
		}
		
		catedata[0][0] = "수입/지출";
		catedata[0][1] = "내역";
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
	                chartArea:{left:0,top:0,width:'100%',height:'75%'}
	              };

	        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

	        chart.draw(data, options);
		}
		
		var stats_html = "<table class='list-table'>";
		for(var key in map) {
			stats_html += "<tr class='tr-statsName text-center'><td>" + key + "</td>";
			stats_html += "<td class='td-statsTotal red h-normal text-center'>" + map[key].toLocaleString() + "원</td></tr>";
		}
		stats_html += "</table>";
		$("#stats-list-div").html(stats_html);
	}
	
	// 카테고리별 내역
	$.detailsOfCategory = function(cateVal, typeVal, dateVal, useridVal) {
		var result;
		$.ajax({
			type : "post",
			url : "detailsOfCategory",
			async : false,
			data : {
				catename : cateVal,
				moneytype : typeVal,
				date : dateVal,
				userid : useridVal
			},
			success : function(res) {
				result = res;
			}
		})
		return result;
	}
	
	// 자산별 수입/지출 목록 가져오기
	$.detailsOfAsset = function(assetVal, typeVal, dateVal, useridVal) {
		var result;
		$.ajax({
			type : "post",
			url : "../asset/detailsOfAsset",
			async : false,
			data : {
				date : dateVal,
				moneytype : typeVal,
				assetname : assetVal,
				userid : userid
			},
			success : function(res) {
				result = res;
			}
		})
		return result;
	}
	
	/*
	// 카테고리 선택 및 값 자동 입력
	$.pickCategory = function(categoryID, mtypeName) {
		$(document).on("click", categoryID, function() {
			var mtype = $("input[name=" + mtypeName + "]:checked").val(); // 선택된 값 변수에 저장
			$.showSelectCategory(mtype, ".select-category-list");
			$(".select-category-div").show();
		})
		$(document).on("click", ".select-category-div tr", function() {
			var categoryVal = $(this).children().eq(1).text();
			$(categoryID).attr("value", categoryVal);
			$(".select-category-div").hide();
		})
	}
	*/
	// moneytype radio 값 변경 시 카테고리 값 비우기
	/*$.chgMtype = function(categoryID, mtypeName) {
		$(document).on("click", "input:radio[name='" + mtypeName + "']", function() {
			$(categoryID).attr("value", "");
		})
	}*/
	
	// 수입/지출 현황
	$.info = function() {
		$("#income-total").html($("#income-div i").text())
		$("#spend-total").html($("#spend-div i").text())
	}
	
	/*
	// 수입/지출 내역 html
	$.accountHtml = function(map) {
		if(Object.keys(map).length > 0) {
			for(const [key, valList] of Object.entries(map)){
				console.log(key);
				let income = 0; let spend = 0;
				let html1 = "<table class='account-table'>";
				let html2 = "<tr class='tr-date'><td class='td-date'>" + $.removeZero($.getMonth(key)) + "월 " + $.removeZero($.getDay(key)) + "일 " + $.getDayOfWeek(key) + "</td>";
				let html3 = "";
				for(let i = 0; i < valList.length; i++) {
					html3 += "<tr class='tr-content'><td style='display:none;'>" + key + "</td>";
					html3 += "<td class='hide'>" + valList[i].accountid + "</td>"; // 수입/지출 id
					html3 += "<td class='hide'>" + valList[i].moneytype + "</td>"; // 수입/지출
					html3 += "<td class='td-category'><div class='key-div'>" + valList[i].bigcate + "</div>"; // 대분류
					html3 += "<div style='padding:10px;'>" + valList[i].smallcate + "</div></td>"; // 소분류
					html3 += "<td class='td-content'>" + valList[i].content + "</td>";
					html3 += "<td class='td-asset gray'>" + valList[i].assetname + "</td>";
					if(valList[i].moneytype == "수입") {
						html3 += "<td class='td-income text-right blue'>" + parseInt(valList[i].total).toLocaleString() + "원</td>"; // 돈
						income += parseInt(valList[i].total);
					} else {
						html3 += "<td class='td-spend text-right red'>" + parseInt(valList[i].total).toLocaleString() + "원</td>";
						spend += parseInt(valList[i].total);
					}
				}
				
				html2 += "<td colspan='3'><div class='part-spend'> " + spend + "원</div><div class='part-income'>" + income + "원</div></td></tr>";
				let html = html1 + html2 + html3 + "</table><br><br>";
				$("#account-list-div").prepend(html);

			}
		} else {
			let html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
			$("#account-list-div").append(html);
		}
	}
	*/
	
	/*
	// 카테고리별 수입/지출 내역
	$.cateAccountList = function(cateVal, typeVal, dateVal, useridVal) {
		$.ajax({
			type : "post",
			url : "detailsOfCategory",
			data : {
				catename : cateVal,
				moneytype : typeVal,
				date : dateVal,
				userid : useridVal
			},
			success : function(map) {
				if(Object.keys(map) != "no") {
					var spend_total = 0;
					var account_html = "<table class='list-table'>";
					var total_html;
						
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
								account_html += "<td class='text-right blue'>" + parseInt(account[5]).toLocaleString() + "원</td>";
							} else {
								account_html += "<td class='text-right red'>" + parseInt(account[5]).toLocaleString() + "원</td>";
							}
							spend_total += parseInt(account[5]);
							account_html += "<td style='display:none;'>" + account[6].toLocaleString() + "</td></tr>"; // 메모
						}
						account_html += "<tr style='border : 0;'></tr>";
					}
					account_html += "</table>";
					if(moneytype == "수입") {
						total_html = "<h4 class='h-normal fs-23'>총 수입 <i class='blue h-normal fs-20'>" + spend_total.toLocaleString() + "원</i></h4><br>";
					} else {
						total_html = "<h4 class='h-normal fs-23'>총 지출 <i class='red h-normal fs-20'>" + spend_total.toLocaleString() + "원</i></h4><br>";
					}
						
				} else {
					var account_html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
				}
				$("#cateaccount-total-div").html(total_html);
				$("#catename-div").html("<h3 class='h-normal fs-28'><i class='fi fi-rr-money-check-edit'></i> " + catename + "</h3>");
				$("#cateaccount-list-div").html(account_html);
			}
		})
		$("#catespend-modal").show();
	}
	*//*
	// 연도별 지출 그래프
	$.detailsOfYear = function(typeVal, dateVal, useridVal) {
		$.ajax({
			type : "post",
			url : "detailsOfYear",
			data : {
				moneytype : typeVal,
				date : dateVal,
				userid : useridVal
			},
			success : function(list) {
				var html;
				var month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
				if(list != "") {
					html = "<table><tr>";
					var maxTotal = list[0].total;
					for(var i = 0; i < list.length; i++) {
						if(list[i].total > maxTotal) {
							maxTotal = list[i].total;
						}
					}
					for(var i = 1; i <= 12; i++) {
						html += "<td><div class='graph-bar is-border'>";
						for(var j = 0; j < list.length; j++) {
							if(parseInt(list[j].date.split("-")[1]) == i) {
								html += "<div class='graph' style='height: " + (list[j].total / maxTotal * 100) + "%;'>" + list[j].total.toLocaleString() + "</div></div></td>";
							}
						}
					}
					html += "</tr><tr>";
					for(var i = 0; i < 12; i++) {
						html += "<td class='h-bold fs-18 safe text-center' style='height:60px;'>" + month[i] + "</td>";
					}
					
				} else {
					html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
				}
				
				$("#graph-year").html(dateVal + "년");
				$("#total-graph-div").html(html);
			}
		})
	}
	
	// 검색 내역
	$.searchAccountList = function(content, userid) {
		$.ajax({
			type : "post",
			url : "searchAccount",
			data : {
				content : content,
				userid : userid
			},
			success : function(map) {
				if(Object.keys(map) != "no") {
					var income_total = 0;
					var spend_total = 0;
					var account_html = "<table class='list-table'>";
						
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
								account_html += "<td class='text-right blue'>" + parseInt(account[5]).toLocaleString() + "원</td>";
								income_total += parseInt(account[5]);
							} else {
								account_html += "<td class='text-right red'>" + parseInt(account[5]).toLocaleString() + "원</td>";
								spend_total += parseInt(account[5]);
							}
							account_html += "<td style='display:none;'>" + account[6].toLocaleString() + "</td></tr>"; // 메모
						}
						account_html += "<tr style='border : 0;'></tr>";
					}
					account_html += "</table>";
					
					var total_html = "<h4 class='h-normal fs-18 info'>합계</h4><i class='h-normal fs-20'>" + (income_total - spend_total).toLocaleString() + "</i>";
					var income_html = "<h4 class='h-normal fs-18 info'>총 수입</h4><i class='blue h-normal fs-20'>" + income_total.toLocaleString() + "</i>";
					var spend_html = "<h4 class='h-normal fs-18 info'>총 지출</h4><i class='red h-normal fs-20'>" + spend_total.toLocaleString() + "</i>";
					
				} else {
					var account_html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
					var total_html = "<h4 class='h-normal fs-18 info'>합계</h4><i class='h-normal fs-20'>0</i>";
					var income_html = "<h4 class='h-normal fs-18 info'>총 수입</h4><i class='blue h-normal fs-20'>0</i>";
					var spend_html = "<h4 class='h-normal fs-18 info'>총 지출</h4><i class='red h-normal fs-20'>0</i>";
				}

				$("#search-total-div").html(total_html);
				$("#search-income-div").html(income_html);
				$("#search-spend-div").html(spend_html);
				
				$("#search-list-div").html(account_html);
			}
		})
	}
	*//*
	// moneytype 선택
	$.selectMtype = function(mtype, radioName) {
		if(mtype == "수입") {
			$("input:radio[name='" + radioName + "'][value='지출']").attr("checked", false);
			$("input:radio[name='" + radioName + "'][value='수입']").attr("checked", true);
		} else {
			$("input:radio[name='" + radioName + "'][value='수입']").attr("checked", false);
			$("input:radio[name='" + radioName + "'][value='지출']").attr("checked", true);
		}
	}*/
	/*
	// 전체, 수입만, 지출만 버튼 활성화
	$.activeBtn = function(removeDoc1, removeDoc2, addDoc) {
		if($(removeDoc1).hasClass("active")) {
			$(removeDoc1).removeClass("active");
			$(addDoc).addClass("active");
		} else if($(removeDoc2).hasClass("active")) {
			$(removeDoc2).removeClass("active");
			$(addDoc).addClass("active");
		}
	}*/
	/*
	// 반복 옵션 선택 함수
	// parameter : 매년/매월/매주 선택 값, 매년 div, 매월 div, 매주 div
	$.selectRepeatOption = function(selectID, everyYearDiv, everyMonthDiv, everyWeekDiv) {
		if(selectID == "매년") {
			$(everyMonthDiv).hide();
			$(everyWeekDiv).hide();
			$(everyYearDiv).show();
		} else if(selectID == "매월") {
			$(everyYearDiv).hide();
			$(everyWeekDiv).hide();
			$(everyMonthDiv).show();
		} else if(selectID == "매주") {
			$(everyYearDiv).hide();
			$(everyMonthDiv).hide();
			$(everyWeekDiv).show();
		} else {
			$(everyYearDiv).hide();
			$(everyMonthDiv).hide();
			$(everyWeekDiv).hide();
		}
	}
	
	// 반복 형식 확인
	// parameter : 매년/매월/매주 선택 값, 매년 월, 매년 일, 매월 일, 매주 요일
	$.checkRepeat = function(repeatOption, everyYearMonth, everyYearDate, everyMonth, everyWeek) {
		if($(repeatOption).val() == "매년") {
			if($(everyYearMonth).val() == "월") {
				cycleChk = false;
			} else {
				cycleChk = $.checkDate(everyYearDate, "");
			}
		} else if($(repeatOption).val() == "매월") {
			cycleChk = $.checkDate(everyMonth, "");
		} else if($(repeatOption).val() == "매주") {
			if($(everyWeek).val() == "요일") {
				cycleChk = false;
			} else {
				cycleChk = true;
			}
		} else if($(repeatOption).val() == "매일") {
			cycleChk = true;
		} else {
			cycleChk = false;
		}
	}
	
	// 반복 주기 생성
	// parameter : 매년/매월/매주 선택 값, 매년 월, 매년 일, 매월 일, 매주 요일
	$.makeCycle = function(repeatOption, everyYearMonth, everyYearDate, everyMonth, everyWeek) {
		 var cycle = "";
		 if($(repeatOption).val() == "매년") {
			 if($(everyYearDate).val().length == 1) {
				 cycle = "매년 " + $(everyYearMonth).val() + "/0" + $(everyYearDate).val();
			 } else {
				 cycle = "매년 " + $(everyYearMonth).val() + "/" + $(everyYearDate).val();
			 }
		 } else if($(repeatOption).val() == "매월") {
			 if($(everyMonth).val().length == 1) {
				 cycle = "매월 0" + $(everyMonth).val();
			 } else {
				 cycle = "매월 " + $(everyMonth).val();
			 }
		 } else if($(repeatOption).val() == "매주") {
			 cycle = "매주 " + $(everyWeek).val();
		 } else {
			 cycle = "매일";
		 }
		 return cycle;
	}
	
	// 반복 중복 확인
	$.isOverlapRepeat = function(moneytype, astname, catename, total, content, userid) {
		var result;
		$.ajax({
			type: "post",
			url : "isOverlapRepeat",
			async : false,
			data : {
				moneytype : moneytype,
				astname : astname,
				catename : catename,
				total : total,
				content : content,
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
	
	// 반복 수정
	$.updateRepeat = function(cycle, repeatid, moneytype, astname, catename, total, content, userid) {
		$.ajax({
			type: "post",
			url : "updateRepeat",
			data : {
				repeatcycle : cycle,
				repeatid : repeatid,
				moneytype : moneytype,
				astname : astname,
				catename : catename,
				total : total,
				content : content,
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
	}*/
})