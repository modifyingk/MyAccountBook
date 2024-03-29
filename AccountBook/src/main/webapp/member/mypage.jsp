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
					<div id="div1"></div> <!-- 이번 달 수입/지출 -->
					<div id="div2"></div>
				</div>
				<div id="right">
					<div id="div1">
					</div>
				</div>
				
				<!-- 총 목표 추가 모달 -->
				<div class="modal" id="add-aimtotal-modal" hidden="true">
					<div class="modal-content">
						<div class="modal-title">
							<button class="x-btn" id="close-add-aimtotal">x</button>
						</div>
						<div class="modal-body">
							<h2>자산 목표를 설정해주세요!</h2>
							<p>모으고자 하는 금액을 입력해주세요.</p>
							<div>
								<table>
									<tr>
										<td><i class="fi fi-rs-won-sign"></i> <input type="text" class="input" id="add-aimtotal"></td>
									</tr>
								</table>
								<button class="btn main-color-btn" id="add-aimtotal-btn">추가</button>
							</div>
						</div>
						<div class="modal-footer">
							<button class="btn right main-outline-btn" id="close-add-aimtotal">닫기</button>
						</div>
					</div>
				</div>
				
				<!-- 총 목표 수정 모달 -->
				<div class="modal" id="update-aimtotal-modal" hidden="true">
					<div class="modal-content">
						<div class="modal-title">
							<button class="x-btn" id="close-update-aimtotal">x</button>
						</div>
						<div class="modal-body">
							<h2>자산 목표를 설정해주세요!</h2>
							<p>모으고자 하는 금액을 입력해주세요.</p>
							<div>
								<table>
									<tr>
										<td><i class="fi fi-rs-won-sign"></i> <input type="text" class="input" id="update-aimtotal"></td>
									</tr>
								</table>
								<button class="btn main-color-btn" id="update-aimtotal-btn">수정</button>
							</div>
						</div>
						<div class="modal-footer">
							<button class="btn right main-outline-btn" id="close-update-aimtotal">닫기</button>
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