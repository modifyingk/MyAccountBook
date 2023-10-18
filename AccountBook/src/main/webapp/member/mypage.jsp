<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function() {
		var userid = "<%= session.getAttribute("userid") %>";
		// 현재 세션의 포인트 정보 가져오기
		$.ajax({
			type : "post",
			url : "userMoneyInfo",
			data : {
				userid : userid
			},
			success : function(info) {
				$("#point-div").html(info.userpoint);
			}
		})
		
		$("#myinfo-btn").click(function() {
			location.href = "../member/myInfo.jsp";
		})
		
		var angle = 0;
		$("#water-btn").mousedown(function() {
			angle++;
			$("#water-img").show();
			if(angle >= 5) {
				$("#plant-step").attr("src", "../resources/img/moneyleaf.png");
			}
			if(angle >= 10) {
				$("#plant-step").attr("src", "../resources/img/moneyflower.png");
			}
			if(angle >= 15) {
				$("#plant-step").attr("src", "../resources/img/moneyfruit.png");
			}
			if(angle == 16) {
				$("#plant-step").attr("src", "../resources/img/moneyseed.png");
				angle = 0;
			}
		})
		$("#water-btn").mouseup(function() {
			$("#water-img").hide();
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
				<li class="menu active"><i class="fi fi-rr-home"></i> 메인페이지</li>
				<li class="menu"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 관리</li>		
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
					<div class="col-8">
						<h2 class="h-normal fs-35" id="myinfo-btn"><i class="fi fi-rs-user"></i> <%= session.getAttribute("userid") %></h2>
						<div class="container margin-small">
							<div>
								<h2 class="text-center green fs-35"><i class="fi fi-ts-seedling"></i>  물 주세요 !</h2>
								<h2 class="text-center info fs-28"><i class="fi fi-ts-seedling"></i>  물 하나에 10 포인트</h2>
								<img src="../resources/img/watering.png" width="200px" id="water-btn">
								<img src="../resources/img/water.png" width="80px;" id="water-img">
								<img src="../resources/img/moneyseed.png" id="plant-step" width="200px;">
							</div>
						</div>			
					</div>
					<div class="col-2">
						<br>
						<div class="col-5" style="width:50px;">
							<img src='../resources/img/point.gif' width='50px'>
						</div>
						<div class="col-5" style="margin-top: 5px;">
							<i class="h-normal fs-28" id='point-div'></i><i class='h-normal fs-28'>P</i>
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