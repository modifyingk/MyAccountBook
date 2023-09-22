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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/asset/asset.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
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
				<li class="menu active"><i class="fi fi-rr-coins"></i> 자산관리</li>		
				<li class="menu"><i class="fi fi-rs-calendar-check"></i> 캘린더</li>		
				<li class="menu"><i class="fi fi-rs-chart-histogram"></i> 목표 관리</li>
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
						<div class="fix-right-tr-1">
							<button class="btn green font-18 is-shadow" id="open-group-setting" style="width: 60px;"><i class="fi fi-rr-menu-burger"></i></button>
						</div>
						<div class="fix-right-tr-2" id="group-setting" hidden>
							<button class="btn small outline-green font-18 is-shadow" id="astgroup-btn">자산 그룹</button>
						</div>
						<div class="fix-left-bl">
							<button class="btn medium green font-18 is-shadow" id="add-asset-page"><i class="fi fi-rr-add"></i> 자산 추가</button>
							<button class="btn small outline-green font-18 is-shadow" id="reset-asset-btn" style="margin-left: 10px;"><i class="fi fi-rr-rotate-right"></i> 초기화</button>
						</div>
						<div id="asset-total-div" style="margin: 5px;"></div><br>
						<div id="asset-list-div"></div>
					</div>
					<div class="col-5">
						<h3 class="h-normal fs-23"><i class="fi fi-rr-exchange"></i> 이체내역</h3>
						<!-- 날짜 보여주기 -->
						<div style="margin-left: 20%; margin-bottom: 3%;">
							<table>
								<tr>
									<td>
										<i class="fi fi-rr-angle-circle-left fs-28 click-icon" id="before"></i>
									</td>
									<td>
										<div id="month-div" style="width: 100%; margin: 10px;"></div>
									</td>
									<td>
										<i class="fi fi-rr-angle-circle-right fs-28 click-icon" id="after"></i>
									</td>
								</tr>
							</table>
						</div>
						<div class="is-scroll" id="transfer-list-div"></div>
						<div class="fix-right-bl">
							<button class="btn medium green font-18 is-shadow" id="add-transfer-page"><i class="fi fi-rr-add"></i> 이체</button>
						</div>
					</div>

					<!-- 자산 모달 -->
					<div class="modal" id="up-asset-modal" hidden="true">
						<div class="modal-content medium">
							<div class="modal-title">
								<div>
									<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산 수정</h3>
								</div>
							</div>
							<hr>
							<div class="modal-body medium">
								<div id="up-asset-div">
									<table class='table'>
										<tr>
											<th>그룹</th>
											<td>
												<input class="input" id="up-astgroup-name" readonly>
											</td>
										<tr>
										<tr>
											<th>이름</th>
											<td>
												<input class="input" id="up-asset-name" maxlength="20">
											</td>
										</tr>
										<tr>
											<th>금액</th>
											<td>
												<input class="input" id="up-asset-total">
											</td>
										</tr>
										<tr>
											<th>메모</th>
											<td>
												<textarea rows="5" class="input" id="up-astmemo-name" maxlength="100"></textarea>
											</td>
										</tr>
									</table>
									<p class="fs-16 red">* 금액 수정 시 차액은 수입/지출 내역에 기록됩니다</p>
									<button class="btn medium green" id="up-asset-btn">수정</button>
									<button class="btn outline-green" style="height: 48px;" id="del-asset-btn">삭제</button>
								</div>
							</div>
							<hr>
							<div class="modal-footer">
								<button class="btn right outline-green" id="close-up-asset">닫기</button>
							</div>
						</div>
					</div>
					<!-- 자산 추가 모달 -->
					<div class="modal" id="add-asset-modal" hidden="true">
						<div class="modal-content medium">
							<div class="modal-title">
								<div>
									<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산 추가</h3>
								</div>
							</div>
							<div class="modal-body medium">
								<div id="add-asset-div">
									<table class='table'>
										<tr>
											<th>그룹</th>
											<td>
												<input class='input' id='add-astgroup-name' placeholder="그룹선택" readonly>
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
												<textarea rows='5' class='input' id='add-astmemo-name' maxlength="100"></textarea>
											</td>
										</tr>
									</table>
									<p class="fs-16 red">* 금액 추가 시 차액은 수입/지출 내역에 기록됩니다</p>
									<button class='btn medium green' id='add-asset-btn'>추가</button>
								</div>
							</div>
							<div class="modal-footer">
								<button class="btn right outline-green" id="close-add-asset">닫기</button>
							</div>
						</div>
					</div>
					<!-- 자산별 내역 모달 -->
					<div class="modal" id="asset-account-modal" hidden="true">
						<div class="modal-content wide">
							<div class="modal-title">
								<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 자산별 수입/지출 내역</h3>
							</div>
							<div class="modal-body wide">
								<!-- 날짜 보여주기 -->
								<div style="margin-left: 30%; margin-bottom: 1%;">
									<table>
										<tr>
											<td>
												<i class="fi fi-rr-angle-circle-left fs-28 click-icon" id="modal-before"></i>
											</td>
											<td>
												<div id="modal-month-div" style="width: 100%; margin: 10px;"></div>
											</td>
											<td>
												<i class="fi fi-rr-angle-circle-right fs-28 click-icon" id="modal-after"></i>
											</td>
										</tr>
									</table>
								</div>
								<div>
									<table style="width: 620px; margin-bottom: 1%; text-align: center;">
										<tr>
											<td style="width: 30%;"><div id="total-div">합계</div></td>
											<td style="width: 30%;"><div id="total-income-div">총 수입</div></td>
											<td style="width: 30%;"><div id="total-spend-div">총 지출</div></td>
										</tr>
									</table>
								</div>
								<div id="asset-account-list-div"></div>
							</div>
							<div class="modal-footer">
								<button class="btn right outline-green" id="close-asset-account">닫기</button>
							</div>
						</div>
					</div>
					<!-- 그룹 선택 모달 -->
					<div class="modal" id="select-group-modal" hidden="true">
						<div class="modal-content">
							<div class="modal-title">
								<div>
									<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산그룹</h3>
								</div>
							</div>
							<div class="modal-body">
								<div id="select-group-div"></div>
							</div>
							<div class="modal-footer">
								<button class="btn right outline-green" id="close-select-group">닫기</button>
							</div>
						</div>
					</div>
					<!-- -------------------------------------------------------------------------------------------------- -->
					<!-- 자산 그룹 모달 -->
					<div class="modal" id="group-modal" hidden="true">
						<div class="modal-content">
							<div class="modal-title">
								<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산그룹 관리</h3>
							</div>
							<button class="btn medium green" id="add-group-page" style="margin-left: 10px;">추가</button>
							<button class="btn small outline-green" id="reset-group-btn" style="margin-left: 10px; height: 48px;"><i class="fi fi-rr-rotate-right"></i> 초기화</button>
							<div class="modal-body">
								<div id="group-list-div"></div>
							</div>
							<div class="modal-footer">
								<button class="btn right outline-green" id="close-group">닫기</button>
							</div>
						</div>
					</div>
					<!-- 자산 그룹 수정 모달 -->
					<div class="modal" id="up-group-modal" hidden="true">
						<div class="modal-content small">
							<div class="modal-title">
								<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산그룹 수정</h3>
							</div>
							<hr>
							<div class="modal-body small">
								<h5 class='h-normal fs-20'><i class="fi fi-rr-pencil"></i> 자산 그룹명</h5>
								<div id='up-group-check'>
									<p class='msg info'>그룹명은 1~20 글자 입력</p>
								</div>
								<br>
								<div id="up-group-div">
									<input class="input" id="up-group-name" maxlength="20">
									<br><br>
									<button class="btn medium green" id="up-group-btn">수정</button>
								</div>
								<br>
								<div><p class="msg warning">* 변경 시 관련된 자산의 자산 그룹 이름도 함께 변경됩니다 *</p></div>
							</div>
							<hr>
							<div class="modal-footer">
								<button class="btn right outline-green" id="close-up-group">닫기</button>
							</div>
						</div>
					</div>
					<!-- 자산 그룹 추가 모달 -->
					<div class="modal" id="add-group-modal" hidden="true">
						<div class="modal-content small">
							<div class="modal-title">
								<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산그룹 추가</h3>
							</div>
							<hr>
							<div class="modal-body small">
								<div id="add-group-div">
									<h5 class='h-normal fs-20'><i class="fi fi-rr-pencil"></i> 자산 그룹명</h5>
									<div id="add-group-check">
										<p class='msg info'>그룹명은 1~20 글자 입력</p>
									</div>
									<br>
									<input type="text" class="input" id="astgroup" maxlength="20">
									<br><br>
									<button class="btn medium green" id="add-group-btn">추가</button>
									<br><br>
									<div><p class="msg warning">* 중복되는 그룹명은 추가하실 수 없습니다 *</p></div>
								</div>
							</div>
							<hr>
							<div class="modal-footer">
								<button class="btn right outline-green" id="close-add-group">닫기</button>
							</div>
						</div>
					</div>
					<!-- 이체 모달 -->
					<div class="modal" id="add-transfer-modal" hidden="true">
						<div class="modal-content">
							<div class="modal-title">
								<h3 class="h-normal fs-28"><i class="fi fi-rr-exchange"></i> 이체</h3>
							</div>
							<hr>
							<div class="modal-body">
								<table class="table">
									<tr>
										<td>날짜</td>
										<td><input class="input" type="date" id="add-transfer-date"></td>
									</tr>
									<tr>
										<td>출금</td>
										<td><input class="input" type="text" id="add-withdraw-asset" placeholder="자산선택" readonly></td>
									</tr>
									<tr>
										<td>입금</td>
										<td><input class="input" type="text" id="add-deposit-asset" placeholder="자산선택" readonly></td>
									</tr>
									<tr>
										<td>금액</td>
										<td><input class="input" type="text" id="add-transfer-total"></td>
									</tr>
									<tr>
										<td>메모</td>
										<td><textarea rows="5" class="input" id="add-transfer-memo" maxlength="100"></textarea></td>
									</tr>
								</table>
								<button class="btn medium green" id="add-transfer-btn">추가</button>
							</div>
							<hr>
							<div class="modal-footer">
								<button class="btn right outline-green" id="close-add-transfer">닫기</button>
							</div>
						</div>
					</div>
					<!-- 이체 수정 모달 -->
					<div class="modal" id="up-transfer-modal" hidden="true">
						<div class="modal-content">
							<div class="modal-title">
								<h3 class="h-normal fs-28"><i class="fi fi-rr-exchange"></i> 이체</h3>
							</div>
							<hr>
							<div class="modal-body">
								<table class="table">
									<tr>
										<td colspan="2" hidden><input class="input" type="text" id="up-transfer-id"></td>
									</tr>
									<tr>
										<td>날짜</td>
										<td><input class="input" type="date" id="up-transfer-date"></td>
									</tr>
									<tr>
										<td>출금</td>
										<td><input class="input" type="text" id="up-withdraw-asset" placeholder="자산선택" disabled="disabled"></td>
									</tr>
									<tr>
										<td>입금</td>
										<td><input class="input" type="text" id="up-deposit-asset" placeholder="자산선택" disabled="disabled"></td>
									</tr>
									<tr>
										<td>금액</td>
										<td><input class="input" type="text" id="up-transfer-total"></td>
									</tr>
									<tr>
										<td>메모</td>
										<td><textarea rows="5" class="input" id="up-transfer-memo" maxlength="100"></textarea></td>
									</tr>
								</table>
								<button class="btn medium green" id="up-transfer-btn">수정</button>
								<button class="btn small outline-green" id="del-transfer-btn" style="height: 48px;">삭제</button>
							</div>
							<hr>
							<div class="modal-footer">
								<button class="btn right outline-green" id="close-up-transfer">닫기</button>
							</div>
						</div>
					</div>
					
					<!-- 자산 선택 모달 -->
					<div class="modal" id="select-asset-modal" hidden="true">
						<div class="modal-content">
							<div class="modal-title">
								<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산</h3>
							</div>
							<hr>
							<div class="modal-body">
								<div id="select-asset-div">
								</div>
							</div>
							<hr>
							<div class="modal-footer">
								<button class="btn right outline-green" id="close-select-asset">닫기</button>
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