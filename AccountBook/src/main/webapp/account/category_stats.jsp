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
<script type="text/javascript" src="../resources/js/account/category_stats.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
	var today = "<%= request.getParameter("today") %>";
</script>
</head>
<body>
	<div>
		<div>
			<jsp:include page="../main/header.jsp"></jsp:include>
			<jsp:include page="../main/sidebar.jsp"></jsp:include>
		</div>
		<!-- 컨텐츠 -->
		<div class="container stats category-stats">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
			<div>
				<h3 class="title-text"><i class="fi fi-rr-chart-pie-alt"></i> 카테고리 분석</h3>
				
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
								<div class="is-border" id="select-date" style="z-index: 1;">
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
				
				<div id="div2">
					<!-- 대분류 통계 -->
					<div id="top-div1"></div>
					
					<!-- 대분류 상세 -->
					<div id="top-div2" class="hide">
						<div id="inner-div1"></div> <!-- 지출 -->
						<div class="angle-icon scroll-x" id="scroll-smallcate"><i class="fi fi-rr-angle-right"></i></div>
						
						<div id="inner-div2"></div> <!-- 수입 -->
						<div class="angle-icon scroll-x" id="scroll-smallcate"><i class="fi fi-rr-angle-right"></i></div>
					</div>
					
					<!-- 소분류 통계 -->
					<div id="top-div3" class="hide">
						<div id="inner-div1"></div>
						<div id="inner-div2"></div>
					</div>
					
					<!-- 소분류 상세 -->
					<div id="top-div4" class="hide">
						<div id="inner-div1"></div>
						<div id="inner-div2"></div>
					</div>
				</div>
				
				<div id="scroll-top"><i class="fi fi-rr-arrow-alt-square-up"></i></div>
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