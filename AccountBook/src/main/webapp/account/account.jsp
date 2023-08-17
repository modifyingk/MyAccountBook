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
<script>
	$(function() {
		var userid = "<%= session.getAttribute("userid") %>";
		
		// 전체 카테고리 목록 가져오기
		$.ajax({
			type : "post",
			url : "categoryInfo",
			data : {
				userid : userid
			},
			success : function(cateList) {
				var in_html = "<table class='table' id='in-category-table'>";

				for(let i = 0; i < cateList.length; i++) {
					if(cateList[i].moneytype == "수입") {
						in_html += "<tr><td class='group-list is-border'>" + cateList[i].catename + "</td></tr>"
					}
				}
				in_html += "</table>";

				var out_html = "<table class='table' id='out-category-table'>";
				for(let i = 0; i < cateList.length; i++) {
					if(cateList[i].moneytype == "지출") {
						out_html += "<tr><td class='group-list is-border'>" + cateList[i].catename + "</td></tr>"
					}
				}
				out_html += "</table>";
				
				$("#in-category-list-div").html(in_html);
				$("#out-category-list-div").html(out_html);
			}
		})
		// 수입 분류 모달 열기
		$("#in-category-btn").click(function() {
			$("#in-category-modal").show();
		})
		// 수입 분류 모달 닫기
		$("#close-in-category").click(function() {
			$("#in-category-modal").hide();
		})
		// 지출 분류 모달 열기
		$("#out-category-btn").click(function() {
			$("#out-category-modal").show();
		})	
		// 지출 분류 모달 닫기
		$("#close-out-category").click(function() {
			$("#out-category-modal").hide();
		})
		
		// 카테고리 추가 모달 열기
		$("#add-in-category-page").click(function() { // 수입 추가
			$("#add-category-modal").show();
			
			$("#moneytype").attr("value", "수입");
		})	
		$("#add-out-category-page").click(function() { // 지출 추가
			$("#add-category-modal").show();
		
			$("#moneytype").attr("value", "지출");
		})
		$("#add-category-btn").click(function() {
			$.ajax({
				type : "post",
				url : "insertCategory",
				data : {
					moneytype : $("#moneytype").val(),
					catename : $("#catename").val(),
					userid : userid
				},
				success : function(x) {
					if(x == "success") {
						window.location.reload();
					} else {
						alert("다시 시도해주세요");
					}
				}
			})
		})
		// 수입/지출 선택 모달
		$("#moneytype").click(function() {
			$("#select-moneytype-modal").show();
			$("#in").click(function() {
				$("#moneytype").attr("value", "수입");
				$("#select-moneytype-modal").hide();
			})
			$("#out").click(function() {
				$("#moneytype").attr("value", "지출");
				$("#select-moneytype-modal").hide();
			})
		})
		// 수입/지출 선택 모달 닫기
		$("#close-select-moneytype").click(function() {
			$("#select-moneytype-modal").hide();
		})
		// 카테고리 추가 모달 닫기
		$("#close-add-category").click(function() {
			$("#add-category-modal").hide();
		})
		
		// 수입분류 수정 모달 열기
		$(document).on("click", "#in-category-table .group-list", function() {
			// 수정 모달 input에 현재 값 넣어두기
			var originName = $(this).text();
			$("#in-catename").attr("value", originName);
			// 모달 열기
			$("#up-in-category-modal").show();
			
			$("#up-in-category-btn").click(function() {
				// 수정 버튼 클릭
				$.ajax({
					type : "post",
					url : "updateCategory",
					data : {
						moneytype : "수입",
						originName : originName,
						updateName : $("#in-catename").val(),
						userid : userid
					},
					success : function(x) {
						if(x == "success") {
							window.location.reload();
						} else {
							alert("다시 시도해주세요");
						}
					}
				})
			})
			$("#del-in-category-btn").click(function() {
				// 삭제 버튼 클릭
				var op = confirm($("#in-catename").val() + " 카테고리를 삭제하시겠습니까?");
				if(op) {
					$.ajax({
						type : "post",
						url : "deleteCategory",
						data : {
							moneytype : "수입",
							catename : $("#in-catename").val(),
							userid : userid
						},
						success : function(x) {
							if(x == "success") {
								window.location.reload();
							} else {
								alert("다시 시도해주세요");
							}
						}
					})
				}
			})
		})
		// 수입분류 수정 모달 닫기
		$("#close-up-in-category").click(function() {
			$("#up-in-category-modal").hide();
		})
		
		// 지출분류 수정 모달 열기
		$(document).on("click", "#out-category-table .group-list", function() {
			// 수정 모달 input에 현재 값 넣어두기
			var originName = $(this).text();
			$("#out-catename").attr("value", originName);
			// 모달 열기
			$("#up-out-category-modal").show();
			
			$("#up-out-category-btn").click(function() {
				// 수정 버튼 클릭
				$.ajax({
					type : "post",
					url : "updateCategory",
					data : {
						moneytype : "지출",
						originName : originName,
						updateName : $("#out-catename").val(),
						userid : userid
					},
					success : function(x) {
						if(x == "success") {
							window.location.reload();
						} else {
							alert("다시 시도해주세요");
						}
					}
				})
			})
			$("#del-out-category-btn").click(function() {
				// 삭제 버튼 클릭
				var op = confirm($("#out-catename").val() + " 카테고리를 삭제하시겠습니까?");
				if(op) {
					$.ajax({
						type : "post",
						url : "deleteCategory",
						data : {
							moneytype : "지출",
							catename : $("#out-catename").val(),
							userid : userid
						},
						success : function(x) {
							if(x == "success") {
								window.location.reload();
							} else {
								alert("다시 시도해주세요");
							}
						}
					})
				}
			})
		})
		// 지출분류 수정 모달 닫기
		$("#close-up-out-category").click(function() {
			$("#up-out-category-modal").hide();
		})
	})
</script>
</head>
<body>
	<div>
		<!-- 사이드바 -->
		<div class="col-2 is-border is-shadow">
			<jsp:include page="../main/sidebar.jsp"></jsp:include>
		</div>

		<!-- 컨텐츠 -->
		<div class="col-8">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<div>
				
				<h3 class="h-normal fs-28"><i class="fi fi-rr-add"></i> 수입/지출 관리</h3>
				<button class="btn long gray" id="in-category-btn">수입 분류</button>
				<button class="btn long gray" id="out-category-btn">지출 분류</button>
				
				<!-- 수입 카테고리 모달 -->
				<div class="modal" id="in-category-modal" hidden="true">
					<div class="modal-content">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 수입 카테고리 관리</h3>
						</div>
						<button class="btn medium green" id="add-in-category-page" style="margin-left: 10px;">추가</button>
						<div class="modal-body">
							<div id="in-category-list-div"></div>
						</div>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-in-category">닫기</button>
						</div>
					</div>
				</div>
				<!-- 수입 카테고리 수정 모달 -->
				<div class="modal" id="up-in-category-modal" hidden="true">
					<div class="modal-content small">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 수입 카테고리 수정</h3>
						</div>
						<hr>
						<div class="modal-body small">
							<h5 class='h-normal fs-20'><i class="fi fi-rr-pencil"></i> 카테고리명</h5>
							<div id="up-in-category-div">
								<table class='table'>
									<tr>
										<th>이름</th>
										<td><input type="text" class="input" id='in-catename'></td>
									</tr>
								</table>
								<button class="btn medium green" id="up-in-category-btn">수정</button>
								<button class="btn outline-green" id="del-in-category-btn" style='height: 48px;'>삭제</button>
							</div>
						</div>
						<hr>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-up-in-category">닫기</button>
						</div>
					</div>
				</div>
				<!-- 지출 카테고리 모달 -->
				<div class="modal" id="out-category-modal" hidden="true">
					<div class="modal-content">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 지출 카테고리 관리</h3>
						</div>
						<button class="btn medium green" id="add-out-category-page" style="margin-left: 10px;">추가</button>
						<div class="modal-body">
							<div id="out-category-list-div"></div>
						</div>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-out-category">닫기</button>
						</div>
					</div>
				</div>
				<!-- 지출 카테고리 수정 모달 -->
				<div class="modal" id="up-out-category-modal" hidden="true">
					<div class="modal-content small">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 지출 카테고리 수정</h3>
						</div>
						<hr>
						<div class="modal-body small">
							<h5 class='h-normal fs-20'><i class="fi fi-rr-pencil"></i> 카테고리명</h5>
							<div id="up-out-category-div">
								<table class='table'>
									<tr>
										<th>이름</th>
										<td><input type="text" class="input" id='out-catename'></td>
									</tr>
								</table>
								<button class="btn medium green" id="up-out-category-btn">수정</button>
								<button class="btn outline-green" id="del-out-category-btn" style='height: 48px;'>삭제</button>
							</div>
						</div>
						<hr>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-up-out-category">닫기</button>
						</div>
					</div>
				</div>
				<!-- 카테고리 추가 모달 -->
				<div class="modal" id="add-category-modal" hidden="true">
					<div class="modal-content small">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 카테고리 추가</h3>
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
							<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 분류</h3>
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
			<% }
			/* 로그인이 되어 있지 않을 때 */
			else { %>
				<script>location.href = "../member/login.jsp";</script>
			<% } %>
		</div>
	</div>
</body>
</html>