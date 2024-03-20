<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	$(function () {
		$(".myinfo-div").click(function () {
			location.href = "../member/mypage.jsp";
		})
		
		$(".menu-group li").click(function() { // li 클릭하면
			let group = $(this).parent().attr("id");
			let menu_idx = $(this).index();
			if(group == "group1") {
				if(menu_idx == 0) {
					location.href = "../account/account.jsp";
				} else if(menu_idx == 1) {
					location.href = "../calendar/calendar.jsp";
				} else if(menu_idx == 2) {
					location.href = "../account/category_stats.jsp";
					
				}
			} else if(group == "group2") {
				if(menu_idx == 0) {
					location.href = "../asset/asset.jsp";
				}
			} else if(group == "group3") {
				if(menu_idx == 0) {
					location.href = "../aim/aim.jsp";
				} else if(menu_idx == 1) {
					
				}
			}
		})
	})
</script>
</head>
<body>
	<div class="sidebar nav">
		<div class="myinfo-div">
			<i class="fi fi-rr-circle-user" id="myinfo-btn"></i>
			<p id="login-id"><%= session.getAttribute("userid") %></p>
		</div>
		<hr>
		<div>
			<div class="menu-title">가계부</div>
			<ul class="menu-group" id="group1">
				<li><i class="fi fi-rr-rectangle-list"></i> 수입/지출 내역</li>
				<li><i class="fi fi-rr-calendar-check"></i> 캘린더</li>
				<li><i class="fi fi-rs-chart-pie-alt"></i> 분석</li>
			</ul>
		</div>
		<hr>
		<div>
			<div class="menu-title">자산</div>
			<ul class="menu-group" id="group2">
				<li><i class="fi fi-rr-hands-usd"></i> 자산 관리</li>
			</ul>
		</div>
		<hr>
		<div>
			<div class="menu-title">목표</div>
			<ul class="menu-group" id="group3">
				<li><i class="fi fi-rs-checkbox"></i> 목표 관리</li>
				<li><i class="fi fi-rr-trophy"></i> 목표 달성</li>
			</ul>
		</div>
	</div>
</body>
</html>