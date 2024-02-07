<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 자산 관리</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-solid-rounded/css/uicons-solid-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<link rel="stylesheet" type="text/css" href="../resources/css/table.css">
<link rel="stylesheet" type="text/css" href="../resources/css/asset.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/asset/asset.js"></script>
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
				<li class="menu"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 관리</li>		
				<li class="menu active"><i class="fi fi-rr-coins"></i> 자산관리</li>		
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
					<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산관리</h3>
					<div class="col-5">
						<div class="fix-left-bl">
							<button class="btn medium green font-18 is-shadow" id="open-add-asset"><i class="fi fi-rr-add"></i> 자산 추가</button>
					</div>
						<!-- 자산 목록 -->
						<div style="margin-left: 10%;">
							<div id="asset-total-div" style="margin: 5px;"></div><br> <!-- 총 금액 -->
							<div id="asset-list-div"></div> <!-- 목록 -->
						</div>
					</div>
					<div class="col-5">
						<button class="btn outline-green is-shadow" id="open-hide-asset"><i class="fi fi-rr-eye-crossed"></i> 숨김 관리</button>
						<button class="btn green is-shadow" id="open-transfer-list">이체 내역</button>
						
						<!-- 자산 추가 div -->
						<div class="add-div is-border is-shadow hide" id="add-asset-div">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산 추가</h3>
							<button class="x-btn" id="close-add-asset">x</button>
							<table class='table'>
								<tr>
									<th>그룹</th>
									<td>
										<input class='input' id='add-asset-group' placeholder="그룹선택" readonly>
										<div class="input is-scroll select-group-div hide" style="position:absolute; background: white; height:380px;">
											<table class="select-table td-border tr-hover" id="asset-group-table">
												<tr><td>현금</td></tr>
												<tr><td>은행</td></tr>
												<tr><td>카드</td></tr>
												<tr><td>신용카드</td></tr>
												<tr><td>선불카드</td></tr>
												<tr><td>저축</td></tr>
												<tr><td>투자</td></tr>
												<tr><td>대출</td></tr>
												<tr><td>보험</td></tr>
												<tr><td>기타</td></tr>
											</table>
										</div>
									</td>
								<tr>
								<tr>
									<th>이름</th>
									<td>
										<input class='input' id='add-asset-name' maxlength="20">
									</td>
								</tr>
								<tr>
									<th>금액</th>
									<td>
										<input class='input' id='add-asset-total'>
									</td>
								</tr>
								<tr>
									<th>메모</th>
									<td>
										<textarea rows='5' class='input' id='add-asset-memo' maxlength="100"></textarea>
									</td>
								</tr>
							</table>
							<p class="fs-16 red">* 금액 추가 시 차액은 수입/지출 내역에 기록됩니다</p>
							<button class='btn medium green' id='add-asset-btn'>추가</button>
						</div>
						
						<!-- 자산 수정 div -->
						<div class="add-div is-border is-shadow hide" id="update-asset-div">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산 수정</h3>
							<button class="x-btn" id="close-update-asset">x</button>
							<table class='table'>
								<tr hidden="true">
									<td colspan="2">
										<input class="input" id="update-assetid">
									</td>
								<tr>
								<tr>
									<th>그룹</th>
									<td>
										<input class="input" id="update-asset-group" readonly>
										<div class="input is-scroll select-group-div hide" style="position:absolute; background: white; height:380px;">
											<table class="select-table td-border tr-hover" id="asset-group-table">
												<tr><td>현금</td></tr>
												<tr><td>은행</td></tr>
												<tr><td>카드</td></tr>
												<tr><td>신용카드</td></tr>
												<tr><td>선불카드</td></tr>
												<tr><td>저축</td></tr>
												<tr><td>투자</td></tr>
												<tr><td>대출</td></tr>
												<tr><td>보험</td></tr>
												<tr><td>기타</td></tr>
											</table>
										</div>
									</td>
								<tr>
								<tr>
									<th>이름</th>
									<td>
										<input class="input" id="update-asset-name" maxlength="20">
									</td>
								</tr>
								<tr>
									<th>금액</th>
									<td>
										<input class="input" id="update-asset-total">
									</td>
								</tr>
								<tr>
									<th>메모</th>
									<td>
										<textarea rows="5" class="input" id="update-asset-memo" maxlength="100"></textarea>
									</td>
								</tr>
							</table>
							<p class="fs-16 red">* 금액 수정 시 차액은 수입/지출 내역에 기록됩니다</p>
							<button class="btn medium green" id="update-asset-btn">수정</button>
							<button class="btn medium outline-green" id="delete-asset-btn">삭제</button>
						</div>
						
						<!-- 숨김 자산 div -->
						<div class="add-div is-border is-shadow hide" id="hide-asset-div">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-eye-crossed"></i> 숨겨진 자산</h3>
							<button class="x-btn" id="close-hide-asset">x</button>
							<div id="hide-asset-list-div"></div>
						</div>
						
						<!-- 이체 추가  div -->
						<div class="add-div is-border is-shadow hide" id="add-transfer-div">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-exchange"></i> 이체</h3>
							<button class="x-btn" id="close-add-transfer">x</button>
							<table class="table">
								<tr>
									<th>날짜</th>
									<td><input class="input" type="date" id="add-transfer-date"></td>
								</tr>
								<tr>
									<th>출금</th>
									<td>
										<input class="hide" id="add-withdraw-id">
										<input id="add-withdraw-id" class="hide">
										<input class="input" type="text" id="add-withdraw" placeholder="자산선택" readonly>
									</td>
								</tr>
								<tr>
									<th>입금</th>
									<td>
										<input class="hide" id="add-deposit-id">
										<input id="add-deposit-id" class="hide">
										<input class="input" type="text" id="add-deposit" placeholder="자산선택" readonly>
										<div class="input is-scroll select-asset-div" style="position:absolute; display: none; background: white; height:400px;">
											<div class="select-asset-list"></div>
										</div>
									</td>
								</tr>
								<tr>
									<th>금액</th>
									<td><input class="input" type="text" id="add-transfer-total"></td>
								</tr>
								<tr>
									<th>메모</th>
									<td><textarea rows="5" class="input" id="add-transfer-memo" maxlength="100"></textarea></td>
								</tr>
							</table>
							<button class="btn medium green" id="add-transfer-btn">추가</button>
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