<%@page import="com.modifyk.accountbook.board.ReplyVO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.modifyk.accountbook.board.FileVO"%>
<%@page import="com.modifyk.accountbook.board.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 게시판</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
</script>
</head>
<body>
	<div>
		<!-- 사이드바 -->
		<div class="col-2 is-border is-shadow">
			<jsp:include page="../../../main/sidebar.jsp"></jsp:include>
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
					<h3 class="h-normal fs-28"><i class="fi fi-rr-comment-alt"></i> 게시판</h3>
					<% BoardVO board = (BoardVO) request.getAttribute("board"); 
						List<FileVO> file = (List<FileVO>) request.getAttribute("file");
						List<ReplyVO> reply = (List<ReplyVO>) request.getAttribute("reply");
					
						String writer = "";
						if(board.getIsanony().equals("o")) {
							writer = "익명";
						} else {
							writer = board.getUserid();
						}
						
					%>
					<div>
						<div class="col-6 is-border">
							<table class="table board-table">
								<tr>
									<td style="display: none;" id="td-bno"><%= board.getBno() %></td>
								</tr>
								<tr>
									<td class="fs-28"><%= board.getTitle() %></td>
								</tr>
								<tr>
									<td class="info"><i class="fi fi-rr-circle-user"></i> <%= writer %> | <%= board.getDate().substring(0, 16) %></td>
								</tr>
								<tr>
									<td>
									<%
									for(int i = 0; i < file.size(); i++) {
										String fileCallPath = URLEncoder.encode(file.get(i).getUploadpath() + "\\s_" + file.get(i).getUuid() + "_" + file.get(i).getFilename());
										%>
										<div style="float: left; margin: 10px; padding: 10px;"><img src='display?filename=<%= fileCallPath %>'></div>
									<%
									}
									%>
									</td>
								</tr>
								<tr>
									<td><div class="is-scroll"><%= board.getContent() %></div></td>
								</tr>
							</table>
						</div>
						
						<%
						if(session.getAttribute("userid").equals(board.getUserid())) { // 자신이 작성한 글이면 수정 삭제 가능하도록 버튼 생성
						%>
						<div id="manage-board-div">
							<form action="modify.jsp" method="post">
								<input name="bno" hidden="hidden" value="<%= board.getBno() %>">
								<button type="submit" class="btn outline-green" id="update-board-btn">수정</button>
							<button class="btn outline-green" id="delete-board-btn">삭제</button>
							<script type="text/javascript">
								// 게시물 삭제 버튼 클릭 시
								$(document).on("click", "#delete-board-btn", function() {
									var op = confirm("정말로 게시물을 삭제하시겠습니까?");
									if(op) {
										$.ajax({
											url : "deleteBoard",
											data : {
												bno : $("#td-bno").text()
											},
											success : function (x) {
												if(x == "success") {
													location.href = "../board/board.jsp";
												} else {
													alert("다시 시도해주세요.");
												}
											}
										})
									}
								})
							</script>
							</form>
						</div>
						<%
						}
						%>
						<div class="col-4 is-border">
							<h4 class="h-normal fs-23">댓글</h4>
							<hr>
							<div class="is-scroll" style="height: 780px;">
								<table class="table" style="width: 600px;">
									<%
									String replier = "";
									for(int i = 0; i < reply.size(); i++) {
										if(reply.get(i).getIsanony().equals("o")) {
											replier = "익명";
										} else {
											replier = reply.get(i).getUserid();
										}
									%>
										<tr>
											<td><div style="float: left;">
												<i class="fi fi-rr-circle-user"></i><span class="fs-20"> <%= replier %></span>
												<span class="fs-16 info">  |  <%= reply.get(i).getDate().substring(0, 16) %></span>
											</div></td>
											<% if(session.getAttribute("userid").equals(reply.get(i).getUserid())) { %>
												<td><a href="../board/deleteReply?rno=<%= reply.get(i).getRno()%>" style="float: right;">삭제</a></td>
											<% } %>
										</tr>
										<tr>
											<td colspan="2" style="border-bottom: 1px solid lightgray; padding-bottom: 20px;"><%= reply.get(i).getContent() %></td>
										</tr>
									<%
									}
									%>
								</table>
							</div>
							<hr>
							<table>
								<tr>
									<td><input class="input" id="content" style="width: 430px;" placeholder="댓글을 입력하세요."></td>
									<td style="width: 100px; text-align: center">
										<input type="checkbox" id="isanony" value="o">
										<label for="isanony">익명</label>
									</td>
									<td><button class="btn green" id="reply-btn" style="width: 70px;"><i class="fi fi-rr-paper-plane fs-20"></i></button></td>
								</tr>
							</table>
						</div>
						<script>
							$("#reply-btn").click(function () {
								var isanony;
								if($("#isanony").is(":checked")) {
									isanony = "o";
								} else {
									isanony = "x";
								}
								$.ajax({
									type : "post",
									url : "../board/insertReply",
									data : {
										content : $("#content").val(),
										userid : userid,
										isanony : isanony,
										bno : $("#td-bno").text()
									},
									success : function () {
										location.reload();
									}
								})
							})
						</script>
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
