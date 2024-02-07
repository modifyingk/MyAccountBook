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
<link rel="stylesheet" type="text/css" href="../resources/css/table.css">
<link rel="stylesheet" type="text/css" href="../resources/css/account.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/account/account.js"></script>
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
				<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 관리</h3>
				<button class="btn outline-green" id="open-add-account">+</button>
				<a href="category.jsp"><button class="btn outline-green" id="category-btn">카테고리 관리</button></a>
				<button class="btn outline-green" id="repeat-btn">반복 관리</button>
			<!--	<div class="fix-col5-left-br">
					<button class="btn medium green font-18 is-shadow" id="add-account-page"><i class="fi fi-rr-add"></i> 추가</button>
				  	<button class="btn small outline-green font-18 is-shadow" id="bookmark-page"><i class="fi fi-rr-star"></i> 즐겨찾기</button>
					<button class="btn small outline-green font-18 is-shadow" id="repeat-page"><i class="fi fi-rr-arrows-repeat"></i> 반복</button>
					</div>
			<!--	<div class="fix-right-tr-4">
					<button class="btn outline-green font-18 is-shadow" id="open-search" style="width: 60px;"><i class="fi fi-rr-search"></i></button>
					</div>
					<div class="fix-right-tr-3">
					<button class="btn outline-green font-18 is-shadow" id="open-graph" style="width: 60px;"><i class="fi fi-rr-stats"></i></button>
					</div>
					<div class="fix-right-tr-1">
					<button class="btn green font-18 is-shadow" id="open-cate-setting" style="width: 60px;"><i class="fi fi-rr-menu-burger"></i></button>
					</div> 
					<div class="fix-right-tr-2" id="cate-setting" hidden>
					<button class="btn small outline-green font-18 is-shadow" id="in-category-btn">수입 분류</button>
					<br>
					<button class="btn small outline-green font-18 is-shadow" id="out-category-btn">지출 분류</button>
					</div>
-->
				<!-- 날짜 보여주기 -->
				<div style="margin-bottom: 3%; width: 50%;">
					<table class="is-center" style="width: 100%;">
						<tr>
							<td>
								<i class="fi fi-rr-angle-circle-left fs-28 click-icon" id="before"></i>
							</td>
							<td style="width: 500px;" class="text-center">
								<div id="month-div" style="margin: 10px; cursor: pointer;"></div>
								
								<!-- 날짜 선택 div -->
								<div class="is-border" id="select-month" style="z-index: 2; position: absolute; background: white; display: none;">
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
							<td>
								<i class="fi fi-rr-angle-circle-right fs-28 click-icon" id="after"></i>
							</td>
						</tr>
					</table>
				</div>
				
				<div>
					<!-- 월별 수입/지출 내역 -->
					<div class="col-5">
						<!-- 전체, 수입, 지출 선택 -->
						<div style="margin-left: 10%;">
							<table class="button-table">
								<tr>
									<td class="active" id="total-account-btn">전체</td>
									<td class="" id="in-account-btn">수입</td>
									<td class="" id="out-account-btn">지출</td>
								</tr>
							</table>
						</div>
						<br>
						<!-- 총 금액 -->
						<div style="margin-left: 10%;">
							<table style="width: 500px; margin-left: 6%; text-align: center;">
								<tr>
									<td style="width: 30%;">
										<div id="total-div"><h4 class='h-normal fs-18 info'>합계</h4><i class='h-normal fs-20'></i></div>
									</td>
									<td style="width: 30%;">
										<div id="income-div"><h4 class='h-normal fs-18 info'>총 수입</h4><i class='blue h-normal fs-20'></i></div>
									</td>
									<td style="width: 30%;">
										<div id="spend-div"><h4 class='h-normal fs-18 info'>총 지출</h4><i class='red h-normal fs-20'></i></div>
									</td>
								</tr>
							</table>
						</div>
						<br>
						<!-- 내역 -->
						<div class="is-scroll" id="month-account-list-div" style="margin-left: 10%;"></div>
					</div>
					
					<div class="col-5">
						<div id="">
							
						</div>
						<button class="btn green" id="category-stats-btn">카테고리 통계</button>
						<button class="btn green" id="asset-stats-btn">자산 통계</button>
						
						<!-- 수입/지출 추가 -->					
						<div id="add-account-div" class="add-div is-border is-shadow hide">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 추가</h3>
							<button class="x-btn" id="close-add-account">x</button>
							<table class='table'>
								<tr>
									<td colspan="2">
										<div class="select">
											<input type="radio" name="select-mtype" id="select-in" value="수입"><label for="select-in">수입</label>
											<input type="radio" name="select-mtype" id="select-out" value="지출" checked><label for="select-out">지출</label>
										</div>
										<div class="select-repeat">
											<input type="radio" name="add-repeat" id="add-repeat" value="없음"><label for="add-repeat"><i class="fi fi-rr-arrows-repeat"></i></label>
											<div class="input hide" id="select-repeat-div" style="position:absolute; background: white; width:200px; height:210px;">
												<table class="select-table tr-hover td-border">
													<tr><td class="td-repeat-option">없음</td></tr>
												<!-- <tr><td class="td-repeat-option">매주</td></tr>  -->
													<tr><td class="td-repeat-option">매월</td></tr>
													<tr><td class="td-repeat-option">매년</td></tr>
												</table>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th>날짜</th>
									<td><input type="date" class="input" id="add-date"></td>
								</tr>
								<tr>
									<td colspan="2" class="hide">
										<input id="add-assetid">
									</td>
								</tr>
								<tr>
									<th>자산</th>
									<td>
										<input type="text" class="input" id="add-asset" placeholder="자산선택" readonly>
										<div class="input is-scroll select-asset-div" style="position:absolute; display: none; background: white; height:400px;">
											<div class="select-asset-list"></div>
										</div>
									</td>
								</tr>
								<tr>
									<th>분류</th>
									<td>
										<input type="text" class="input" id="add-category" placeholder="분류선택" readonly>
										<div class="input is-scroll select-category-div" style="position:absolute; display: none; background: white; height:400px;">
											<div class="select-category-list"></div>
										</div>
									</td>
								</tr>
								<tr>
									<th>금액</th>
									<td><input type="text" class="input" id="add-total"></td>
								</tr>
								<tr>
									<th>내용</th>
									<td><input type="text" class="input" id="add-content" maxlength="20"></td>
								</tr>
								<tr>
									<th>메모</th>
									<td>
										<textarea rows="3" class="input" id="add-memo" maxlength="100"></textarea>
									</td>
								</tr>
							</table>
							<button class="btn medium green" id="add-account-btn">추가</button>
						</div>
						
						<!-- 수입/지출 수정 -->
						<div id="update-account-div" class="add-div is-border is-shadow hide">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 수정</h3>
							<button class="x-btn" id="close-update-account">x</button>
							<table class='table'>
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
										<div class="input is-scroll select-asset-div" style="position:absolute; display: none; background: white; height:400px;">
											<div class="select-asset-list"></div>
										</div>
									</td>
								</tr>
								<tr>
									<th>분류</th>
									<td>
										<input type="text" class="input" id="update-category" placeholder="분류선택" readonly>
										<div class="input is-scroll select-category-div" style="position:absolute; display: none; background: white; height:400px;">
											<div class="select-category-list"></div>
										</div>
									</td>
									
								</tr>
								<tr>
									<th>금액</th>
									<td><input type="text" class="input" id="update-total"></td>
								</tr>
								<tr>
									<th>내용</th>
									<td><input type="text" class="input" id="update-content" maxlength="20"></td>
								</tr>
								<tr>
									<th>메모</th>
									<td>
										<textarea rows="3" class="input" id="upate-memo" maxlength="100"></textarea>
									</td>
								</tr>
							</table>
							<button class="btn medium green" id="update-account-btn">수정</button>
							<button class="btn medium outline-green" id="delete-account-btn">삭제</button>
						</div>
						
						<!-- 반복 내역 -->
						<div id="repeat-list-div" class="add-div is-border is-shadow hide">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-money-check-edit"></i> 반복 내역</h3>
							<button class="x-btn" id="close-repeat-list">x</button>
							<div id="repeat-list"></div>
						</div>
					</div>
				</div>
			</div>	
				
				<!-- 카테고리별 수입/지출 모달 
				<div class="modal" id="catespend-modal" hidden="true">
					<div class="modal-content wide">
						<div class="modal-title">
							<h3 class="h-normal fs-28" id="catename-div"><i class="fi fi-rr-money-check-edit"></i> 카테고리별 내역</h3>
						</div>
						<div class="modal-body wide">
							<div id="cateaccount-total-div"></div>
							<div id="cateaccount-list-div"></div>
						</div>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-catespend">닫기</button>
						</div>
					</div>
				</div>
			
				검색 모달
				<div class="modal" id="search-modal" hidden="true">
					<div class="modal-content wide">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-search"></i> 검색</h3>
							<input class="input" style="margin-left: 10px; width: 510px;" id="search-input">
							<div class="input" id="autosearch-div" style="position:absolute; margin-left: 10px; display: none; background: white; width: 510px;">
								<div id="autosearch-list-div"></div>
							</div>
							<button class="btn green font-18" style="width: 100px; height: 45px;" id="search-btn"><i class="fi fi-rr-search"></i></button>
						</div>
						<div class="modal-body wide">
							<div>
								<table style="width: 500px; margin-left: 6%; text-align: center;">
									<tr>
										<td><div id="search-total-div"></div></td>
										<td><div id="search-income-div"></div></td>
										<td><div id="search-spend-div"></div></td>
									</tr>
								</table>
							</div>
							<br>
							<div id="search-list-div"></div>
						</div>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-search">닫기</button>
						</div>
					</div>
				</div>
				
				-->
				
				
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
						<h3 class="h-normal fs-28"><i class="fi fi-rr-star"></i> 즐겨찾기 추가</h3>
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
			
			<!-- 반복 목록 모달 -->
			<div class="modal" id="repeat-modal" hidden="true">
				<div class="modal-content wide">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-arrows-repeat"></i> 반복</h3>
					</div>
					<button class="btn medium green" id="add-repeat-page" style="margin-left: 10px;">추가</button>
					<div class="modal-body wide">
						<div id="repeat-list-div">
							
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-repeat">닫기</button>
					</div>
				</div>
			</div>
			
			<!-- 반복 추가 모달 -->
			<div class="modal" id="add-repeat-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-arrows-repeat"></i> 반복 추가</h3>
					</div>
					<div class="modal-body">
						<h5 class="h-normal fs-20"><i class="fi fi-rr-calendar-clock"></i> 반복 주기</h5>
						<table>
							<tr>
								<td>
									<select class="input small" id="repeat-option">
										<option value="매월">매월</option>
										<option value="매년">매년</option>
										<option value="매주">매주</option>
										<option value="매일">매일</option>
									</select>
								</td>
								<td>
									<!-- 매년 -->
									<div id="every-year-div" hidden="true">
										<select class="input tiny" id="every-year-month">
											<option>월</option>
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
										<input class="input tiny" placeholder="일" id="every-year-date">
									</div>
								
									<!-- 매월 -->
									<div id="every-month-div">
										<input class="input small" placeholder="일" id="every-month-date">
									</div>
									
									<!-- 매주 -->
									<div id="every-week-div" hidden="true">
										<select class="input small" id="every-week-day">
											<option>요일</option>
											<option value="월">월</option>
											<option value="화">화</option>
											<option value="수">수</option>
											<option value="목">목</option>
											<option value="금">금</option>
											<option value="토">토</option>
											<option value="일">일</option>
										</select>
									</div>
								</td>
							</tr>				
						</table>
						<br>
						<hr style="border: 1px solid lightgray;">
						<div>
							<div class="col-5">
								<h5 class="h-normal fs-20"><i class="fi fi-rr-money-check-edit"></i> 반복 내역</h5>
							</div>
							<div class="col-5">
								<button class="btn small outline-green right" style="width: 50px;" id="add-repeat-list-btn"><i class="fi fi-rr-search-alt fs-20"></i></button>
							</div>
						</div>
						<table class="table">
							<tr>
								<td colspan="2">
									<div class="select">
										<input type="radio" name="rep-mtype" id="rep-select-in" value="수입"><label for="rep-select-in">수입</label>
										<input type="radio" name="rep-mtype" id="rep-select-out" value="지출" checked><label for="rep-select-out">지출</label>
									</div>
								</td>
							</tr>
							<tr>
								<td>자산</td>
								<td><input type="text" class="input" id="rep-actasset" placeholder="자산선택" readonly></td>
							</tr>
							<tr>
								<td>분류</td>
								<td><input type="text" class="input" id="rep-actcatename" placeholder="분류선택" readonly></td>
							</tr>
							<tr>
								<td>금액</td>
								<td><input type="text" class="input" id="rep-acttotal"></td>
							</tr>
							<tr>
								<td>내용</td>
								<td><input type="text" class="input" id="rep-actcontent" maxlength="20"></td>
							</tr>
						</table>
						<button class="btn medium green" id="add-repeat-btn">추가</button>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-add-repeat">닫기</button>
					</div>
				</div>
			</div>
			
			<!-- 반복 수정 모달 -->
			<div class="modal" id="up-repeat-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-arrows-repeat"></i> 반복 수정</h3>
					</div>
					<div class="modal-body">
					<h5 class="h-normal fs-20"><i class="fi fi-rr-calendar-clock"></i> 반복 주기</h5>
						<table>
							<tr>
								<td>
									<select class="input small" id="up-repeat-option">
										<option value="매월">매월</option>
										<option value="매년">매년</option>
										<option value="매주">매주</option>
										<option value="매일">매일</option>
									</select>
								</td>
								<td>
									<!-- 매년 -->
									<div id="up-every-year-div" hidden="true">
										<select class="input tiny" id="up-every-year-month">
											<option>월</option>
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
										<input class="input tiny" placeholder="일" id="up-every-year-date">
									</div>
								
									<!-- 매월 -->
									<div id="up-every-month-div">
										<input class="input small" placeholder="일" id="up-every-month-date">
									</div>
									
									<!-- 매주 -->
									<div id="up-every-week-div" hidden="true">
										<select class="input small" id="up-every-week-day">
											<option>요일</option>
											<option value="월">월</option>
											<option value="화">화</option>
											<option value="수">수</option>
											<option value="목">목</option>
											<option value="금">금</option>
											<option value="토">토</option>
											<option value="일">일</option>
										</select>
									</div>
								</td>
							</tr>				
						</table>
						<br>
						<hr style="border: 1px solid lightgray;">
						<div>
							<div class="col-5">
								<h5 class="h-normal fs-20"><i class="fi fi-rr-money-check-edit"></i> 반복 내역</h5>
							</div>
							<div class="col-5">
								<button class="btn small outline-green right" style="width: 50px;" id="add-repeat-list-btn"><i class="fi fi-rr-search-alt fs-20"></i></button>
							</div>
						</div>
						<table class="table">
							<tr>
								<td colspan="2">
									<div class="select">
										<input type="radio" name="up-rep-mtype" id="up-rep-select-in" value="수입"><label for="up-rep-select-in">수입</label>
										<input type="radio" name="up-rep-mtype" id="up-rep-select-out" value="지출" checked><label for="up-rep-select-out">지출</label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2" style="display: none;"><input type="text" class="input" id="up-repeatid"></td>
							</tr>
							<tr>
								<td>자산</td>
								<td><input type="text" class="input" id="up-rep-actasset" placeholder="자산선택" readonly></td>
							</tr>
							<tr>
								<td>분류</td>
								<td><input type="text" class="input" id="up-rep-actcatename" placeholder="분류선택" readonly></td>
							</tr>
							<tr>
								<td>금액</td>
								<td><input type="text" class="input" id="up-rep-acttotal"></td>
							</tr>
							<tr>
								<td>내용</td>
								<td><input type="text" class="input" id="up-rep-actcontent" maxlength="20"></td>
							</tr>
						</table>
						<button class="btn medium green" id="up-repeat-btn">수정</button>
						<button class="btn small outline-green" id="del-repeat-btn" style="height: 48px;">삭제</button>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-up-repeat">닫기</button>
					</div>
				</div>
			</div>
			
			<!-- 반복할 내역 찾기 모달 -->
			<div class="modal" id="add-repeat-list-modal" hidden="true">
				<div class="modal-content">
					<div class="modal-title">
						<h3 class="h-normal fs-28"><i class="fi fi-rr-arrows-repeat"></i> 반복 추가</h3>
					</div>
					<div class="modal-body">
						<div id="add-repeat-list-div"></div>
					</div>
					<div class="modal-footer">
						<button class="btn right outline-green" id="close-add-repeat-list">닫기</button>
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