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
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<link rel="stylesheet" type="text/css" href="../resources/css/account/calendar.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/calendar/calendar.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
</script>
</head>
<body>
	<div>
		<jsp:include page="../main/header.jsp"></jsp:include>
		<jsp:include page="../main/sidebar.jsp"></jsp:include>

		<!-- 컨텐츠 -->
		<div class="container calendar">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<h3 class="title-text"><i class="fi fi-rs-calendar-check"></i> 캘린더</h3>
				
				<!-- 날짜 -->
				<div id="div1">
					<table class="date-table">
						<tr>
							<td>
								<i class="fi fi-rr-angle-left angle-icon" id="last-month"></i>
							</td>
							<td>
								<!-- 날짜 -->
								<div id="date-div">
									<div id="month"></div>
									<div id="year"></div>
								</div>
								
								<!-- 날짜 선택 div -->
								<div class="is-border" id="select-date">
									<table>
										<tr>
											<td id="last-year"><i class="fi fi-rr-angle-left"></i></td>
											<td colspan="2">
												<div id="select-year"></div>
											</td>
											<td id="next-year"><i class="fi fi-rr-angle-right"></i></td>
										</tr>
										<tr class="select-month">
											<td>1월</td>
											<td>2월</td>
											<td>3월</td>
											<td>4월</td>
										</tr>
										<tr class="select-month">
											<td>5월</td>
											<td>6월</td>
											<td>7월</td>
											<td>8월</td>
										</tr>
										<tr class="select-month">
											<td>9월</td>
											<td>10월</td>
											<td>11월</td>
											<td>12월</td>
										</tr>
									</table>
								</div>
							</td>
							<td>
								<i class="fi fi-rr-angle-right angle-icon" id="next-month"></i>
							</td>
						</tr>
					</table>
				</div>
				
				<!-- 달력 -->
				<div id="div2"></div>
				
				<!-- 특정 날짜의 수입/지출 내역 -->
				<div class="hide" id="side-div1">
					<h2>상세 내역</h2>
					<button class="x-btn" id="close-side-div1">x</button>
					<div id="account-list-div"></div>
				</div>
				<!-- 달력 
				<div style="margin-left: 5%;">
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
				-->
				<!-- 해당 날짜의 내역 모달
				<div class="modal" id="date-account-modal" hidden="true">
					<div class="modal-content wide">
						<div class="modal-title">
							<div id="select-date-div">
						</div>
						<hr>
						<div class="modal-body wide">
							<!-- 총 금액 
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
				</div> -->
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