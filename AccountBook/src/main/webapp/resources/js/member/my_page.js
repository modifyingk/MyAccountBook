document.write('<script src="../resources/js/cal_date.js"></script>');

$(function () {
	// 월별 합계 그래프
	$.monthAccountTotal = function(moneytype, date, userid) {
		$.ajax({
			type : "post",
			url : "../account/monthTotal",
			data : {
				moneytype : moneytype,
				date : date.split("-")[0],
				userid : userid
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
					
					if(date.split("-")[1] <= 6) {
						for(var i = 1; i <= 6; i++) {
							html += "<td><div class='graph-bar is-border'>";
							for(var j = 0; j < list.length; j++) {
								if(parseInt(list[j].date.split("-")[1]) == i) {
									html += "<div class='graph' style='height: " + (list[j].total / maxTotal * 100) + "%;'>" + list[j].total.toLocaleString() + "</div></div></td>";
								}
							}
						}
						html += "</tr><tr>";
						for(var i = 0; i < 6; i++) {
							html += "<td class='h-bold fs-18 safe text-center' style='height:60px;'>" + month[i] + "</td>";
						}
						html += "</table>";
						
					} else {
						for(var i = 7; i <= 12; i++) {
							html += "<td><div class='graph-bar is-border'>";
							for(var j = 0; j < list.length; j++) {
								if(parseInt(list[j].date.split("-")[1]) == i) {
									html += "<div class='graph' style='height: " + (list[j].total / maxTotal * 100) + "%;'>" + list[j].total.toLocaleString() + "</div></div></td>";
								}
							}
						}
						html += "</tr><tr>";
						for(var i = 6; i < 12; i++) {
							html += "<td class='h-bold fs-18 safe text-center' style='height:60px;'>" + month[i] + "</td>";
						}
						html += "</table>";
					}
				} else {
					html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
				}
				
				$("#graph-year").html(date + "년");
				$("#total-graph-div").html(html);
			}
		})
	}
	
	$(document).ready(function() {
		// 현재 날짜 가져오기
		todayAll = $.currentYM();
		
		// 현재 세션의 포인트 정보 가져오기
		$.ajax({
			type : "post",
			url : "userMoneyInfo",
			data : {
				userid : userid
			},
			success : function(info) {
				$("#point-div").html(info.userpoint);
				if(info.plantstep < 10) {
					$("#plant-step-div").html("<img src='../resources/img/moneyseed.png' id='plant-step' width='200px;'>");
					$("#water-btn").show();
				} else if(info.plantstep < 25) {
					$("#plant-step-div").html("<img src='../resources/img/moneyleaf.png' id='plant-step' width='200px;'>");
					$("#water-btn").show();
				} else if(info.plantstep < 50) {
					$("#plant-step-div").html("<img src='../resources/img/moneyflower.png' id='plant-step' width='200px;'>");
					$("#water-btn").show();
				} else {
					$("#plant-step-div").html("<img src='../resources/img/moneyfruit.png' id='plant-step' class='money' width='200px;' style='left: 35%; cursor:pointer;'>");
					$("#water-btn").hide(); // 물 못 주도록 하기
				}
			}
		})
		
		// 월별 그래프 보여주기
		$.monthAccountTotal("지출", todayAll, userid);
	})
	
	// 아이디 클릭 시 회원 정보 보기
	$(document).on("click", "#myinfo-btn", function() {
		location.href = "../member/myInfo.jsp";
	})
	
	// 물 주기
	$(document).on("click", "#water-btn", function() {
		$.ajax({
			type : "post",
			url : "usePoint",
			data : {
				userid : userid,
			},
			success : function (x) {
				if(x == -1) {
					alert("포인트가 부족합니다!");
				} else {
					// 물 뿌리개 움직이기
					$("#water-btn").animate({rotate : "-45deg"}, 1000);
					$("#water-btn").animate({rotate : "0deg"}, 1000);
					
					// 물 나왔다 사라지기 
					$("#water-img").show(1200);
					$("#water-img").fadeOut(300);
					
					// 현재 세션의 포인트 정보 가져오기
					$.ajax({
						type : "post",
						url : "userMoneyInfo",
						data : {
							userid : userid
						},
						success : function(info) {
							$("#point-div").html(info.userpoint);
							if(info.plantstep < 10) {
								$("#plant-step-div").html("<img src='../resources/img/moneyseed.png' id='plant-step' width='200px;'>");
								$("#water-btn").show();
							} else if(info.plantstep < 25) {
								$("#plant-step-div").html("<img src='../resources/img/moneyleaf.png' id='plant-step' width='200px;'>");
								$("#water-btn").show();
							} else if(info.plantstep < 50) {
								$("#plant-step-div").html("<img src='../resources/img/moneyflower.png' id='plant-step' width='200px;'>");
								$("#water-btn").show();
							} else {
								$("#plant-step-div").html("<img src='../resources/img/moneyfruit.png' id='plant-step' class='money' width='200px;' style='left:35%; cursor:pointer;'>");
								$("#water-btn").hide();
								$("#water-img").hide();
							}
						}
					})
				}
			}
		})
	})
	
	// 랜덤 포인트 발생
	$(document).on("click", ".money", function() {
		// plant-step이 money일 때
		// 랜덤 cash 뽑기 및 plant-step 0으로 설정
		$.ajax({
			type : "post",
			url : "randomCash",
			data : {
				usercash : 0,
				plantstep : 0,
				userid : userid
			},
			success : function(x) {
				if(x > 0) {
					alert(x + "원 획득!");
					window.location.reload();
				} else {
					alert("다시 시도해주세요.");
				}
			}
		})
	})
})