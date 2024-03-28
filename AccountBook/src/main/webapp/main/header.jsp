<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function () {
		$("#logo h2").click(function () {
			location.href = "../member/mypage.jsp";
		})
		
		$("#logout").click(function () {
			let op = confirm("로그아웃하시겠습니까?");
			if(op)
				location.href = "../member/logout";
		})
	})
</script>
<div id="header">
	<div id="logo">
		<h2><i class="fi fi-rr-sack-dollar"></i> 나의 가계부</h2>
	</div>
	<div>
		<a id="logout">로그아웃</a>
	</div>
</div>
