<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 게시판</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/board/modify.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
	var bno = <%= request.getParameter("bno") %>;
</script>
</head>
<body>
	<div>
		<!-- 사이드바 -->
		<div class="col-2 is-border is-shadow">
			<jsp:include page="../main/sidebar.jsp"></jsp:include>
			<img src="../resources/img/logo.png" style="width: 90%;" onclick="location.href='../main/main.jsp'">
			<ul class="menu-group">
				<li class="menu"><i class="fi fi-rr-home"></i> 메인페이지</li>
				<li class="menu"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 관리</li>		
				<li class="menu"><i class="fi fi-rr-coins"></i> 자산관리</li>		
				<li class="menu"><i class="fi fi-rs-calendar-check"></i> 캘린더</li>		
				<li class="menu"><i class="fi fi-rs-chart-histogram"></i> 목표 관리</li>
				<li class="menu active"><i class="fi fi-rr-comment-alt"></i> 게시판</li>
				<li class="menu"><i class="fi fi-rr-users-alt"></i> 그룹</li>
				<li class="menu"><i class="fi fi-rr-sign-out-alt"></i> 로그아웃</li>
			</ul>
		</div>
		<!-- 컨텐츠 -->
		<div class="col-8">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<div>
					<h3 class="h-normal fs-28"><i class="fi fi-rr-pencil"></i> 글 수정</h3>
					<form action="updateBoard" method="post" role="form" id="update-board-form">
						<table>
							<tr>
								<td><input name="bno" id="bno" hidden="hidden"></td>
							</tr>
							<tr>
								<td><input class="input" name="title" id="title" placeholder="제목을 입력해주세요"></td>
							</tr>
							<tr>
								<td><textarea rows="10" name="content" class="input" id="content"></textarea></td>
							</tr>
							<tr>
								<td>
									<div id="upload-div">
										<input type="file" id= "filename" multiple>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div id="upload-list-div">
										<ul style="list-style-type: none;"></ul>
									</div>
								</td>
							</tr>
						</table>
						
						<input type="checkbox" id="isanony" name="isanony" value="o">
						<label for="isanony">익명</label><br>
						<input type="hidden" name="userid" value='<%= session.getAttribute("userid") %>'>
						<button type="submit" class="btn small green is-shadow" id="update-btn">수정</button>
					</form>
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