<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 카테고리</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-solid-rounded/css/uicons-solid-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="../resources/js/account/smallcate.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
</script>
<style type="text/css">
	#select-category td {
		width: 300px;
		height: 30px;
		padding: 10px;
		border: 1px solid #f29c12;
		border-radius: 10px;
		color: #f29c12;
		font-weight: bold;
		text-align: center;
	}
	#select-category td:hover {
		background-color: #f39c12;
		color: white;
		cursor: pointer;
	}	
	#select-category td.active {
		background-color: #f39c12;
		color: white;
	}
	.key-div {
		width:150px;
		color:white;
		text-align: center;
		padding:10px;
		border-radius: 50px;
		font-weight: bold;
		margin: 10px 0;
		cursor: pointer;
		float: left;
	}
	.incategory-div, .outcategory-div {
		width: 470px;
		height: 350px;
		overflow-y: auto;
	}
	.incategory-div .key-div {
		background: #6482B9;
	}
	.outcategory-div .key-div {
		background: #F56E6E;
	}
	#main-div {
		display: inline-block;
		margin: 20px 100px;
	}
	.manage-btn {
		margin: 12px 10px;	
		width: 35px;
		height: 35px;
		border-radius: 30px;
		border: none;
		font-size: 20px;
		cursor: pointer;
	}
	.manage-btn:hover {
		background: lightgray;
	}
	#income-t1, #income-t2, #income-t3, #income-t4, #income-t5, #income-t6 td {
		width: 350px;
	}
	#spend-t1, #spend-t2, #spend-t3, #spend-t4, #spend-t5, #spend-t6, #spend-t7, #spend-t8, #spend-t9, #spend-t10, #spend-t11, #spend-t12 td {
		width: 350px;
	}
	.add-div {
		float:left;
		width: 50px;
		height:40px;
		border-radius:10px;
		font-size:25px;
		text-align:center;
		background:#f3f3f3;
		cursor: pointer;
	}
	.add-div:hover {
		background: lightgray;
	}
	.input.inner {
		width: 270px;
	}
	.input.inner.update {
		width: 240px;
	}
	.update-btn {
		border: none;
		border-radius: 10px;
		background: white;
		width: 35px;
		height: 30px;
		background: transparent;
		cursor: pointer;
	}
	.check-btn {
		font-size: 20px;
		color: #2C952C;
	}
	.check-btn:hover {
		background: #2C952C;
		color: white;
	}
	.cross-btn {
		font-size: 18px;
		color:#E34234;
	}
	.cross-btn:hover {
		background: #E34234;
		color: white;
	}
</style>
</head>
<body>
	<div>
		<jsp:include page="../main/header.jsp"></jsp:include>
		<jsp:include page="../main/sidebar.jsp"></jsp:include>

		<!-- 컨텐츠 -->
		<div id="main-div">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
			<div>
				<h2 class="fs35 main-color"> 카테고리 관리</h2>
				<div>
					<table id="select-category">
						<tr>
							<td class="active" id="select-in">수입</td>
							<td id="select-out">지출</td>
						</tr>
					</table>
				</div>
				<br><br>
				
				<!-- 수입 카테고리 -->
				<div class="is-scroll h700" id="incategory-list">
					<div style="float: left;">
						<div class="incategory-div">
							<table id="income-t1">
								<tr><td><div class="key-div">소득</div><button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
					</div>
					<div style="float: left;">
						<div class="incategory-div">
							<table id="income-t2">
								<tr><td><div class="key-div">저축</div>
								<button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
					</div>
					<div style="float: left;">
						<div class="incategory-div">
							<table id="income-t3">
								<tr><td><div class="key-div">기타</div>
								<button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
					</div>
				</div>
				
				<!-- 지출 카테고리 -->
				<div class="is-scroll h700 hide" id="outcategory-list">
					<div style="float: left;">
						<div class="outcategory-div">
							<table id="spend-t1">
								<tr><td><div class="key-div">식비</div>
								<button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
						<div class="outcategory-div">
							<table id="spend-t2">
								<tr><td><div class="key-div">문화/여가</div>
								<button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
						<div class="outcategory-div">
							<table id="spend-t3">
								<tr><td><div class="key-div">패션/뷰티</div>
								<button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
						<div class="outcategory-div">
							<table id="spend-t4">
								<tr><td><div class="key-div">공과금</div>
								<button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
					</div>
					<div style="float: left;">
						<div class="outcategory-div">
							<table id="spend-t5">
								<tr><td><div class="key-div">마트/편의점</div>
								<button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
						<div class="outcategory-div">
							<table id="spend-t6">
								<tr><td><div class="key-div">주거/통신</div>
								<button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
						<div class="outcategory-div">
							<table id="spend-t7">
								<tr><td><div class="key-div">의료/건강</div>
								<button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
						<div class="outcategory-div">
							<table id="spend-t8">
								<tr><td><div class="key-div">교육</div>
								<button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
					</div>
					<div style="float: left;">
						<div class="outcategory-div">
							<table id="spend-t9">
								<tr><td><div class="key-div">생활용품</div>
								<button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
						<div class="outcategory-div">
							<table id="spend-t10">
								<tr><td><div class="key-div">교통/차량</div>
								<button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
						<div class="outcategory-div">
							<table id="spend-t11">
								<tr><td><div class="key-div">선물/경조사</div>
								<button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
						<div class="outcategory-div">
							<table id="spend-t12">
								<tr><td><div class="key-div">기타</div>
								<button class="manage-btn">···</button></td></tr>
								<tr><td>
									<div class='is-border'>
										<div class='add-div' id='add-btn'>+</div>
										<div><input class='input inner' id='add-outcate'></div>
									</div>
								</td></tr>
							</table>
						</div>
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