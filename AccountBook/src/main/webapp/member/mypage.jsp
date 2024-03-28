<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<link rel="stylesheet" type="text/css" href="../resources/css/member/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/member/my_page.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
</script>
</head>
<body>
	<div>
		<jsp:include page="../main/header.jsp"></jsp:include>
		<jsp:include page="../main/sidebar.jsp"></jsp:include>
		
		<!-- 컨텐츠 -->
		<div class="mypage">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<div id="left">
					<h2 class="title-text"><i class="fi fi-rr-usd-circle"></i> 이번 달 수입과 지출을 확인해보세요!</h2>
					<div id="div1"></div> <!-- 이번 달 수입/지출 -->
					<div id="div2"></div> <!-- 최근 수입/지출 비교 -->
					<div id="div3">
						<h2 class="title-text"><i class="fi fi-rr-usd-circle"></i> 내 또래의 수입 대비 지출은 ?</h2>
					</div>
				</div>
				<div id="right">
					<h2 class="title-text" style="color: white;"><i class="fi fi-rr-usd-circle"></i> 목표를 잡고 돈을 모아보세요!</h2>
					<div id="div1">
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