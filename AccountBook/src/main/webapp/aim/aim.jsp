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
		$("#add-year, #add-total").keyup(function() {
			var numReg = /[^0-9]/g;	// 숫자가 아닌 값 정규식
			$(this).val($(this).val().replace(numReg, ""));
		})
		
		$("#add-aim-btn").click(function() {
			// 년월, 카테고리가 중복되는지 확인
			
			var mtype = $("input[name=select-mtype]:checked").val();
			var year = $("#add-year").val();
			var date = $("#add-month").val();
			if(date.length == 1) {
				date = "0" + date;
			}
			var aimdate = year + "-" + date;
			
			$.ajax({
				type : "post",
				url : "insertAim",
				data : {
					moneytype : mtype,
					aimdate : aimdate,
					catename : $("#add-catename").val(),
					total : $("#add-total").val(),
					memo : $("#add-memo").val(),
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
			success : function(aimList) {
				var date = todayAll.split("-");
				var aim_html = "<button id='before'>이전</button>";
				aim_html += "<i class='fs-23'>" + date[0] + "년 " + date[1] + "월</i>";
				aim_html += "<button id='after'>다음</button>";
				aim_html += "<table class='list-table'>";
				
				for(var i = 0; i < aimList.length; i++) {
					aim_html += "<tr><td>" + aimList[i].catename + "</td>";
					aim_html += "<td>" + aimList[i].total / aimList[i].aim_money * 100 + "%</td>";
					aim_html += "<td>" + aimList[i].total + "/" + aimList[i].aim_money + "</td></tr>";
				}
				aim_html += "</table>";
				$("#aim-list-div").html(aim_html);
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
				success : function(aimList) {
					var date = todayAll.split("-");
					var aim_html = "<button id='before'>이전</button>";
					aim_html += "<i class='fs-23'>" + date[0] + "년 " + date[1] + "월</i>";
					aim_html += "<button id='after'>다음</button>";
					aim_html += "<table class='list-table'>";
					
					for(var i = 0; i < aimList.length; i++) {
						aim_html += "<tr><td>" + aimList[i].catename + "</td>";
						aim_html += "<td>" + aimList[i].total / aimList[i].aim_money * 100 + "%</td>";
						aim_html += "<td>" + aimList[i].total + "/" + aimList[i].aim_money + "</td></tr>";
					}
					aim_html += "</table>";
					$("#aim-list-div").html(aim_html);
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
				success : function(aimList) {
					var date = todayAll.split("-");
					var aim_html = "<button id='before'>이전</button>";
					aim_html += "<i class='fs-23'>" + date[0] + "년 " + date[1] + "월</i>";
					aim_html += "<button id='after'>다음</button>";
					aim_html += "<table class='list-table'>";
					
					for(var i = 0; i < aimList.length; i++) {
						aim_html += "<tr><td>" + aimList[i].catename + "</td>";
						aim_html += "<td>" + aimList[i].total / aimList[i].aim_money * 100 + "%</td>";
						aim_html += "<td>" + aimList[i].total + "/" + aimList[i].aim_money + "</td></tr>";
					}
					aim_html += "</table>";
					$("#aim-list-div").html(aim_html);
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
				
				<button class="btn long outline-green" id="add-aim-page">목표 추가</button>
				<div id="aim-date-div"></div>
				<div id="aim-list-div"></div>
				
				
			<!-- 수입/지출 수정 모달 -->
			<div class="modal" id="add-aim-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 목표 추가</h3>
					</div>
					<hr>
					<div class="modal-body">
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
								<tr>
									<td>메모</td>
									<td>
										<textarea rows="3" class="input" id="add-memo"></textarea>
									</td>
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