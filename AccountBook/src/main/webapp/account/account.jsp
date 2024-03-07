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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/account/account.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
</script>
<style type="text/css">
	#select-date {
		position: absolute;
		background: white;
		display: none;
	}
	#date-div:hover {
		cursor: pointer;
		color: #f39c12;
	}
	#month {
		font-size: 32px;
		font-weight: bold;
	}
	#year {
		font-size: 25px;
		font-weight: bold;
	}
	.select-div {
		position:absolute;
		display: none;
		background: white;
	}
	.td-input {
		border: 1px solid lightgray;
		border-radius: 5px;
	}
	.td-input input {
		width: 200px;
		font-size: 18px;
		padding: 10px;
		border: none;
	}
	.td-input input:focus {
		outline: none;
	}
	#add-account-btn {
		width: 70px;
		height: 55px;
		font-size: 30px;
	}
	.switch {
		width:100px;
		height: 55px;
		border-radius: 5px;
		text-align: center;
		line-height: 50px;
		font-weight: bold;
		cursor: pointer;
		border: none;
		color: white;
	}
	.switch input[type=checkbox] {
		display: none;
	}
	.switch label {
		cursor: pointer;
	}
	.switch.income {
		background:  #6482B9;
		/*border: 1px solid #0C70F2;
		color: #0C70F2;*/
	}
	.switch.spend {
		background:  #F56E6E;
		/*border: 1px solid #E34234;
		color: #E34234;*/
	}
	.select-table td {
		width: 30%;
	}
	#add-smallcate {
		width: 150px;
	}
	#add-smallcate:disabled {
		background: none;
	}
	#add-bigcate {
		width: 150px;
		border-right: 1px solid lightgray;
	}
	.account-table {
		margin-left: auto;
		margin-right: auto;
		width: 55%;
		font-size: 17px;
		border-collapse: collapse;
		border-bottom: 1px solid lightgray;
		cursor: pointer ;
	}
	.tr-content:hover {
		background: #f3f3f3;	
	}
	.tr-content {
		border-top: 1px solid #f3f3f3;
	}
	.tr-date {
		border-bottom: 1px solid lightgray;
		height: 60px;
	}
	.account-table td {
		padding: 10px;
	}
	.td-category {
		width: 32%;
	}
	.td-content, .td-asset, .td-income, .td-spend {
		width: 20%;
	}
	.td-date {
		font-size: 19px;
		font-weight: bold;
		color: #464646;
	}
	.key-div {
		width: 120px;
		color:  white;
		text-align: center;
		padding: 10px;
		/* red #F56E6E blue #6482B9 yellow #f39c12*/
		border-radius: 50px;
		font-weight: bold;
		font-size: 13px;
		cursor: pointer;
		float: left;
		margin-left: 20px;
		margin-right: 20px;
	}
	.key-div.income {
		background: #6482B9;
	}
	.key-div.spend {
		background: #F56E6E;
	}
	.td-smallcate.income {
		color: #6482B9;
	}
	.td-smallcate.spend {
		color: #F56E6E;
	}
	.td-smallcate {
		padding: 10px;
		color:  #f39c12;
		font-weight: bold;
	}
	.part-income {
		float: right;
		width: 150px;
		color: #0C70F2;
		text-align: right;
	}
	.part-spend {
		float: right;
		width: 150px;
		color: #E34234;
		text-align: right;
	
	}
	.total-table {
		width: 700px;
		margin-left: auto;
		margin-right: auto;
		text-align: center;
	}
	.total-table td {
		width: 30%;
	}
	#total-div h4, #income-div h4, #spend-div h4  {
		float: left;
	}
	#total-div i, #income-div i, #spend-div i  {
		float: left;
		margin-left: 20px;
	}
	#add-account-table {
		margin-left: auto;
		margin-right: auto;
		text-align: left;
	}
	/* 내역 범위 */
	.show-range {
		width: 20px;
		height: 25px;
		margin: 5px 10px;
		border: 1px solid #f39c12;
		border-radius: 5px;
		cursor: pointer;
		float: left;
		color: white;
		font-weight: bold;
	}
	.show-range:hover {
		background: #f39c12;
		color: white;
	}
	.show-range.active {
		background: #f39c12;
		color: white;
	}
	/* 검색 */
	#search-btn {
		width: 35px;
		border-radius:10px;
		background: #f39c12;
		float: right;
		text-align: center;
		padding: 10px;
		font-weight: bold;
		color: white;
		cursor: pointer;
	}
	#search-btn:hover {
		background: #f38e12;
	}
	#search-div {
		width: 280px;
		position: absolute;
		left: 23%;	
	}
	#search-input {
		width: 200px;
		float: left;
	}
	#search-list {
		position:absolute;
		left: 23%;
		top: 35%;
		display: none;
	}
	#search-list table {
		width: 280px;
	}
	#search-list table tr:hover{
		background: #f3f3f3;
	}
</style>
</head>
<body>
	<div>
		<jsp:include page="../main/header.jsp"></jsp:include>
		<jsp:include page="../main/sidebar.jsp"></jsp:include>

		<!-- 컨텐츠 -->
		<div class="col-8">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
			<div>
				<h2 class="fs35 main-color" style="position: fixed; left: 23%; top: 100px;"><i class="fi fi-rr-money-check-edit"></i> 수입/지출 내역</h2>
				<div>
					<table style="display: flex; justify-content: center; margin-top: 50px;">
						<tr>
							<td>
								<i class="fi fi-rr-angle-left fs28 click-icon" id="before"></i>
							</td>
							<td style="width: 500px; text-align: center;">
								<!-- 날짜 -->
								<div id="date-div">
									<div id="month"></div>
									<div id="year"></div>
								</div>
								
								<!-- 날짜 선택 div -->
								<div class="is-border" id="select-date">
									<table class="date-table">
										<tr>
											<td id="before-year"><i class="fi fi-rr-angle-left"></i></td>
											<td colspan="2" style="text-align: center;">
												<div class="h-bold fs-18" id="current-year"></div>
											</td>
											<td id="after-year"><i class="fi fi-rr-angle-right"></i></td>
										</tr>
										<tr>
											<td class="month-td">1월</td>
											<td class="month-td">2월</td>
											<td class="month-td">3월</td>
											<td class="month-td">4월</td>
										</tr>
										<tr>
											<td class="month-td">5월</td>
											<td class="month-td">6월</td>
											<td class="month-td">7월</td>
											<td class="month-td">8월</td>
										</tr>
										<tr>
											<td class="month-td">9월</td>
											<td class="month-td">10월</td>
											<td class="month-td">11월</td>
											<td class="month-td">12월</td>
										</tr>
									</table>
								</div>
							</td>
							<td>
								<i class="fi fi-rr-angle-right fs28 click-icon" id="after"></i>
							</td>
						</tr>
					</table>
				</div> 
				<br><br>
				<!-- 수입/지출 추가 -->
				<table id="add-account-table">
					<tr>
						<td>
							<div class="switch spend">
								<input type="checkbox" name="add-moneytype" id="add-moneytype"><label for="add-moneytype">지출</label>
							</div>
						</td>
						<td class="td-input"><input type="date" id="add-date" placeholder="일자"></td>
						<td class="td-input">
							<input type="text" id="add-asset" placeholder="자산" readonly="readonly">
							<div class="input is-scroll select-add-asset select-div" style="width:200px; height:300px;">
								<div class="add-asset-list"></div>
							</div>
						</td>
						<td class="td-input">
							<input type="text" id="add-bigcate" placeholder="분류" readonly="readonly">
							<div class="input is-scroll select-add-incate select-div text-center" style="width:500px; height:60px;">
								<div class="add-incate-list">
									<table class="select-table td-border td-hover">
										<tr>
											<td>소득</td>
											<td>저축</td>
											<td>기타</td>
										</tr>
									</table>
								</div>
							</div>
							<div class="input is-scroll select-add-outcate select-div text-center" style="width:500px; height:220px;">
								<div class="add-outcate-list">
									<table class="select-table td-border td-hover">
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
							</div>
							<input type="text" id="add-smallcate" placeholder="소분류" disabled="disabled" readonly="readonly">
							<div class="input is-scroll select-add-smallcate select-div text-center" style="width:330px; height:220px;">
								<div class="add-smallcate-list"></div>
							</div>
						</td>
						<td class="td-input"><input type="text" id="add-content" placeholder="내용"></td>
						<td class="td-input"><input type="text" id="add-total" placeholder="금액"></td>
						<td><button class="btn main-color-btn" id="add-account-btn">+</button></td>
					</tr>
				</table>
			</div>
			<br>

			<!-- 검색 -->
			<div class="is-border" id="search-div">
				<div><input class='input inner' id="search-input" type="text"></div>
				<div id="search-btn"><i class="fi fi-rr-search"></i></div>
			</div>			
			<div id="search-list"></div>

			<!-- 합계 -->
			<div>
				<table class="total-table">
					<tr>
						<td>
							<div class="show-range active" id="show-all"><i class="fi fi-rs-check"></i></div>
							<div id="total-div"><h4 class='h-normal fs20 gray'>합계</h4><i class='h-normal fs20'></i></div>
						</td>
						<td>
							<div class="show-range" id="show-income"><i class="fi fi-rs-check"></i></div>
							<div id="income-div"><h4 class='h-normal fs20 gray'>총 수입</h4><i class='blue h-normal fs20'></i></div>
						</td>
						<td>
							<div class="show-range" id="show-spend"><i class="fi fi-rs-check"></i></div>
							<div id="spend-div"><h4 class='h-normal fs20 gray'>총 지출</h4><i class='red h-normal fs20'></i></div>
						</td>
					</tr>
				</table>
			</div>
			
			<!-- 미니 달력 -->
			<div class="is-border" style="width: 280px; height: 300px; position: absolute; right: 2%;">
				<div></div>
			</div>
	
			<!-- 미니 달력 -->
			<div style="width: 270px; height: 300px; position: absolute; left: 23%; top: 40%; background: #f3f3f3; border-radius: 10px; padding: 10px;">
				<div>
					<div id="mini-date-div" style="text-align: center; font-size: 20px; font-weight: bold;"></div>
				</div>
				<div>
					<table>
						<tr>
							<td>일</td>
							<td>월</td>
							<td>화</td>
							<td>수</td>
							<td>목</td>
							<td>금</td>
							<td>토</td>
						</tr>
					</table>
				</div>
			</div>
			
			<!-- 수입/지출 내역 -->
			<div class="is-scroll" style="height: 650px;">
				<div id="account-list-div"></div>
			</div>
			
			
			<% }
			/* 로그인이 되어 있지 않을 때 */
			else { %>
			<script>location.href = "../member/login.jsp";</script>
			<% } %>
		</div>
	</div>
	
	<!-- 수입/지출 수정 modal -->
	<div class="modal" id="update-account-modal" hidden="true">
		<div class="modal-content">
			<div class="modal-title">
				<h3 class="h-normal fs28">수입/지출 수정</h3>
				<button class="x-btn" id="close-update-account">x</button>
			</div>
			<div class="modal-body">
				<table class='table' id="update-account-table">
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
							<div class="input is-scroll select-update-asset" style="position:absolute; display: none; background: white; height:400px;">
								<div class="update-asset-list"></div>
							</div>
						</td>
					</tr>
					<tr>
						<th>대분류</th>
						<td>
							<input type="text" class="input" id="update-bigcate" placeholder="분류선택" readonly>
							<div class="input is-scroll select-update-incate select-div text-center" style="width:500px; height:120px;">
								<div class="select-update-incate">
									<table class="select-table td-border td-hover">
										<tr>
											<td>소득</td>
											<td>저축</td>
											<td>기타</td>
										</tr>
									</table>
								</div>
							</div>
							<div class="input is-scroll select-update-outcate select-div text-center" style="width:500px; height:220px;">
								<div class="select-update-outcate">
									<table class="select-table td-border td-hover">
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
							</div>
						</td>
					</tr>
					<tr>
						<th>소분류</th>
						<td>
							<input type="text" class="input" id="update-smallcate" placeholder="분류선택" readonly>
							<div class="input is-scroll select-update-smallcate select-div text-center" style="width:330px; height:220px;">
								<div class="select-update-smallcate-list"></div>
							</div>
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
</body>
</html>