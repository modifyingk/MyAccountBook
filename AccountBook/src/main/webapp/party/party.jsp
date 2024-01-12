<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 | 그룹</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/party/party.js"></script>
<script>
	var userid = "<%= session.getAttribute("userid") %>";
	var partyname = "<%= session.getAttribute("partyname") %>";
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
				<li class="menu"><i class="fi fi-rr-coins"></i> 자산관리</li>		
				<li class="menu"><i class="fi fi-rs-calendar-check"></i> 캘린더</li>		
				<li class="menu"><i class="fi fi-rs-chart-histogram"></i> 목표 관리</li>
				<li class="menu"><i class="fi fi-rr-comment-alt"></i> 게시판</li>
				<li class="menu active"><i class="fi fi-rr-users-alt"></i> 그룹</li>
				<li class="menu"><i class="fi fi-rr-sign-out-alt"></i> 로그아웃</li>
			</ul>
		</div>
		<!-- 컨텐츠 -->
		<div class="col-8">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) {
				/* 그룹이 없을 때*/
				if(session.getAttribute("partyname") == null) { %>
					<div>
						<h3 class="h-normal fs-28"><i class="fi fi-rr-users-alt"></i> 그룹</h3>
						<button class="btn medium green is-shadow" id="add-group-page">그룹 생성</button>
						<div> <!-- 그룹 검색 -->
							<input class="input" id="search-party">
							<button class="btn outline-green font-18" style="width: 70px; height: 45px;" id="search-party-btn"><i class="fi fi-rr-search"></i></button>
						</div>
						<div id="group-list-div"></div>
						
						<!-- 그룹 생성 모달 -->
						<div class="modal" id="add-group-modal" hidden="true">
							<div class="modal-content">
								<div class="modal-title">
									<h3 class="h-normal fs-28"><i class="fi fi-rr-add"></i> 그룹 생성</h3>
								</div>
								<div class="modal-body">
									<table>
										<tr>
											<td>그룹명</td>
										</tr>
										<tr>
											<td><input class="input" id="partyname"></td>
										</tr>
										<tr>
											<td>소개말</td>
										</tr>
										<tr>
											<td><textarea rows="5" class="input" id="introduction"></textarea></td>
										</tr>
										<tr>
											<td>정보공개</td>
										</tr>
										<tr>
											<td>
												<div class="select">
													<input type="radio" name="gender" id="male" value="M" checked><label for="male">공개</label>
													<input type="radio" name="gender" id="female" value="F"><label for="female">비공개</label>
												</div>
											</td>
										</tr>
									</table>
									<button class="btn medium green" id="add-group-btn">생성</button>
								</div>
								<div class="modal-footer">
									<button class="btn right outline-green" id="close-add-group">닫기</button>
								</div>
							</div>
						</div>
						
						<!-- 그룹 정보 모달 -->
						<div class="modal" id="group-info-modal" hidden="true">
							<div class="modal-content small">
							<div class="text-right"><i class="fi fi-rr-x info" id="close-group-info"></i></div>
								<div class="is-border" style="height: 430px;">
									<div id="group-info-div" style="padding: 20px;"></div><br>
									<div class='is-center'><button class="btn medium green" id="join-group-btn"><i class="fi fi-rr-paper-plane"></i> 가입신청</button></div>
								</div>
							</div>
						</div>
					</div>
				<%
				/* 그룹이 있을 때*/
				} else { %> 
					<div>
						<h3 class="h-normal fs-28"><i class="fi fi-rr-users-alt"></i> <%= session.getAttribute("partyname") %></h3>
						<div>
							<div class="col-3 is-scroll" style="border: 1px solid lightgray; border-radius: 10px; padding: 10px; width: 350px; height: 900px;">
								<div id="member-list-div"></div>
							</div>
							<div class="col-7 is-scroll" style="border: 1px solid lightgray; border-radius: 10px; padding: 10px; width: 1200px; height: 900px; margin-left: 20px;">
								<h3>그룹 목표</h3>
							</div>
						</div>
					</div>
			<% }
			}
			/* 로그인이 되어 있지 않을 때 */
			else { %>
				<script>location.href = "../member/login.jsp";</script>
			<% } %>
		</div>
	</div>
</body>
</html>