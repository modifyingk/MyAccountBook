<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 자산 관리</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-solid-rounded/css/uicons-solid-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function() {
		var userid = "<%= session.getAttribute("userid") %>";
		
		var date = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		var day = ["일", "월", "화", "수", "목", "금", "토"];

		// 현재 날짜
		var today = new Date();
		var todayYear = today.getFullYear();
		var todayMonth = today.getMonth() + 1 + "";
		
		if(todayMonth.length == 1) {
			todayMonth = "0" + todayMonth;
		}
		var todayAll = todayYear + "-" + todayMonth;
		
		// 연도와 월 보여주기
		var month_html = "<i class='h-normal fs-28'>" + todayYear + "년 " + todayMonth + "월" + "</i>";
		$("#month-div").html(month_html);
		
		// 평년 윤년 계산
		if(((todayYear % 4 == 0) && (todayYear % 100 != 0)) || todayYear % 400 == 0) {
			date[1] = 29;
		} else {
			date[1] = 28;
		}
		// 현재까지의 전체 날 수
		var lastYear = todayYear - 1;
		var totalDate = lastYear * 365 + lastYear / 4 - lastYear / 100 + lastYear / 400;
		for(var i = 0; i < parseInt(todayMonth) - 1; i++) {
			totalDate += date[i];
		}
		// 달력에 날짜 넣기
		var idx = parseInt(totalDate % 7); // 요일 index
		var j = 1;
		for(var i = 1; i <= date[parseInt(todayMonth) - 1]; i++) {
			if(idx + 1 > 6) {
				j++;
				idx = -1;
			}
			$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).html(i);
			
			if($("#month-div").text() + "-" + $(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).text() == todayAll + "-" + today.getDate()) {
				$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).addClass("active");
			} else {
				$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).removeClass("active");
			}
			idx++;
		}
		
		// 날짜별 수입/지출 내역
		$.ajax({
			type : "post",
			url : "../account/calendarTotal",
			data : {
				date : todayAll,
				userid : userid
			},
			success : function(list) {
				for(var i = 1; i < 7; i++) {
					for(var j = 0; j < 7; j++) {
						var calNum = $(".calendar-table").children().children().eq(i).children().eq(j).children().eq(0).text();
						for(var k = 0; k < list.length; k++) {
							var dateNum = list[k].date.split("-")[2];
							if(dateNum.charAt(0) == "0") {
								dateNum = dateNum.replace("0", "");
							}
							if(dateNum == calNum) {
								if(list[k].moneytype == "수입") {
									$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(1).html("<i class='h-normal blue'>" + (list[k].total).toLocaleString() + "</i>");
								} else {
									$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(2).html("<i class='h-normal red'>" + (list[k].total).toLocaleString() + "</i>");
								}
							}
						}
					}
				}
			}
		})
		
		// 이전 달
		$("#before").click(function() {
			// 오늘 날짜
			var today = new Date();
			var originYear = today.getFullYear();
			var originMonth = today.getMonth() + 1 + "";
			var originDate = today.getDate();
			if(originMonth.length == 1) {
				originMonth = "0" + originMonth;
			}
			var originAll = originYear + "-" + originMonth + "-" + originDate;
			
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
			todayYear = beforeYear;
			todayMonth = beforeMonth;
			todayAll = beforeAll;
			
			// 연도와 월 보여주기
			var month_html = "<i class='h-normal fs-28'>" + todayYear + "년 " + todayMonth + "월" + "</i>";
			$("#month-div").html(month_html);
			
			// 평년 윤년 계산
			if(((todayYear % 4 == 0) && (todayYear % 100 != 0)) || todayYear % 400 == 0) {
				date[1] = 29;
			} else {
				date[1] = 28;
			}
			
			// 현재까지의 전체 날 수
			var lastYear = todayYear - 1;
			var totalDate = lastYear * 365 + lastYear / 4 - lastYear / 100 + lastYear / 400;
			for(var i = 0; i < parseInt(todayMonth) - 1; i++) {
				totalDate += date[i];
			}
			
			// 달력 내용 다 지우기
			for(var i = 1; i < 7; i++) {
				for(var j = 0; j < 7; j++) {
					$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(0).html("");
					$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(1).html("");
					$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(2).html("");
				}
			}
			
			// 달력에 날짜 넣기
			var idx = parseInt(totalDate) % 7; // 요일 index
			var j = 1;
			for(var i = 1; i <= date[parseInt(todayMonth) - 1]; i++) {
				if(idx + 1 > 6) {
					j++;
					idx = -1;
				}
				$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).html(i);
				
				if($("#month-div").text() + "-" + $(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).text() == originAll) {
					$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).addClass("active");
				} else {
					$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).removeClass("active");
				}
				idx++;
			}
			
			// 날짜별 수입/지출 내역
			$.ajax({
				type : "post",
				url : "../account/calendarTotal",
				data : {
					date : todayAll,
					userid : userid
				},
				success : function(list) {
					for(var i = 1; i < 7; i++) {
						for(var j = 0; j < 7; j++) {
							var calNum = $(".calendar-table").children().children().eq(i).children().eq(j).children().eq(0).text();
							for(var k = 0; k < list.length; k++) {
								var dateNum = list[k].date.split("-")[2];
								if(dateNum.charAt(0) == "0") {
									dateNum = dateNum.replace("0", "");
								}
								if(dateNum == calNum) {
									if(list[k].moneytype == "수입") {
										$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(1).html("<i class='h-normal blue'>" + (list[k].total).toLocaleString() + "</i>");
									} else {
										$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(2).html("<i class='h-normal red'>" + (list[k].total).toLocaleString() + "</i>");
									}
								}
							}
						}
					}
				}
			})
		})
		// 다음 달
		$("#after").click(function() {
			var today = new Date();
			var originYear = today.getFullYear();
			var originMonth = today.getMonth() + 1 + "";
			var originDate = today.getDate();
			if(originMonth.length == 1) {
				originMonth = "0" + originMonth;
			}
			var originAll = originYear + "-" + originMonth + "-" + originDate;
			
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
			todayYear = afterYear;
			todayMonth = afterMonth;
			todayAll = afterAll;
			
			// 연도와 월 보여주기
			var month_html = "<i class='h-normal fs-28'>" + todayYear + "년 " + todayMonth + "월" + "</i>";
			$("#month-div").html(month_html);
			
			// 평년 윤년 계산
			if(((todayYear % 4 == 0) && (todayYear % 100 != 0)) || todayYear % 400 == 0) {
				date[1] = 29;
			} else {
				date[1] = 28;
			}
			
			// 현재까지의 전체 날 수
			var lastYear = todayYear - 1;
			var totalDate = lastYear * 365 + lastYear / 4 - lastYear / 100 + lastYear / 400;
			for(var i = 0; i < parseInt(todayMonth) - 1; i++) {
				totalDate += date[i];
			}
			
			// 달력 내용 다 지우기
			for(var i = 1; i < 7; i++) {
				for(var j = 0; j < 7; j++) {
					$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(0).html("");
					$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(1).html("");
					$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(2).html("");
				}
			}
			
			// 달력에 날짜 넣기
			var idx = parseInt(totalDate) % 7; // 요일 index
			var j = 1;
			for(var i = 1; i <= date[parseInt(todayMonth) - 1]; i++) {
				if(idx + 1 > 6) {
					j++;
					idx = -1;
				}
				$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).html(i);
				
				if($("#month-div").text() + "-" + $(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).text() == originAll) {
					$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).addClass("active");
				} else {
					$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).removeClass("active");
				}
				idx++;
			}
			
			// 날짜별 수입/지출 내역
			$.ajax({
				type : "post",
				url : "../account/calendarTotal",
				data : {
					date : todayAll,
					userid : userid
				},
				success : function(list) {
					for(var i = 1; i < 7; i++) {
						for(var j = 0; j < 7; j++) {
							var calNum = $(".calendar-table").children().children().eq(i).children().eq(j).children().eq(0).text();
							for(var k = 0; k < list.length; k++) {
								var dateNum = list[k].date.split("-")[2];
								if(dateNum.charAt(0) == "0") {
									dateNum = dateNum.replace("0", "");
								}
								if(dateNum == calNum) {
									if(list[k].moneytype == "수입") {
										$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(1).html("<i class='h-normal blue'>" + (list[k].total).toLocaleString() + "</i>");
									} else {
										$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(2).html("<i class='h-normal red'>" + (list[k].total).toLocaleString() + "</i>");
									}
								}
							}
						}
					}
				}
			})
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
				<li class="menu"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 관리</li>		
				<li class="menu"><i class="fi fi-rr-coins"></i> 자산관리</li>		
				<li class="menu active"><i class="fi fi-rs-calendar-check"></i> 캘린더</li>		
				<li class="menu"><i class="fi fi-rs-chart-histogram"></i> 목표 관리</li>
			</ul>
		</div>

		<!-- 컨텐츠 -->
		<div class="col-8">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<h3 class="h-normal fs-28"><i class="fi fi-rs-calendar-check"></i> 캘린더</h3>
				
				<!-- 날짜 -->
				<div style="margin-left: 37%; margin-bottom: 2%;">
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
				
				<!-- 달력 -->
				<div>
					<table class="calendar-table">
						<tr style="height: 50px;">
							<td><div class="red">일</div></td>
							<td><div>월</div></td>
							<td><div>화</div></td>
							<td><div>수</div></td>
							<td><div>목</div></td>
							<td><div>금</div></td>
							<td><div class="blue">토</div></td>
						</tr>
						<tr>
							<td><div class="cal-date-div red"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div blue"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
						</tr>
						<tr>
							<td><div class="cal-date-div red"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div blue"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
						</tr>
						<tr>
							<td><div class="cal-date-div red"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div blue"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
						</tr>
						<tr>
							<td><div class="cal-date-div red"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div blue"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
						</tr>
						<tr>
							<td><div class="cal-date-div red"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div blue"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
						</tr>
						<tr>
							<td><div class="cal-date-div red"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div blue"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
						</tr>
					</table>
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