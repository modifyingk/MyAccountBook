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
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<link rel="stylesheet" type="text/css" href="../resources/css/asset/asset.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/asset/asset.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
</script>
</head>
<body>
	<div>
		<jsp:include page="../main/header.jsp"></jsp:include>
		<jsp:include page="../main/sidebar.jsp"></jsp:include>

		<!-- 컨텐츠 -->
		<div class="container asset">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
			<div>
				<h2 class="title-text"><i class="fi fi-rr-hands-usd"></i> 자산관리</h2>
				<button id="open-add-asset">+</button>
				
				<!-- 자산 목록 -->
				<div id="div1">
					<div id="asset-list-div"></div> <!-- 목록 -->
				</div>
			</div>
			<% }
			/* 로그인이 되어 있지 않을 때 */
			else { %>
				<script>location.href = "../member/login.jsp";</script>
			<% } %>
		</div>
	</div>
		
	<!-- 자산 추가 modal -->
	<div class="modal" id="add-asset-modal" hidden="true">
		<div class="modal-content medium">
			<div class="modal-title">
				<h3 class="h-normal fs28">자산 추가</h3>
				<button class="x-btn" id="close-add-asset">x</button>
			</div>
			<div class="modal-body medium">
				<table class='table'>
					<tr>
						<th>그룹</th>
						<td>
							<input class="input" id="add-asset-group" placeholder="그룹선택" readonly>
							<div class="input is-scroll select-group-div hide" style="position:absolute; background: white; height:380px;">
								<table class="select-table td-border tr-hover" id="asset-group-table">
									<tr><td>계좌·현금</td></tr>
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
				<button class='btn main-color-btn' id='add-asset-btn'>추가</button>
			</div>
			<div class="modal-footer">
				<button class="btn right main-outline-btn" id="close-add-asset">닫기</button>
			</div>
		</div>
	</div>
				
	<!-- 자산 수정 modal -->
	<div class="modal" id="update-asset-modal" hidden="true">
		<div class="modal-content medium">
			<div class="modal-title">
				<h3 class="h-normal fs28">자산 수정</h3>
				<button class="x-btn" id="close-update-asset">x</button>
			</div>
			<div class="modal-body medium">
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
									<tr><td>계좌·현금</td></tr>
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
				<button class="btn main-color-btn" id="update-asset-btn">수정</button>
				<button class="btn main-outline-btn" id="delete-asset-btn">삭제</button>
			</div>
			<div class="modal-footer">
				<button class="btn right main-outline-btn" id="close-update-asset">닫기</button>
			</div>
		</div>
	</div>
				
	<!-- 이체 modal -->
	<div class="modal" id="add-transfer-modal" hidden="true">
		<div class="modal-content medium">
			<div class="modal-title">
				<h3 class="h-normal fs28">이체</h3>
				<button class="x-btn" id="close-add-transfer">x</button>
			</div>
			<div class="modal-body medium">
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
				<button class="btn main-color-btn" id="add-transfer-btn">추가</button>
			</div>
			<div class="modal-footer">
				<button class="btn right main-outline-btn" id="close-add-transfer">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>