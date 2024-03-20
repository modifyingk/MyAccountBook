<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 목표 관리</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-thin-straight/css/uicons-thin-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<link rel="stylesheet" type="text/css" href="../resources/css/aim/aim.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/aim/aim.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
</script>
</head>
<body>
	<div>
		<jsp:include page="../main/header.jsp"></jsp:include>
		<jsp:include page="../main/sidebar.jsp"></jsp:include>
		
		<!-- 컨텐츠 -->
		<div class="container aim">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
			<div>
				<h2 class="title-text"><i class="fi fi-rs-chart-histogram"></i> 목표 관리</h2>
				<button id="open-add-aim">+</button>
				<div id="div1"></div>
			</div>
			
			<!-- 목표 추가 모달 -->
			<div class="modal" id="add-aim-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs28">목표 추가</h3>
						<button class="x-btn" id="close-add-aim">x</button>
					</div>
					<hr>
					<div class="modal-body">
						<div>
							<table>
								<tr>
									<td>분류</td>
									<td>
										<input type="text" class="input" id="add-bigcate" placeholder="분류선택" readonly>
										<div class="select-add-bigcate select-div hide">
											<table class="select-table">
												<tr>
													<td>식비</td>
													<td>마트/편의점</td>
													<td>생활용품</td>
												</tr>
												<tr>
													<td>문화/여가</td>
													<td>주거/통신</td>
													<td>교통/차량</td>
												</tr>
												<tr>
													<td>패션/뷰티</td>
													<td>의료/건강</td>
													<td>선물/경조사</td>
												</tr>
												<tr>
													<td>공과금</td>
													<td>교육</td>
													<td>기타</td>
												</tr>
											</table>
										</div>
									</td>
									
								</tr>
								<tr>
									<td>금액</td>
									<td><input type="text" class="input" id="add-total"></td>
								</tr>
							</table>
							<button class="btn main-color-btn" id="add-aim-btn">추가</button>
						</div>
					</div>
					<hr>
					<div class="modal-footer">
						<button class="btn right main-outline-btn" id="close-add-aim">닫기</button>
					</div>
				</div>
			</div>
			<!-- 목표 수정 모달 -->
			<div class="modal" id="update-aim-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs28">목표 수정</h3>
						<button class="x-btn" id="close-update-aim">x</button>
					</div>
					<hr>
					<div class="modal-body">
						<div>
							<table>
								<tr>
									<td>분류</td>
									<td>
										<input type="text" class="input" id="update-bigcate" placeholder="분류선택" disabled="disabled">
									</td>
									
								</tr>
								<tr>
									<td>금액</td>
									<td><input type="text" class="input" id="update-total"></td>
								</tr>
							</table>
							<button class="btn main-color-btn" id="update-aim-btn">수정</button>
							<button class="btn main-outline-btn" id="delete-aim-btn">삭제</button>
						</div>
					</div>
					<hr>
					<div class="modal-footer">
						<button class="btn right main-outline-btn" id="close-update-aim">닫기</button>
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