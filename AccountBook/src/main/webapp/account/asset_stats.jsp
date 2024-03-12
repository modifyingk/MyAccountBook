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
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<link rel="stylesheet" type="text/css" href="../resources/css/account/stats.css">
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
		<jsp:include page="../main/header.jsp"></jsp:include>
		<jsp:include page="../main/sidebar.jsp"></jsp:include>

		<!-- 컨텐츠 -->
		<div class="container asset-stats">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
			<div>
				<h3 class="title-text"><i class="fi fi-rr-chart-pie-alt"></i> 자산 통계</h3>
				
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