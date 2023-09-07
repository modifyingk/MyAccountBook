<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-thin-straight/css/uicons-thin-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function() {
		var userid = "<%= session.getAttribute("userid") %>";
		
		$("#add-aim-page").click(function() {
			$("#add-aim-modal").show();
		})
		$("#close-add-aim").click(function() {
			$("#add-aim-modal").hide();
		})
		// 숫자만 입력되도록
		$("#add-year").keyup(function() {
			var numReg = /[^0-9]/g;	// 숫자가 아닌 값 정규식
			$(this).val($(this).val().replace(numReg, ""));
		})
		// 금액에 숫자만 입력되도록, 세 자리마다 콤마
		$("#up-out-total, #add-total").keyup(function() {
			var numReg = /[^0-9]/g;	// 숫자가 아닌 값 정규식
			$(this).val($(this).val().replace(numReg, ""));
			if($(this).val().length > 0) {
				$(this).val(parseInt($(this).val()).toLocaleString());
			}
		})
		// 목표 추가
		$("#add-aim-btn").click(function() {
			var mtype = $("input[name=select-mtype]:checked").val();
			var year = $("#add-year").val();
			var date = $("#add-month").val();
			if(date.length == 1) {
				date = "0" + date;
			}
			var aimdate = year + "-" + date;
			
			// 년월, 카테고리가 중복되는지 확인
			$.ajax({
				type : "post",
				url : "isOverlapAim",
				data : {
					aimdate : aimdate,
					catename : $("#add-catename").val(),
					userid : userid
				},
				success : function(x) {
					if(x == "possible") {
						$.ajax({
							type : "post",
							url : "insertAim",
							data : {
								moneytype : mtype,
								aimdate : aimdate,
								catename : $("#add-catename").val(),
								total : ($("#add-total").val()).replaceAll(",", ""),
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
					} else {
						alert("이미 존재하는 카테고리 목표입니다.");
					}
				}
			})
		})
		
		// 전체 카테고리 목록 가져오기
		$.ajax({
			type : "post",
			url : "../account/categoryInfo",
			data : {
				userid : userid
			},
			success : function(cateList) {
				var in_html = "<table class='table' id='in-category-table'>";

				for(let i = 0; i < cateList.length; i++) {
					if(cateList[i].moneytype == "수입") {
						in_html += "<tr><td style='display: none;'>" + cateList[i].moneytype + "</td>";
						in_html += "<td class='group-list is-border'>" + cateList[i].catename + "</td></tr>";
					}
				}
				in_html += "</table>";

				var out_html = "<table class='table' id='out-category-table'>";
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
		$(document).on("click", "#in-category-table tr", function() {
			var catename = $(this).children().eq(1).text();
			$("#add-catename").attr("value", catename);
			$("#select-incate-modal").hide();
		})
		$(document).on("click", "#out-category-table tr", function() {
			var catename = $(this).children().eq(1).text();
			$("#add-catename").attr("value", catename);
			$("#select-outcate-modal").hide();
		})
		
		// 카테고리 선택
		$("#add-catename").click(function() {
			var mtype = $("input[name=select-mtype]:checked").val(); // 선택된 값 변수에 저장
			if(mtype == "수입") {
				// 수입 카테고리 리스트 모달
				$("#select-incate-modal").show();
			} else {
				// 지출 카테고리 리스트 모달
				$("#select-outcate-modal").show();
			}
		})
		// 카테고리 선택 모달 닫기
		$("#close-select-incate").click(function() {
			$("#select-incate-modal").hide();
		})
		$("#close-select-outcate").click(function() {
			$("#select-outcate-modal").hide();
		})
		
		var today = new Date();
		var todayYear = today.getFullYear();
		var todayMonth = today.getMonth() + 1 + "";
		
		if(todayMonth.length == 1) {
			todayMonth = "0" + todayMonth;
		}
		var todayAll = todayYear + "-" + todayMonth;

		// 지출 목표 가져오기
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
				$("#aim-month-div").html(month_html);
				$("#aim-list-div").html(aim_html);
			}
		})
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
				
				$("#aim-in-list-div").html(aim_in_html);
			}
		})
		
		$(document).on("click", "#before", function() {
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
					
					$("#aim-month-div").html(month_html);
					$("#aim-list-div").html(aim_html);
				}
			})
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
					
					$("#aim-in-list-div").html(aim_in_html);
				}
			})
		})
		
		$(document).on("click", "#after", function() {
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
					
					$("#aim-month-div").html(month_html);
					$("#aim-list-div").html(aim_html);
				}
			})
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
					
					$("#aim-in-list-div").html(aim_in_html);
				}
			})
		})
		$(document).on("click", "#out-aim-table tr", function() {
			$("#up-out-aimid").attr("value", $(this).children().eq(0).text());
			$("#up-out-catename").attr("value", $(this).children().eq(1).text());
			$("#up-out-total").attr("value", $(this).children().eq(3).text().split("원 / ")[1].split("원")[0]);
			$("#up-out-aim-modal").show();
		})
		$(document).on("click", "#in-aim-table tr", function() {
			$("#up-out-aimid").attr("value", $(this).children().eq(0).text());
			$("#up-out-catename").attr("value", $(this).children().eq(1).text());
			$("#up-out-total").attr("value", $(this).children().eq(3).text().split("원 / ")[1].split("원")[0]);
			$("#up-out-aim-modal").show();
		})
		$("#close-up-out-aim").click(function() {
			$("#up-out-aim-modal").hide();
		})
		
		$("#up-out-aim-btn").click(function() {
			$.ajax({
				type : "post",
				url : "updateAim",
				data : {
					aimid : $("#up-out-aimid").val(),
					total : ($("#up-out-total").val()).replaceAll(",", ""),
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
		$("#del-out-aim-btn").click(function() {
			$.ajax({
				type : "post",
				url : "deleteAim",
				data : {
					aimid : $("#up-out-aimid").val(),
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
		
	})
</script>
</head>
<body>
	<div class="">
		<!-- 사이드바 -->
		<div class="col-2 is-border is-shadow">
			<jsp:include page="../main/sidebar.jsp"></jsp:include>
			<img src="../resources/img/logo.png" style="width: 90%;" onclick="location.href='../main/main.jsp'">
			<ul class="menu-group">
				<li class="menu"><i class="fi fi-rr-home"></i> 메인페이지</li>
				<li class="menu"><i class="fi fi-rr-add"></i> 수입/지출 관리</li>		
				<li class="menu"><i class="fi fi-rr-coins"></i> 자산관리</li>		
				<li class="menu"><i class="fi fi-rs-calendar-check"></i> 캘린더</li>		
				<li class="menu active"><i class="fi fi-rs-chart-histogram"></i> 목표 관리</li>
			</ul>
		</div>
		
		<!-- 컨텐츠 -->
		<div class="col-8">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<h3 class="h-normal fs-28"><i class="fi fi-rs-chart-histogram"></i> 목표 관리</h3>
				<div class="fix-left-br">
					<button class="btn medium green font-18 is-shadow" id="add-aim-page"><i class="fi fi-rr-add"></i> 목표 추가</button>
				</div>
				<!-- 날짜 보여주기 -->
				<div>
					<table>
						<tr>
							<td>
								<i class="fi fi-rr-angle-circle-left fs-28 click-icon" id="before"></i>
							</td>
							<td>
								<div id="aim-month-div" style="width: 100%; margin: 10px;"></div>
							</td>
							<td>
								<i class="fi fi-rr-angle-circle-right fs-28 click-icon" id="after"></i>
							</td>
						</tr>
					</table>
				</div>
				<h4 class='h-normal fs-23'>지출 목표</h4>
				<div class="is-scroll" id="aim-list-div" style="height: 350px;"></div>
				<h4 class='h-normal fs-23'>수입 목표</h4>
				<div class="is-scroll" id="aim-in-list-div" style="height: 350px;"></div>
				
				
			<!-- 목표 추가 모달 -->
			<div class="modal" id="add-aim-modal" hidden="true">
				<div class="modal-content medium">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 목표 추가</h3>
					</div>
					<hr>
					<div class="modal-body medium">
						<div id="">
							<table class="table">
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
									<td>
										<input class="input small" type="text" id="add-year" placeholder="년(4자)" maxlength="4">
										<select class="input small" id="add-month">
											<option>월</option>
											<option value="01">1</option>
											<option value="02">2</option>
											<option value="03">3</option>
											<option value="04">4</option>
											<option value="05">5</option>
											<option value="06">6</option>
											<option value="07">7</option>
											<option value="08">8</option>
											<option value="09">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>분류</td>
									<td><input type="text" class="input" id="add-catename" readonly></td>
								</tr>
								<tr>
									<td>금액</td>
									<td><input type="text" class="input" id="add-total"></td>
								</tr>
							</table>
							<button class="btn medium green" id="add-aim-btn">추가</button>
						</div>
					</div>
					<hr>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-add-aim">닫기</button>
					</div>
				</div>
			</div>
			
			<!-- 목표 지출 수정 모달 -->
			<div class="modal" id="up-out-aim-modal" hidden="true">
				<div class="modal-content medium">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 목표 지출 수정</h3>
					</div>
					<div class="modal-body medium">
						<div id="">
							<table class="table">
								<tr style="display: none;">
									<td colspan="2"><input type="text" class="input" id="up-out-aimid"></td>
								</tr>
								<tr>
									<td>분류</td>
									<td><input type="text" class="input" id="up-out-catename" disabled></td>
								</tr>
								<tr>
									<td>금액</td>
									<td><input type="text" class="input" id="up-out-total"></td>
								</tr>
							</table>
							<button class="btn medium green" id="up-out-aim-btn">수정</button>
							<button class="btn outline-green" id="del-out-aim-btn" style="height: 48px;">삭제</button>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-up-out-aim">닫기</button>
					</div>
				</div>
			</div>
			<!-- 수입 카테고리 선택 모달 -->
			<div class="modal" id="select-incate-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 수입 카테고리</h3>
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
						<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 지출 카테고리</h3>
					</div>
					<div class="modal-body">
						<div id="select-outcate-list-div"></div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-select-outcate">닫기</button>
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