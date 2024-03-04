<%@page import="java.util.List"%>
<%@page import="com.modifyk.accountbook.member.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 아이디 찾기</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<style type="text/css">
.list-table {
	border-collapse: collapse;
	width: 600px;
	font-size: 18px;
}
.list-table td {
	width: 30%;
	padding: 10px;
	height: 35px;
}
.list-table tr {
	border: 1px solid lightgray;
	border-radius: 10px;
	border-left: 0;
	border-right: 0;
}
.list-table tr:hover {
	background: #F3F3F3;
	border-color: lightgray;
	cursor: pointer;
}
#login-btn, #find-pw-btn {
	width: 280px;
	height: 48px;
}
#main-div {
	margin-top: 10%;
}
</style>
</head>
<body>
	<div>
		<div>
			<!-- 컨텐츠 -->
			<div>
				<div class="container" id="main-div">
					<h2 class="fs40 main-color"><i class="fi fi-rr-search"></i> 아이디 찾기</h2>
					<% List<MemberVO> idList = (List<MemberVO>) request.getAttribute("idList"); %>
					<%
					if(idList.size() > 0) { %>
						<p class="gray">고객님의 아이디 목록입니다.</p><br>
						<table class="center-table list-table">
							<tr>
								<td>아이디</td>
								<td>가입일</td>
							</tr>
							<% for(int i = 0; i < idList.size(); i++) { %>
							<tr>
								<td><%= idList.get(i).getUserid() %></td>
								<td><%= idList.get(i).getJoindate() %></td>
							</tr> <% } %>
						</table>
					<% } else { %>
						<p class="gray">입력하신 정보와 일치하는 아이디가 없습니다.</p><br>
					<%}%>
					<br>
					<a href="/accountbook/member/login.jsp"><button type="button" class="btn main-color-btn" id="login-btn">로그인 하기</button></a>
					<a href="/accountbook/member/find_id_pw.jsp"><button type="button" class="btn main-outline-btn" id="find-pw-btn">비밀번호 찾기</button></a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
