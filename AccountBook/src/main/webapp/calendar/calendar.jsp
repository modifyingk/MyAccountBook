<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 캘린더</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-solid-rounded/css/uicons-solid-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/calendar/calendar.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
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
				<li class="menu"><i class="fi fi-rr-sign-out-alt"></i> 로그아웃</li>
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
						<tr class="tr-content">
							<td><div class="cal-date-div red"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div blue"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
						</tr>
						<tr class="tr-content">
							<td><div class="cal-date-div red"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div blue"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
						</tr>
						<tr class="tr-content">
							<td><div class="cal-date-div red"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div blue"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
						</tr>
						<tr class="tr-content">
							<td><div class="cal-date-div red"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div blue"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
						</tr>
						<tr class="tr-content">
							<td><div class="cal-date-div red"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
							<td><div class="cal-date-div blue"></div><div class="cal-income-div"></div><div class="cal-spend-div"></div></td>
						</tr>
						<tr class="tr-content">
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
				
				<!-- 해당 날짜의 내역 모달 -->
				<div class="modal" id="date-account-modal" hidden="true">
					<div class="modal-content wide">
						<div class="modal-title">
							<div id="select-date-div">
						</div>
						<hr>
						<div class="modal-body wide">
							<!-- 총 금액 -->
							<div style="margin-bottom: 15px;">
								<table style="text-align: center;">
									<tr>
										<td style="width: 300px;"><div id="total-income-div"></div></td>
										<td style="width: 300px;"><div id="total-spend-div"></div></td>
									</tr>
								</table>
							</div>
							<div id="date-account-list-div"></div>
						</div>
						<hr>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-date-account">닫기</button>
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
	</div>
</body>
</html>