<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-solid-rounded/css/uicons-solid-rounded.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function() {
		// 자산 목록 보기
		var userid = "<%= session.getAttribute("userid") %>";
		$.ajax({
			type : "post",
			url : "assetInfo",
			dataType : "json",
			data : {
				userid : userid
			},
			success : function(assetList) {
				var html = "<table class='table'>"; // 자산 목록 테이블 만들기
				var group = "";
				for(let i = 0; i < assetList.length; i++) {
					if(!group.includes(assetList[i].astgroup)) { // 해당 자산 그룹이 존재하지 않으면
						html += "<tr><td>" + assetList[i].astgroup + "</td></tr>"; // 자산 그룹 행을 추가
					}
					html += "<tr class='asset-name'><td class='group-list is-border'>" + assetList[i].astname + "</td>" // 자산 이름 추가
					html += "<td style='display:none;'> " + assetList[i].astgroup + "</td>" // 자산 그룹 행 화면에 안보이게 생성 (클릭 시 값 넘기기 위함)
					html += "<td style='display:none;'> " + assetList[i].astmemo + "</td><tr>" // 자산 메모 행 화면에 안보이게 생성 (클릭 시 값 넘기기 위함)
					group += assetList[i].astgroup; // 받아온 assetList의 astgroup을 group 변수에 추가
				}
				html += "</table>";
				$("#asset-list-div").html(html);
			}
		})
		// 자산 수정
		$(document).on("click", ".asset-name", function() { // asset-name 행 클릭 시
			var value = $(this).text().split(" "); // tr의 td들(자산과 자산그룹)을 공백 한 칸으로 분리해놓았으므로 분리하여 value변수에 저장
			$("#up-asset-modal").show(); // 자산 수정 모달 열기
			var html ="";
			html += "<table class='table'><tr><th>그룹</th><td><input class='input' id='up-astgroup-name' value='" + value[1] + "' readonly></td><tr>";
			html += "<tr><th>이름</th><td><input class='input' id='up-asset-name' value='" + value[0] + "'></td></tr>"; // value[0]은 자산
			html += "<tr><th>메모</th><td><textarea rows='5' class='input' id='up-astmemo-name'>" + value[2] + "</textarea></td></tr></table>"; // value[2]은 자산메모
			html += "<button class='btn medium green' id='up-asset-btn'>수정</button>";
			$("#up-asset-div").html(html);
			
			$("#up-asset-btn").click(function() { // 자산 수정 버튼 클릭 시
				// 자산 이름 정규식
				var assetReg = RegExp(/^[a-zA-Z가-힣]{1,10}$/);
				if(!assetReg.test($("#up-asset-name").val())){ // 정규식에 맞지 않을 때
					$("#up-asset-check p").attr("class", "msg warning");
				} else {
					$("#up-asset-check p").attr("class", "msg info");
					// 자산 중복 확인
					$.ajax({
						type : "post",
						url : "isOverlapAsset",
						data : {
							astgroup : $("#up-astgroup-name").val(),
							astname : $("#up-asset-name").val(),
							userid : userid
						},
						success : function(x) {
							if(x == "possible") { // 자산이 중복되지 않으면 수정
								$.ajax({
									type : "post",
									url : "updateAsset",
									data : {
										userid : userid,
										originAsset : value[0],
										originGroup : value[1],
										updateAsset : $("#up-asset-name").val(),
										updateGroup : $("#up-astgroup-name").val(),
										updateMemo : $("#up-astmemo-name").val()
									},
									success : function(x) {
										if(x == "success") {
											$("#up-asset-modal").hide();
											window.location.reload();
										} else {
											alert("다시 시도해주세요")
										}
									}
								})
							} else { // 자산이 중복되는 경우
								alert("중복되는 자산입니다");
							}
						}
					})
				}
			})
			
			$("#up-astgroup-name").click(function() { // 자산 그룹 클릭 시
				$.ajax({
					type : "post",
					url : "astGroupInfo",
					data : {
						userid : userid
					},
					success : function(groupList) {
						var group = groupList; // 자산 그룹 리스트
						var html = "<table class'table' id='select-table'>";
						for(let i = 0; i < group.length; i++) {
							html += "<tr><td class='group-list is-border'>" + group[i] + "</td></tr>";
						}
						html += "</table>";
						$("#select-group-div").html(html); // 자산 그룹  출력
					}
				})
				$("#select-group-modal").show(); // 자산 그룹 선택 모달 열기
			})
		})
		$(document).on("click","#select-table .group-list",function() { // 자산 그룹 선택 테이블의 td 클릭 시
			var idx = $(this).parent().index(); // 클릭한 값의 부모(tr)의 인덱스값을 가져옴
			var option = $("#select-table .group-list").eq(idx).text(); // 자산 그룹 선택 테이블의 idx번째 td 값을 가져옴
			$("#select-group-modal").hide(); // 자산 그룹 선택 모달 닫기
			$("#up-astgroup-name").attr("value", option);
		})
		// 자산 수정 모달 닫기
		$("#close-up-asset").click(function() {
			$("#up-asset-modal").hide();
		})
		// 자산 수정에서 자산그룹 선택 모달 닫기
		$("#close-select-group").click(function() {
			$("#select-group-modal").hide();
		})
		
		/* ------------------------------------------------------------------------------------------------------------------ */
		/* ------------- 자산 그룹 목록 관련 jquery ------------- */
		// 자산 그룹 목록 보기
		$("#astGroupBtn").click(function() {
			$.ajax({
				type : "post",
				url : "astGroupInfo",
				data : {
					userid : userid
				},
				success : function(groupList) {
					var group = groupList;
					var html = "<table class='table' id='astgroup-table'>";
					for(let i = 0; i < group.length; i++) {
						html += "<tr><td class='group-list is-border'>" + group[i] + "</td>";
						html += "<td class='del-group-td'><i class='fi fi-sr-minus-circle del-icon'></i></td></tr>";
					}
					html += "</table>";
					$("#group-list-div").html(html);
				}
			})
			$("#group-modal").show();
		})
		// 자산 그룹 모달 닫기
		$("#close-group").click(function() {
			$("#group-modal").hide();
		})
		
		/* ------------- 자산 그룹 삭제 관련 jquery ------------- */
		// 자산 그룹 삭제
		$(document).on("click","#astgroup-table tr .del-group-td",function() {
			var idx = $(this).parent().index();
			var delGroup = $(".group").eq(idx).text();
			var op = confirm(delGroup + " 그룹을 삭제하시겠습니까?");
			if(op == true) {
				$.ajax({
					type : "post",
					url : "deleteGroup",
					data : {
						astgroup : delGroup,
						userid : userid
					},
					success : function(x) {
						if(x == "success") {
							$("#up-group-modal").hide();
							$("#group-modal").hide();
						} else if(x == "constraint") {
							alert("자산이 존재하는 자산 그룹은 삭제할 수 없습니다");
						} else {
							alert("다시 시도해주세요");
						}
					}
				})	
			}
			
		})
		/* ------------- 자산 그룹 수정 관련 jquery ------------- */
		// 자산 그룹 수정
		$(document).on("click","#astgroup-table tr .group-list",function() { // 수정하려는 자산 그룹(테이블 행) 클릭 시
			var originName = $(this).text(); // 클릭한 자산 그룹 이름 변수에 저장
			$("#up-group-modal").show(); // 자산 그룹 수정 모달 보여주기
			
			var html = "<div>"; 
			html += "<input class='input' id='up-group-name' value='" + originName + "'>";
			html += "<br><br><button class='btn medium green' id='up-group-btn'>수정</button>";
			$("#up-group-div").html(html);
			$("#up-group-name").focus();
			
			$("#up-group-btn").click(function() {
				// 자산 그룹 정규식
				var groupReg = RegExp(/^[a-zA-Z가-힣]{1,10}$/);
				if(!groupReg.test($("#up-group-name").val())){ // 정규식에 맞지 않을 때
					$("#up-group-check p").attr("class", "msg warning");
				} else { // 정규식에 맞으면
					$("#up-group-check p").attr("class", "msg info");
					// 자산 그룹 중복 확인
					$.ajax({
						type : "post",
						url : "isOverlapGroup",
						data : {
							astgroup : $("#up-group-name").val(),
							userid : userid
						},
						success : function(x) {
							if(x == "possible") { // 자산 그룹 이름이 중복되지 않으면 해당 이름으로 수정
								$.ajax({
									type : "post",
									url : "updateGroup",
									data : {
										originName : originName,
										updateName : $("#up-group-name").val(),
										userid : userid
									},
									success : function(x) {
										if(x == "success") { // 수정에 성공하면 모달 닫기
											$("#up-group-modal").hide();
											$("#group-modal").hide();
										} else {
											alert("다시 시도해주세요");
										}
									}
								})
							} else { // 자산 그룹 이름이 중복되는 경우
								alert("중복되는 자산 그룹 이름입니다");
							}
						}
					})
				}
			})
		})
		// 자산 그룹 수정 모달 닫기
		$("#close-up-group").click(function() {
			$("#up-group-modal").hide();
		})
		
		/* ------------- 자산 그룹 추가 관련 jquery ------------- */
		// 자산 그룹 추가 페이지 버튼
		$("#insert-group-page").click(function() {
			$("#add-group-modal").show();
			$("#astgroup").focus();
		})
		// 자산 그룹 추가 모달 닫기
		$("#close-add-group").click(function() {
			$("#add-group-modal").hide();
		})
		// 자산 그룹 추가 버튼
		$("#add-group-btn").click(function() {
			var astgroup = $("#astgroup").val();
			
			// 자산 그룹 정규식 (영어, 한글 1~10 글자)
			var groupReg = RegExp(/^[a-zA-Z가-힣]{1,10}$/);
			
			if(!groupReg.test($("#astgroup").val())){ // 정규식에 맞지 않을 때
				$("#add-group-check p").attr("class", "msg warning"); // 글자 빨간색으로 하는 warning-msg
			} else {
				$("#add-group-check p").attr("class", "msg info"); // 글자 원래대로
				// 자산 그룹 중복 확인
				$.ajax({
					type : "post",
					url : "isOverlapGroup",
					data : {
						astgroup : astgroup,
						userid : userid
					},
					success : function(x) {
						if(x == "possible") { // 자산 그룹명이 중복되지 않으면 자산 그룹 추가
							$.ajax({
								type : "post",
								url : "insertGroup",
								data : {
									astgroup : astgroup,
									userid : userid
								},
								success : function(x) {
									if(x == "success") { // 추가되었으면 모달창 닫기
										$("#add-group-modal").hide();
										$("#up-group-modal").hide();
										$("#group-modal").hide();
									} else {
										alert("다시 시도해주세요");
									}
								}
							})
						} else { // 자산 그룹명이 중복되는 경우
							alert("중복되는 자산 그룹 이름은 추가하실 수 없습니다!")
						}
					}
				})
			}
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
				
				<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산관리</h3>
				<button class="btn long gray" id="astGroupBtn">자산그룹</button>
				<div id="asset-list-div"></div>
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
							<div id="up-asset-div"></div>
							<br>
							<div id='up-asset-check'><p class='msg info'>자산명은 영문이나 한글 1~10자만 입력 가능</p></div>
						</div>
						<hr>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-up-asset">닫기</button>
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
						<button class="btn medium green" id="insert-group-page" style="margin-left: 10px;">추가</button>
						<div class="modal-body">
							<div id="group-list-div"></div>
						</div>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-group">닫기</button>
						</div>
					</div>
				</div>
				<div class="modal" id="up-group-modal" hidden="true">
					<div class="modal-content small">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산그룹 수정</h3>
						</div>
						<hr>
						<div class="modal-body small">
							<h5 class='h-normal fs-20'><i class="fi fi-rr-pencil"></i> 자산 그룹명</h5>
							<div id='up-group-check'><p class='msg info'>영문이나 한글 1~10자만 입력 가능</p></div>
							<br>
							<div id="up-group-div"></div>
							<br>
							<div><p class="msg warning">* 변경 시 관련된 자산의 자산 그룹 이름도 함께 변경됩니다 *</p></div>
						</div>
						<hr>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-up-group">닫기</button>
						</div>
					</div>
				</div>
				<div class="modal" id="add-group-modal" hidden="true">
					<div class="modal-content small">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산그룹 추가</h3>
						</div>
						<hr>
						<div class="modal-body small">
							<div id="add-group-div">
								<h5 class='h-normal fs-20'><i class="fi fi-rr-pencil"></i> 자산 그룹명</h5>
								<div id="add-group-check"><p class='msg info'>영문이나 한글 1~10자만 입력 가능</p></div>
								<br>
								<input type="text" class="input" id="astgroup" maxlength="10">
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