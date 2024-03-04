<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function () {
		$("#logo h2").click(function () {
			location.href = "../main/main.jsp";
		})
		
		$("#logout").click(function () {
			let op = confirm("로그아웃하시겠습니까?");
			if(op)
				location.href = "../member/logout";
		})
	})
</script>
<style>
	#header {
	display: flex;
	height: 70px;
	box-sizing: border-box;
	box-shadow: 2px 2px 5px lightgray;
	border-radius: 10px;
	background: #f39c12;
	}
	#logo {
		margin-left: 30px;"
		padding: 10px;
	}
	#logo h2 {
		width: 220px;
		cursor: pointer;
	}
	#logout {
		font-size: 20px;
		font-weight: bold;
		color: white;
		cursor: pointer;
		position: absolute;
		right: 50px;
		top: 28px;
	}
</style>
<div id="header">
	<div id="logo">
		<h2>MONEY PLANT <i class="fi fi-rs-seedling"></i></h2>
	</div>
	<div>
		<a id="logout">로그아웃</a>
	</div>
</div>
