<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 수입/지출 관리</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-solid-rounded/css/uicons-solid-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main-style.css">
<link rel="stylesheet" type="text/css" href="../resources/css/account/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/account/account.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
</script>
</head>
<body>
	<div>
		<jsp:include page="../main/header.jsp"></jsp:include>
		<jsp:include page="../main/sidebar.jsp"></jsp:include>

		<!-- 컨텐츠 -->
		<div class="container account">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
			<div>
				<h2 class="title-text"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 내역</h2>
				<!-- 검색 -->
				<div id="search-div">
					<div><input id="search-input" type="text"></div>
					<div id="search-btn"><i class="fi fi-rr-search"></i></div>
				</div>			
				<div id="search-list"></div>
				
				<div id="div1">
					<table>
						<tr>
							<td>
								<i class="fi fi-rr-angle-left angle-icon" id="last-month"></i>
							</td>
							<td>
								<!-- 날짜 -->
								<div id="date-div">
									<div id="month"></div>
									<div id="year"></div>
								</div>
								
								<!-- 날짜 선택 div -->
								<div class="is-border" id="select-date">
									<table>
										<tr>
											<td id="last-year"><i class="fi fi-rr-angle-left"></i></td>
											<td colspan="2">
												<div id="select-year"></div>
											</td>
											<td id="next-year"><i class="fi fi-rr-angle-right"></i></td>
										</tr>
										<tr class="select-month">
											<td>1월</td>
											<td>2월</td>
											<td>3월</td>
											<td>4월</td>
										</tr>
										<tr class="select-month">
											<td>5월</td>
											<td>6월</td>
											<td>7월</td>
											<td>8월</td>
										</tr>
										<tr class="select-month">
											<td>9월</td>
											<td>10월</td>
											<td>11월</td>
											<td>12월</td>
										</tr>
									</table>
								</div>
							</td>
							<td>
								<i class="fi fi-rr-angle-right angle-icon" id="next-month"></i>
							</td>
						</tr>
					</table>
				</div> 
				<br><br>
				<!-- 수입/지출 추가 -->
				<div id="div2">
					<table>
						<tr>
							<td>
								<div class="switch spend">
									<input type="checkbox" name="add-moneytype" id="add-moneytype"><label for="add-moneytype">지출</label>
								</div>
							</td>
							<td class="input-inner"><input type="date" id="add-date" placeholder="일자"></td>
							<td class="input-inner">
								<input type="text" id="add-asset" placeholder="자산" readonly="readonly">
								<div class="select-add-asset select-div">
									<div id="add-asset-list"></div>
								</div>
							</td>
							<td class="input-inner">
								<input type="text" id="add-bigcate" placeholder="분류" readonly="readonly">
								<div class="select-add-incate select-div">
									<table class="select-table">
										<tr><td>소득</td></tr>
										<tr><td>저축</td></tr>
										<tr><td>기타</td></tr>
									</table>
								</div>
								<div class="select-add-outcate select-div">
									<table class="select-table">
										<tr>
											<td>식비</td>
											<td>마트/편의점</td>
											<td>생활용품</td>
										</tr>
										<tr>
											<td>문화/여가</td>
											<td>주거/통신</td>
											<td>교통/차량</td>
										</tr>
										<tr>
											<td>패션/뷰티</td>
											<td>의료/건강</td>
											<td>선물/경조사</td>
										</tr>
										<tr>
											<td>공과금</td>
											<td>교육</td>
											<td>기타</td>
										</tr>
									</table>
								</div>
								<input type="text" id="add-smallcate" placeholder="소분류" disabled="disabled" readonly="readonly">
								<div class="select-add-smallcate select-div"></div>
							</td>
							<td class="input-inner"><input type="text" id="add-content" placeholder="내용"></td>
							<td class="input-inner"><input type="text" id="add-total" placeholder="금액"></td>
							<td><button class="btn main-color-btn" id="add-account-btn">+</button></td>
						</tr>
					</table>
				</div>
			</div>
			<br>

			<!-- 합계 -->
			<div id="div3">
				<table>
					<tr>
						<td>
							<div class="show-range active" id="show-all"><i class="fi fi-rs-check"></i></div>
							<div id="total-div"><h4>합계</h4><i></i></div>
						</td>
						<td>
							<div class="show-range" id="show-income"><i class="fi fi-rs-check"></i></div>
							<div id="income-div"><h4>총 수입</h4><i></i></div>
						</td>
						<td>
							<div class="show-range" id="show-spend"><i class="fi fi-rs-check"></i></div>
							<div id="spend-div"><h4>총 지출</h4><i></i></div>
						</td>
					</tr>
				</table>
			</div>
			
			<!-- right -->
			<div class="is-border" style="width: 280px; height: 300px; position: absolute; right: 2%;">
				<div></div>
			</div>
	
			<!-- 미니 달력 -->
			<div id="left-div1">
				<div id="mini-date-div"></div>
			</div>

			<!-- 수입/지출 내역 -->
			<div id="div4">
				<div id="account-list-div"></div>
			</div>
			
			<!-- 수입/지출 수정 modal -->
			<div class="modal" id="update-account-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs28">수입/지출 수정</h3>
						<button class="x-btn" id="close-update-account">x</button>
					</div>
					<div class="modal-body">
						<table class="table">
							<tr class="hide">
								<th>ID</th>
								<td><input type="text" class="input" id="update-id" ></td>
							</tr>
							<tr>
								<td colspan="2">
									<div class="select">
										<input class="" type="radio" name="update-mtype" id="update-in" value="수입"><label for="update-in">수입</label>
										<input class="" type="radio" name="update-mtype" id="update-out" value="지출"><label for="update-out">지출</label>
									</div>
								</td>
							</tr>
							<tr>
								<th>날짜</th>
								<td><input type="date" class="input" id="update-date" ></td>
							</tr>
							<tr>
								<td colspan="2" class="hide">
									<input id="update-assetid">
								</td>
							</tr>
							<tr>
								<th>자산</th>
								<td>
									<input type="text" class="input" id="update-asset" placeholder="분류선택" readonly>
									<div class="select-update-asset select-div">
										<div id="update-asset-list"></div>
									</div>
								</td>
							</tr>
							<tr>
								<th>대분류</th>
								<td>
									<input type="text" class="input" id="update-bigcate" placeholder="분류선택" readonly>
									<div class="select-update-incate select-div" >
										<table class="select-table">
											<tr><td>소득</td></tr>
											<tr><td>저축</td></tr>
											<tr><td>기타</td></tr>
										</table>
									</div>
									<div class="select-update-outcate select-div">
										<table class="select-table">
											<tr>
												<td>식비</td>
												<td>마트/편의점</td>
												<td>생활용품</td>
											</tr>
											<tr>
												<td>문화/여가</td>
												<td>주거/통신</td>
												<td>교통/차량</td>
											</tr>
											<tr>
												<td>패션/뷰티</td>
												<td>의료/건강</td>
												<td>선물/경조사</td>
											</tr>
											<tr>
												<td>공과금</td>
												<td>교육</td>
												<td>기타</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
							<tr>
								<th>소분류</th>
								<td>
									<input type="text" class="input" id="update-smallcate" placeholder="분류선택" readonly>
									<div class="select-update-smallcate select-div"></div>
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td><input type="text" class="input" id="update-content" maxlength="20"></td>
							</tr>
							<tr>
								<th>금액</th>
								<td><input type="text" class="input" id="update-total"></td>
							</tr>
						</table>
						<button class="btn main-color-btn" id="update-account-btn">수정</button>
						<button class="btn main-outline-btn" id="delete-account-btn">삭제</button>
					</div>
					<div class="modal-footer">
						<button class="btn right main-outline-btn" id="close-update-account">닫기</button>
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