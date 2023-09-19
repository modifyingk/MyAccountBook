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
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
	<div>
		<div>
			<!-- 사이드바 -->
			<div class="col-3 is-border is-shadow">
				<jsp:include page="../../../main/mainbar.jsp"></jsp:include>
				<img src="../resources/img/logo.png" class="side-logo" onclick="location.href='../main/main.jsp'">
				<ul class="menu-group">
					<li class="menu"><i class="fi fi-rr-home"></i> 메인화면</li>
					<li class="menu"><i class="fi fi-rs-user-add"></i> 회원가입</li>
					<li class="menu"><i class="fi fi-rs-user"></i> 로그인</li>		
					<li class="menu active"><i class="fi fi-rr-search"></i> 아이디 찾기</li>		
					<li class="menu"><i class="fi fi-rr-search"></i> 비밀번호 찾기</li>		
				</ul>
			</div>

			<!-- 컨텐츠 -->
			<div class="col-7 is-center">
				<div class="container margin-small">
					<h2 class="h-normal fs-35"><i class="fi fi-rr-search"></i> 아이디 찾기</h2>
					<p class="msg info">고객님의 아이디 목록입니다.</p><br>
					<% List<MemberVO> idList = (List<MemberVO>) request.getAttribute("idList"); %>
					<table class="list-table">
						<tr>
							<td class="field th">아이디</td>
							<td class="field th">가입일</td>
						</tr>
						<% for(int i = 0; i < idList.size(); i++) { %>
						<tr>
							<td class="field"><%= idList.get(i).getUserid() %></td>
							<td class="field"><%= idList.get(i).getJoindate() %></td>
						</tr>
					<% } %>
					</table>
					<br>
					<a href="/accountbook/member/login.jsp"><button type="button" class="btn medium green" id="goLogin">로그인 하기</button></a>
					<a href="/accountbook/member/find_pw.jsp"><button type="button" class="btn medium outline-green" id="goFindpw">비밀번호 찾기</button></a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
