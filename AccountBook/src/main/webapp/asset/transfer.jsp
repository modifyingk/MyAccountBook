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
<link rel="stylesheet" type="text/css" href="../resources/css/table.css">
<link rel="stylesheet" type="text/css" href="../resources/css/asset.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/asset/transfer.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
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
				<li class="menu"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 관리</li>		
				<li class="menu active"><i class="fi fi-rr-coins"></i> 자산관리</li>		
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
					<h3 class="h-normal fs-28"><i class="fi fi-rr-exchange"></i> 이체내역</h3>
					<div class="col-5">
						<div id="transfer-div">
							<!-- 날짜 보여주기 -->
							<div style="margin-bottom: 3%; width: 50%;">
								<table style="width: 600px;">
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
							<div class="is-scroll" id="transfer-list-div"></div>
						</div>
					</div>
					<div class="col-5">
						<!-- 이체 수정 div -->
						<div class="add-div is-border is-shadow hide" id="update-transfer-div">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-exchange"></i> 이체 수정</h3>
							<button class="x-btn" id="close-update-transfer">x</button>
							<table class="table">
								<tr class="hide">
									<td colspan="2"><input class="input" type="text" id="update-transfer-id"></td>
								</tr>
								<tr>
									<th>날짜</th>
									<td><input class="input" type="date" id="update-transfer-date"></td>
								</tr>
								<tr>
									<th>출금</th>
									<td><input class="input" type="text" id="update-withdraw" placeholder="자산선택" disabled="disabled"></td>
								</tr>
								<tr>
									<th>입금</th>
									<td><input class="input" type="text" id="update-deposit" placeholder="자산선택" disabled="disabled"></td>
								</tr>
								<tr>
									<th>금액</th>
									<td><input class="input" type="text" id="update-transfer-total"></td>
								</tr>
								<tr>
									<th>메모</th>
									<td><textarea rows="5" class="input" id="update-transfer-memo" maxlength="100"></textarea></td>
								</tr>
							</table>
							<button class="btn medium green" id="update-transfer-btn">수정</button>
							<button class="btn medium outline-green" id="delete-transfer-btn">삭제</button>
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