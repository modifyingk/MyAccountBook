<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 통계</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-solid-rounded/css/uicons-solid-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<link rel="stylesheet" type="text/css" href="../resources/css/table.css">
<link rel="stylesheet" type="text/css" href="../resources/css/account.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="../resources/js/account/asset_stats.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
	var today = "<%= request.getParameter("today") %>";
</script>
</head>
<body>
	<div>
		<!-- 사이드바 -->
		<div class="col-2 height-1050 is-border is-shadow">
			<jsp:include page="../main/sidebar.jsp"></jsp:include>
			<img src="../resources/img/logo.png" style="width: 90%;" onclick="location.href='../main/main.jsp'">
			<ul class="menu-group">
				<li class="menu"><i class="fi fi-rr-home"></i> 메인페이지</li>
				<li class="menu active"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 관리</li>		
				<li class="menu"><i class="fi fi-rr-coins"></i> 자산관리</li>		
				<li class="menu"><i class="fi fi-rs-calendar-check"></i> 캘린더</li>		
				<li class="menu"><i class="fi fi-rs-chart-histogram"></i> 목표 관리</li>
				<li class="menu"><i class="fi fi-rr-sign-out-alt"></i> 로그아웃</li>
			</ul>
		</div>

		<!-- 컨텐츠 -->
		<div class="col-8">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
			<div>
				<h3 class="h-normal fs-28"><i class="fi fi-rr-chart-pie-alt"></i> 자산 통계</h3>
				<!-- 날짜 보여주기 -->
				<div style="margin-bottom: 3%; width: 50%;">
					<table class="is-center" style="width: 100%;">
						<tr>
							<td>
								<i class="fi fi-rr-angle-circle-left fs-28 click-icon" id="before"></i>
							</td>
							<td style="width: 500px;" class="text-center">
								<div id="month-div" style="margin: 10px; cursor: pointer;"></div>
								
								<!-- 날짜 선택 div -->
								<div class="is-border" id="select-month" style="z-index: 2; position: absolute; background: white; display: none;">
									<table class="date-table">
										<tr>
											<td id="before-year"><i class="fi fi-rr-angle-left"></i></td>
											<td colspan="2" style="text-align: center;">
												<div class="h-bold fs-18" id="current-year"></div>
											</td>
											<td id="after-year"><i class="fi fi-rr-angle-right"></i></td>
										</tr>
										<tr>
											<td class="month-td">01월</td>
											<td class="month-td">02월</td>
											<td class="month-td">03월</td>
											<td class="month-td">04월</td>
										</tr>
										<tr>
											<td class="month-td">05월</td>
											<td class="month-td">06월</td>
											<td class="month-td">07월</td>
											<td class="month-td">08월</td>
										</tr>
										<tr>
											<td class="month-td">09월</td>
											<td class="month-td">10월</td>
											<td class="month-td">11월</td>
											<td class="month-td">12월</td>
										</tr>
									</table>
								</div>
							</td>
							<td>
								<i class="fi fi-rr-angle-circle-right fs-28 click-icon" id="after"></i>
							</td>
						</tr>
					</table>
				</div>
				
				<div>
					<div class="col-5">
						<!-- 수입/지출 통계 -->
						<div id="stats-div" class="">
							<table class="button-table" style="margin-left: 10%;">
								<tr>
									<td class="" id="in-stats-btn">수입</td>
									<td class="active" id="out-stats-btn">지출</td>
								</tr>
							</table>
							<div style="margin-left: 10%;">
								<div id="piechart" style="width: 500px; height: 400px; margin-left: 50px; margin-top: 50px;"></div>
								<div id="stats-list-div"></div>
							</div>
						</div>
					</div>
					<div class="col-5">
						<!-- 자산별 내역 -->
						<div class="add-div is-border is-shadow hide" id="details-div">
							<button class="x-btn" id="close-asset-account">x</button>
							<h3 class="h-normal fs-28" id="name-div"></h3>
							<div id="account-total-div"></div>
							<div id="account-list-div"></div>
						</div>
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