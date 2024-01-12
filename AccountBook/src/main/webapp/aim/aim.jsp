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
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/aim/aim.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
</script>
</head>
<body>
	<div class="">
		<!-- 사이드바 -->
		<div class="col-2 is-border is-shadow">
			<jsp:include page="../main/sidebar.jsp"></jsp:include>
			<img src="../resources/img/logo.png" style="width: 90%;" onclick="location.href='../main/main.jsp'">
			<ul class="menu-group">
				<li class="menu"><i class="fi fi-rr-home"></i> 메인페이지</li>
				<li class="menu"><i class="fi fi-rr-add"></i> 수입/지출 관리</li>		
				<li class="menu"><i class="fi fi-rr-coins"></i> 자산관리</li>		
				<li class="menu"><i class="fi fi-rs-calendar-check"></i> 캘린더</li>		
				<li class="menu active"><i class="fi fi-rs-chart-histogram"></i> 목표 관리</li>
				<li class="menu"><i class="fi fi-rr-comment-alt"></i> 게시판</li>
				<li class="menu"><i class="fi fi-rr-users-alt"></i> 그룹</li>
				<li class="menu"><i class="fi fi-rr-sign-out-alt"></i> 로그아웃</li>
			</ul>
		</div>
		
		<!-- 컨텐츠 -->
		<div class="col-8">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<h3 class="h-normal fs-28"><i class="fi fi-rs-chart-histogram"></i> 목표 관리</h3>
				<div class="fix-left-br">
					<button class="btn medium green font-18 is-shadow" id="add-aim-page"><i class="fi fi-rr-add"></i> 목표 추가</button>
				</div>
				<!-- 날짜 보여주기 -->
				<div>
					<table style="width: 100%;">
						<tr>
							<td style="width: 33%; text-align: center;">
								<i class="fi fi-rr-angle-circle-left fs-28 click-icon" id="before"></i>
							</td>
							<td style="width: 33%; text-align: center;">
								<div id="month-div" style="width: 100%; margin: 10px; cursor: pointer;"></div>
								
								<!-- 날짜 선택 div -->
								<div class="is-border" id="select-month" style="position: absolute; background: white; display: none;">
									<table class="date-table">
										<tr>
											<td id="before-year"><i class="fi fi-rr-angle-left"></i></td>
											<td colspan="2" style="text-align: center;">
												<div class="h-bold fs-18" id="current-year"></div>
											</td>
											<td id="after-year"><i class="fi fi-rr-angle-right"></i></td>
										</tr>
										<tr>
											<td class="month-td">01월</td>
											<td class="month-td">02월</td>
											<td class="month-td">03월</td>
											<td class="month-td">04월</td>
										</tr>
										<tr>
											<td class="month-td">05월</td>
											<td class="month-td">06월</td>
											<td class="month-td">07월</td>
											<td class="month-td">08월</td>
										</tr>
										<tr>
											<td class="month-td">09월</td>
											<td class="month-td">10월</td>
											<td class="month-td">11월</td>
											<td class="month-td">12월</td>
										</tr>
									</table>
								</div>
							</td>
							<td style="width: 33%; text-align: center;">
								<i class="fi fi-rr-angle-circle-right fs-28 click-icon" id="after"></i>
							</td>
						</tr>
					</table>
				</div>
				<div>
					<div class="col-5" style="margin-left: 2%;">
						<h4 class='h-normal fs-23 text-center'>지출 목표</h4>
						<div class="is-scroll" id="aim-list-div" style="height: 700px; margin-top: 5%;"></div>
					</div>
					<div class="col-5">
						<h4 class='h-normal fs-23 text-center'>수입 목표</h4>
						<div class="is-scroll" id="aim-in-list-div" style="height: 700px; margin-top: 5%;"></div>
					</div>
				</div>
				
				
			<!-- 목표 추가 모달 -->
			<div class="modal" id="add-aim-modal" hidden="true">
				<div class="modal-content medium">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 목표 추가</h3>
					</div>
					<hr>
					<div class="modal-body medium">
						<div id="">
							<table class="table">
								<tr>
									<td colspan="2">
										<div class="select">
											<input type="radio" name="select-mtype" id="select-in" value="수입"><label for="select-in">수입</label>
											<input type="radio" name="select-mtype" id="select-out" value="지출" checked><label for="select-out">지출</label>
										</div>
									</td>
								</tr>
								<tr>
									<td>날짜</td>
									<td>
										<input class="input small" type="text" id="add-year" placeholder="년(4자)" maxlength="4">
										<select class="input small" id="add-month">
											<option value="01">1</option>
											<option value="02">2</option>
											<option value="03">3</option>
											<option value="04">4</option>
											<option value="05">5</option>
											<option value="06">6</option>
											<option value="07">7</option>
											<option value="08">8</option>
											<option value="09">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>분류</td>
									<td><input type="text" class="input" id="add-catename" placeholder="분류선택" readonly></td>
								</tr>
								<tr>
									<td>금액</td>
									<td><input type="text" class="input" id="add-total"></td>
								</tr>
							</table>
							<button class="btn medium green" id="add-aim-btn">추가</button>
						</div>
					</div>
					<hr>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-add-aim">닫기</button>
					</div>
				</div>
			</div>
			
			<!-- 목표 수정 모달 -->
			<div class="modal" id="up-aim-modal" hidden="true">
				<div class="modal-content medium">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 목표 지출 수정</h3>
					</div>
					<div class="modal-body medium">
						<div id="">
							<table class="table">
								<tr style="display: none;">
									<td colspan="2"><input type="text" class="input" id="up-aimid"></td>
								</tr>
								<tr>
									<td>분류</td>
									<td><input type="text" class="input" id="up-catename" disabled></td>
								</tr>
								<tr>
									<td>금액</td>
									<td><input type="text" class="input" id="up-total"></td>
								</tr>
							</table>
							<button class="btn medium green" id="up-aim-btn">수정</button>
							<button class="btn outline-green" id="del-aim-btn" style="height: 48px;">삭제</button>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-up-aim">닫기</button>
					</div>
				</div>
			</div>
			<!-- 수입 카테고리 선택 모달 -->
			<div class="modal" id="select-incate-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 수입 카테고리</h3>
					</div>
					<div class="modal-body">
						<div id="select-incate-list-div"></div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-select-incate">닫기</button>
					</div>
				</div>
			</div>
			<!-- 지출 카테고리 선택 모달 -->
			<div class="modal" id="select-outcate-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 지출 카테고리</h3>
					</div>
					<div class="modal-body">
						<div id="select-outcate-list-div"></div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-select-outcate">닫기</button>
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