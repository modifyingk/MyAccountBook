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
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<link rel="stylesheet" type="text/css" href="../resources/css/table.css">
<link rel="stylesheet" type="text/css" href="../resources/css/account.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="../resources/js/account/category.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
</script>
</head>
<body>
	<div>
		<!-- 사이드바 -->
		<div class="col-2 height-1050 is-border is-shadow">
			<jsp:include page="../main/sidebar.jsp"></jsp:include>
			<img src="../resources/img/logo.png" style="width: 90%;" onclick="location.href='../main/main.jsp'">
			<ul class="menu-group">
				<li class="menu"><i class="fi fi-rr-home"></i> 메인페이지</li>
				<li class="menu active"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 관리</li>		
				<li class="menu"><i class="fi fi-rr-coins"></i> 자산관리</li>		
				<li class="menu"><i class="fi fi-rs-calendar-check"></i> 캘린더</li>		
				<li class="menu"><i class="fi fi-rs-chart-histogram"></i> 목표 관리</li>
				<li class="menu"><i class="fi fi-rr-sign-out-alt"></i> 로그아웃</li>
			</ul>
		</div>

		<!-- 컨텐츠 -->
		<div class="col-8">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
			<div>
				<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 카테고리 관리</h3>
				<div>
					<div class="col-7">
						<div class="col-5">
							<h3 class="h-normal fs-23"> 수입 카테고리</h3>
							<div class="category-div">
								<div id="in-category-list-div"></div>
								<table class="select-table td-border">
									<tr>	
										<td>
											<input placeholder="추가 입력" id="income-catename">
											<button class="check-btn" id="add-income-btn"><i class="fi fi-rr-check"></i></button>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<div class="col-5">
							<h3 class="h-normal fs-23"> 지출 카테고리</h3>
							<div class="category-div">
								<div id="out-category-list-div"></div>
								<table class="select-table is-border">
									<tr>
										<td>
											<input placeholder="추가 입력" id="spend-catename">
											<button class="check-btn" id="add-spend-btn"><i class="fi fi-rr-check"></i></button>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 카테고리 추가 -->
				<div id="add-category-div" class="add-div is-border is-shadow hide">
					<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 카테고리 추가</h3>
					<button class="x-btn" id="close-add-category">x</button>
					<table class="table">
						<tr>
							<th>분류</th>
							<td>
								<div class="select">
									<input type="radio" name="category-type" id="in-category" value="수입"><label for="in-category">수입</label>
									<input type="radio" name="category-type" id="out-category" value="지출" checked><label for="out-category">지출</label>
								</div>
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" class="input" id="catename" maxlength="20"></td>
						</tr>
					</table>
					<button class="btn medium green" id="add-category-btn">추가</button>
				</div>
								
				<!-- 카테고리 수정 모달 -->
				<div class="modal" id="up-category-modal" hidden="true">
					<div class="modal-content small">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 카테고리 수정</h3>
						</div>
						<hr>
						<div class="modal-body small">
							<h5 class='h-normal fs-20'><i class="fi fi-rr-pencil"></i> 카테고리명</h5>
							<div id="up-in-category-div">
								<table class='table'>
									<tr>
										<th>분류</th>
										<td><input type="text" class="input" id='up-moneytype' readonly></td>
									</tr>
									<tr>
										<th>이름</th>
										<td><input type="text" class="input" id='up-catename'></td>
									</tr>
								</table>
								<div id="up-catename-check-div">
									<p class="msg info">이름은 특수문자 제외, 한 글자 이상 입력 ( /는 사용 가능)</p>
								</div>
								<br>
								<button class="btn medium green" id="up-category-btn">수정</button>
								<button class="btn outline-green" id="del-category-btn" style='height: 48px;'>삭제</button>
							</div>
						</div>
						<hr>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-up-category">닫기</button>
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