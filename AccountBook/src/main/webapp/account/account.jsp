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
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="../resources/js/account/account.js"></script>
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
				<li class="menu active"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 관리</li>		
				<li class="menu"><i class="fi fi-rr-coins"></i> 자산관리</li>		
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
				<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 관리</h3>
				<div class="fix-col5-left-br">
					<button class="btn medium green font-18 is-shadow" id="add-account-page"><i class="fi fi-rr-add"></i> 추가</button>
					<button class="btn small outline-green font-18 is-shadow" id="bookmark-page"><i class="fi fi-rr-star"></i> 즐겨찾기</button>
				</div>
				<div class="fix-right-tr-1">
					<button class="btn green font-18 is-shadow" id="open-cate-setting" style="width: 60px;"><i class="fi fi-rr-menu-burger"></i></button>
				</div>
				<div class="fix-right-tr-2" id="cate-setting" hidden>
					<button class="btn small outline-green font-18 is-shadow" id="in-category-btn">수입 분류</button>
					<br>
					<button class="btn small outline-green font-18 is-shadow" id="out-category-btn">지출 분류</button>
				</div>
				
				<!-- 날짜 보여주기 -->
				<div style="margin-left: 37%; margin-bottom: 3%;">
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
				<!-- 월별 수입/지출 내역 -->
				<div>
					<div class="col-5">
						<!-- 전체, 수입, 지출 선택 -->
						<div>
							<table class="select-table">
								<tr>
									<td class="active" id="total-account-btn">전체</td>
									<td class="" id="in-account-btn">수입</td>
									<td class="" id="out-account-btn">지출</td>
								</tr>
							</table>
						</div>
						<br>
						<!-- 총 금액 -->
						<div>
							<table style="width: 500px; margin-left: 6%; text-align: center;">
								<tr>
									<td><div id="total-div">합계</div></td>
									<td><div id="total-income-div">총 수입</div></td>
									<td><div id="total-spend-div">총 지출</div></td>
								</tr>
							</table>
						</div>
						<br>
						<div class="is-scroll" id="month-account-list-div" style="margin-left: 2%;"></div>
					</div>
					<div class="col-5">
						<h4 class="h-normal fs-23">지출 통계</h4> <br>
						<div id="piechart" style="width: 800px; height: 400px;"></div>
						<div id="category-stats-div"></div>
					</div>			
				</div>
				
				<!-- 수입 카테고리 모달 -->
				<div class="modal" id="in-category-modal" hidden="true">
					<div class="modal-content">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 수입 카테고리 관리</h3>
						</div>
						<button class="btn medium green" id="add-in-category-page" style="margin-left: 10px;"><i class="fi fi-rr-add"></i> 추가</button>
						<button class="btn small outline-green" id="reset-incate-btn" style="margin-left: 10px; height: 48px;"><i class="fi fi-rr-rotate-right"></i> 초기화</button>
						<div class="modal-body">
							<div id="in-category-list-div"></div>
						</div>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-in-category">닫기</button>
						</div>
					</div>
				</div>
				<!-- 지출 카테고리 모달 -->
				<div class="modal" id="out-category-modal" hidden="true">
					<div class="modal-content">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 지출 카테고리 관리</h3>
						</div>
						<button class="btn medium green" id="add-out-category-page" style="margin-left: 10px;"><i class="fi fi-rr-add"></i> 추가</button>
						<button class="btn small outline-green" id="reset-outcate-btn" style="margin-left: 10px; height: 48px;"><i class="fi fi-rr-rotate-right"></i> 초기화</button>
						<div class="modal-body">
							<div id="out-category-list-div"></div>
						</div>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-out-category">닫기</button>
						</div>
					</div>
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
				
				<!-- 카테고리 추가 모달 -->
				<div class="modal" id="add-category-modal" hidden="true">
					<div class="modal-content small">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 카테고리 추가</h3>
						</div>
						<hr>
						<div class="modal-body small">
							<h5 class='h-normal fs-20'><i class="fi fi-rr-pencil"></i> 카테고리명</h5>
							<div id="add-category-div">
								<table class='table'>
									<tr>
										<th>분류</th>
										<td><input type="text" class="input" id='moneytype' readonly></td>
									</tr>
									<tr>
										<th>이름</th>
										<td><input type="text" class="input" id='catename'></td>
									</tr>
								</table>
								<div id="add-catename-check-div">
									<p class="msg info">이름은 특수문자 제외, 한 글자 이상 입력 ( /는 사용 가능)</p>
								</div>
								<br>
								<button class="btn medium green" id="add-category-btn">추가</button>
							</div>
						</div>
						<hr>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-add-category">닫기</button>
						</div>
					</div>
				</div>
				<!-- 수입/지출 선택 모달 -->
				<div class="modal" id="select-moneytype-modal" hidden="true">
					<div class="modal-content small">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 분류</h3>
						</div>
						<hr>
						<div class="modal-body small">
							<div id="select-moneytype-div">
								<table class='table'>
									<tr>
										<td class='group-list is-border' id="in">수입</td>
									</tr>
									<tr>
										<td class='group-list is-border' id="out">지출</td>
									</tr>
								</table>
							</div>
						</div>
						<hr>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-select-moneytype">닫기</button>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 수입/지출 추가 모달 -->
			<div class="modal" id="add-account-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 추가</h3>
					</div>
					<hr>
					<div class="modal-body">
						<div id="add-account-div">
							<table class='table'>
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
									<td><input type="date" class="input" id="add-actdate" ></td>
								</tr>
								<tr>
									<td>자산</td>
									<td><input type="text" class="input" id="add-actasset" placeholder="자산선택" readonly></td>
								</tr>
								<tr>
									<td>분류</td>
									<td><input type="text" class="input" id="add-actcatename" placeholder="분류선택" readonly></td>
								</tr>
								<tr>
									<td>금액</td>
									<td><input type="text" class="input" id="add-acttotal"></td>
								</tr>
								<tr>
									<td>내용</td>
									<td><input type="text" class="input" id="add-actcontent" maxlength="20"></td>
								</tr>
								<tr>
									<td>메모</td>
									<td>
										<textarea rows="3" class="input" id="add-actmemo" maxlength="100"></textarea>
									</td>
								</tr>
							</table>
							<button class="btn medium green" id="add-account-btn">추가</button>
						</div>
					</div>
					<hr>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-add-account">닫기</button>
					</div>
				</div>
			</div>
			<!-- 카테고리별 지출 모달 -->
			<div class="modal" id="catespend-modal" hidden="true">
				<div class="modal-content wide">
					<div class="modal-title">
						<h3 class="h-normal fs-28" id="catename-div"><i class="fi fi-rr-money-check-edit"></i> 카테고리별 지출</h3>
					</div>
					<div class="modal-body wide">
						<div id="catespend-total-div"></div>
						<div id="catespend-list-div"></div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-catespend">닫기</button>
					</div>
				</div>
			</div>
			<!-- 수입/지출 수정 모달 -->
			<div class="modal" id="up-account-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 수정</h3>
					</div>
					<hr>
					<div class="modal-body">
						<div id="up-account-div">
							<table class='table'>
								<tr hidden="true">
									<td>ID</td>
									<td><input type="text" class="input" id="up-actid" ></td>
								</tr>
								<tr>
									<td colspan="2">
										<div class="select">
											<input type="radio" name="up-mtype" id="up-in" value="수입"><label for="up-in">수입</label>
											<input type="radio" name="up-mtype" id="up-out" value="지출"><label for="up-out">지출</label>
										</div>
									</td>
								</tr>
								<tr>
									<td>날짜</td>
									<td><input type="date" class="input" id="up-actdate" ></td>
								</tr>
								<tr>
									<td>자산</td>
									<td><input type="text" class="input" id="up-actasset" readonly></td>
								</tr>
								<tr>
									<td>분류</td>
									<td><input type="text" class="input" id="up-actcatename" readonly></td>
								</tr>
								<tr>
									<td>금액</td>
									<td><input type="text" class="input" id="up-acttotal"></td>
								</tr>
								<tr>
									<td>내용</td>
									<td><input type="text" class="input" id="up-actcontent" maxlength="20"></td>
								</tr>
								<tr>
									<td>메모</td>
									<td>
										<textarea rows="3" class="input" id="up-actmemo" maxlength="100"></textarea>
									</td>
								</tr>
							</table>
							<button class="btn medium green" id="up-account-btn">수정</button>
							<button class="btn outline-green" style="height: 48px;" id="del-account-btn">삭제</button>
						</div>
					</div>
					<hr>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-up-account">닫기</button>
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
						<div id="asset-list-div">
						</div>
					</div>
					<hr>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-select-asset">닫기</button>
					</div>
				</div>
			</div>
			<!-- 수입 카테고리 선택 모달 -->
			<div class="modal" id="select-incate-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 수입 카테고리</h3>
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
						<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 지출 카테고리</h3>
					</div>
					<div class="modal-body">
						<div id="select-outcate-list-div"></div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-select-outcate">닫기</button>
					</div>
				</div>
			</div>
			<!-- 즐겨찾기 목록 모달 -->
			<div class="modal" id="bookmark-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-star"></i> 즐겨찾기</h3>
					</div>
					<button class="btn medium green" id="add-bookmark-page" style="margin-left: 10px;">추가</button>
					<div class="modal-body">
						<div id="bookmark-list-div">
							
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-bookmark">닫기</button>
					</div>
				</div>
			</div>
			<!-- 즐겨찾기 추가 모달 -->
			<div class="modal" id="add-bookmark-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 즐겨찾기 추가</h3>
					</div>
					<div class="modal-body">
						<div id="add-bookmark-list-div">
							
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-add-bookmark">닫기</button>
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