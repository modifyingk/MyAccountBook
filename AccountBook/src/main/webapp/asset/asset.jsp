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
<script>
	$(function() {
		var userid = "<%= session.getAttribute("userid") %>";
		// 자산 목록 보기
		$.ajax({
			type : "post",
			url : "assetInfo",
			dataType : "json",
			data : {
				userid : userid
			},
			success : function(map) {
				$.ajax({
					type : "post",
					url : "assetTotal",
					data : {
						userid : userid
					},
					success : function(assetTotal) {
						var total = 0;
						
						for(var i = 0; i < assetTotal.length; i++) {
							if(assetTotal[i].moneytype == "지출") {
								assetTotal[i].total = parseInt("-" + assetTotal[i].total);
							}
							total += assetTotal[i].total;
						}
						$("#asset-total-div").html("<i class='h-normal fs-23 info'>합계</i><i class='h-normal fs-23'>" + total + "원</i>");
						
						var html = "<table class='modal-table' style='width: 500px;'>"; // 자산 목록 테이블 만들기
						for(var key in map ) {
							html += "<tr><td>" + key + "</td></tr>"; // key 값인 자산 그룹 이름 출력
							var value = map[key].split(","); // 자산 그룹에 해당하는 자산이 여러 개이면 ,로 구분되어 있으므로 ,를 기준으로 분리하여 value 변수에 저장
							for(var i = 0; i < value.length; i++) {
								var asset = value[i].split("#"); // 자산이름과 자산메모는 /로 구분되어 있으므로 /를 기준으로 분리하여 asset 변수에 저장
									html += "<tr class='asset-name'><td class='group-list is-border td-detail'><div class='col-5'>" + asset[0] + "</div>"; // asset[0]은 자산 이름
									var catetotal = 0;
									for(var j = 0; j < assetTotal.length; j++) {
										if(asset[0] == assetTotal[j].astname) {
											catetotal += assetTotal[j].total;
										}
									}
									if(catetotal < 0) {
										html += "<div class='col-5 text-right red'>" + catetotal + "원</div></td>"
									} else {
										html += "<div class='col-5 text-right blue'>" + catetotal + "원</div></td>"
									}
									html += "<td style='display:none;'>" + key + "</td>"; // key는 자산 그룹 (클릭 시 값 넘기기 위한 것으로, 화면에는 보이지 않도록 생성)
									html += "<td style='display:none;'>" + asset[1] + "</td>"; // asset[1]은 자산 메모 (클릭 시 값 넘기기 위한 것으로, 화면에는 보이지 않도록 생성)
									html += "<td class='update-btn' id='up-asset-page'><button class='update-icon'><i class='fi fi-rr-pencil fs-23'></i></button></td></tr>";
							}
							html += "<tr><td></td></tr>";
						}
						html += "</table>";
						$("#asset-list-div").html(html);
					}
				})
			}
		})
		$(document).on("click", ".asset-name .td-detail", function() { // asset-name 행 클릭 시
			
		})
		// 자산 수정
		var originAsset;
		var originActgroup;
		var originMemo;
		$(document).on("click", "#up-asset-page", function() { // 수정 아이콘(#up-asset-page) 클릭 시
			// tr의 td들(자산, 자산그룹, 자산메모)을 공백 한 칸으로 분리해놓았으므로 분리하여 value 변수에 저장
			originAsset = $(this).parent().children().eq(0).children().eq(0).text();
			originActgroup = $(this).parent().children().eq(1).text();
			originMemo = $(this).parent().children().eq(2).text();
			$("#up-asset-modal").show(); // 자산 수정 모달 열기
			
			$("#up-astgroup-name").attr("value",originActgroup);
			$("#up-asset-name").attr("value", originAsset);
			$("#up-astmemo-name").val(originMemo);
		})
		$("#up-asset-btn").click(function() { // 자산 수정 버튼 클릭 시
			var assetReg = RegExp(/^[a-zA-Z가-힣0-9\s]{1,10}$/); // 자산 이름 정규식
			if(!assetReg.test($("#up-asset-name").val())){ // 정규식에 맞지 않을 때
				$("#up-asset-check p").attr("class", "msg warning");
			} else {
				$("#up-asset-check p").attr("class", "msg info");
				
				if($("#up-asset-name").val() != originAsset) {
					$.ajax({ // 자산 중복 확인
						type : "post",
						url : "isOverlapAsset",
						data : {
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
										originAsset : originAsset,
										updateAsset : $("#up-asset-name").val(),
										updateGroup : $("#up-astgroup-name").val(),
										updateMemo : $("#up-astmemo-name").val()
									},
									success : function(x) {
										if(x == "success") {
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
				} else {
					$.ajax({
						type : "post",
						url : "updateAsset",
						data : {
							userid : userid,
							originAsset : originAsset,
							updateAsset : $("#up-asset-name").val(),
							updateGroup : $("#up-astgroup-name").val(),
							updateMemo : $("#up-astmemo-name").val()
						},
						success : function(x) {
							if(x == "success") {
								window.location.reload();
							} else {
								alert("다시 시도해주세요")
							}
						}
					})
				}
				
			}
		})
		// 자산 수정 모달 닫기
		$("#close-up-asset").click(function() {
			$("#up-asset-modal").hide();
		})
		
		// 자산 삭제
		$("#del-asset-btn").click(function() { // 자산 삭제 버튼 클릭 시
			var op = confirm(originAsset + " 자산을 삭제하시겠습니까?");
			if(op == true) {
				$.ajax({
					type : "post",
					url : "deleteAsset",
					data : {
						astname : $("#up-asset-name").val(),
						userid : userid
					},
					success : function(x) {
						if(x == "success") {
							window.location.reload();
						} else {
							alert("다시 시도해주세요")
						}
					}
				})
			}
		})
			
		// 자산 수정에서 자산 그룹 선택 모달 열기
		$("#up-astgroup-name, #add-astgroup-name").click(function() { // 자산 그룹 클릭 시
			$("#select-group-modal").show(); // 자산 그룹 선택 모달 열기
		})
		// 자산 수정에서 자산그룹 선택 모달 닫기
		$("#close-select-group").click(function() {
			$("#select-group-modal").hide();
		})
		$(document).on("click","#select-table .group-list",function() { // 자산 그룹 선택 테이블의 td 클릭 시
			var idx = $(this).parent().index(); // 클릭한 값의 부모(tr)의 인덱스값을 가져옴
			var option = $("#select-table .group-list").eq(idx).text(); // 자산 그룹 선택 테이블의 idx번째 td 값을 가져옴
			$("#select-group-modal").hide(); // 자산 그룹 선택 모달 닫기
			$("#up-astgroup-name").attr("value", option);
		})
		$(document).on("click","#select-table .group-list",function() { // 자산 그룹 선택 테이블의 td 클릭 시
			var idx = $(this).parent().index(); // 클릭한 값의 부모(tr)의 인덱스값을 가져옴
			var option = $("#select-table .group-list").eq(idx).text(); // 자산 그룹 선택 테이블의 idx번째 td 값을 가져옴
			$("#select-group-modal").hide(); // 자산 그룹 선택 모달 닫기
			$("#add-astgroup-name").attr("value", option);
		})
		
		// 자산 추가 페이지 버튼
		$("#add-asset-page").click(function() {
			$("#add-asset-modal").show();
			
			$("#add-asset-btn").click(function() {
				// 자산 이름 정규식
				var assetReg = RegExp(/^[a-zA-Z가-힣0-9\s]{1,10}$/);
				if(!assetReg.test($("#add-asset-name").val())){ // 정규식에 맞지 않을 때
					$("#add-asset-check p").attr("class", "msg warning");
				} else {
					$("#add-asset-check p").attr("class", "msg info");
					// 자산 중복 확인
					$.ajax({
						type : "post",
						url : "isOverlapAsset",
						data : {
							astname : $("#add-asset-name").val(),
							userid : userid
						},
						success : function(x) {
							if(x == "possible") { // 자산이 중복되지 않으면 추가
								$.ajax({
									type : "post",
									url : "insertAsset",
									data : {
										userid : userid,
										astname : $("#add-asset-name").val(),
										astgroup : $("#add-astgroup-name").val(),
										astmemo : $("#add-astmemo-name").val(),
									},
									success : function(x) {
										if(x == "success") {
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
		})
		// 자산 추가 모달 닫기
		$("#close-add-asset").click(function() {
			$("#add-asset-modal").hide();
		})
		/* ------------------------------------------------------------------------------------------------------------------ */
		/* ------------- 자산 그룹 목록 관련 jquery ------------- */
		// 자산 그룹 목록 보기
		$.ajax({
			type : "post",
			url : "astGroupInfo",
			data : {
				userid : userid
			},
			success : function(groupList) {
				var group_html = "<table class='modal-table' id='astgroup-table'>";
				var astgroup_html = "<table class'modal-table' id='select-table'>";
				
				for(let i = 0; i < groupList.length; i++) {
					group_html += "<tr><td class='group-list is-border del-group'>" + groupList[i] + "</td>";
					group_html += "<td class='del-group-td'><i class='fi fi-sr-minus-circle del-icon'></i></td></tr>";

					astgroup_html += "<tr><td class='group-list is-border' style='width: 500px; height: 30px;'>" + groupList[i] + "</td></tr>";
				}
				group_html += "</table>";
				astgroup_html += "</table>";

				$("#group-list-div").html(group_html); // 자산 그룹 목록 div
 				$("#select-group-div").html(astgroup_html); // 자산 그룹 선택 div
			}
		})
		$("#astgroup-btn").click(function() {
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
			var delGroup = $(".del-group").eq(idx).text();
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
							window.location.reload();
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
		var originGroup;
		$(document).on("click","#astgroup-table tr .group-list",function() { // 수정하려는 자산 그룹(테이블 행) 클릭 시
			originGroup = $(this).text(); // 클릭한 자산 그룹 이름 변수에 저장
			$("#up-group-modal").show(); // 자산 그룹 수정 모달 보여주기
			$("#up-group-name").attr("value", originGroup);
			$("#up-group-name").focus();
		})
		$("#up-group-btn").click(function() { // 수정 버튼 클릭 시
			var groupReg = RegExp(/^[a-zA-Z가-힣0-9\s]{1,10}$/); // 자산 그룹 정규식
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
									originName : originGroup,
									updateName : $("#up-group-name").val(),
									userid : userid
								},
								success : function(x) {
									if(x == "success") { // 수정에 성공하면 모달 닫기
										window.location.reload();
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
		// 자산 그룹 수정 모달 닫기
		$("#close-up-group").click(function() {
			$("#up-group-modal").hide();
		})
		
		/* ------------- 자산 그룹 추가 관련 jquery ------------- */
		// 자산 그룹 추가 페이지 버튼
		$("#add-group-page").click(function() {
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
			
			// 자산 그룹 정규식
			var groupReg = RegExp(/^[a-zA-Z가-힣0-9\s]{1,10}$/);
			
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
										window.location.reload();
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
		var clickNum = 0;
		$("#open-group-setting").click(function() {
			clickNum++;
			if(clickNum % 2 != 0) {
				$("#group-setting").show();
			} else {
				$("#group-setting").hide();
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
				<div class="fix-right-tr-1">
					<button class="btn green font-18 is-shadow" id="open-group-setting" style="width: 60px;"><i class="fi fi-rr-menu-burger"></i></button>
				</div>
				<div class="fix-right-tr-2" id="group-setting" hidden>
					<button class="btn small outline-green font-18 is-shadow" id="astgroup-btn">자산 그룹</button>
				</div>
				<div class="fix-left-bl">
					<button class="btn medium green font-18 is-shadow" id="add-asset-page"><i class="fi fi-rr-add"></i> 자산 추가</button>
				</div>
				<div id="asset-total-div" style="margin: 5px;"></div><br>
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
											<input class="input" id="up-asset-name" maxlength="10">
										</td>
									</tr>
									<tr>
										<th>메모</th>
										<td>
											<textarea rows="5" class="input" id="up-astmemo-name"></textarea>
										</td>
									</tr>
								</table>
								<button class="btn medium green" id="up-asset-btn">수정</button>
								<button class="btn outline-green" style="height: 48px;" id="del-asset-btn">삭제</button>
							</div>
							<br>
							<div id='up-asset-check'>
								<p class='msg info'>자산명은 특수문자 제외, 1~10 글자 입력</p>
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
											<input class='input' id='add-astgroup-name' readonly>
										</td>
									<tr>
									<tr>
										<th>이름</th>
										<td>
											<input class='input' id='add-asset-name' maxlength="10">
										</td>
									</tr>
									<tr>
										<th>메모</th>
										<td>
											<textarea rows='5' class='input' id='add-astmemo-name'></textarea>
										</td>
									</tr>
								</table>
								<button class='btn medium green' id='add-asset-btn'>추가</button>
							</div>
							<br>
							<div id='add-asset-check'>
								<p class='msg info'>자산명은 특수문자 제외, 1~10 글자 입력</p>
							</div>
						</div>
						<div class="modal-footer">
							<button class="btn right outline-green" id="close-add-asset">닫기</button>
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
				<div class="modal" id="up-group-modal" hidden="true">
					<div class="modal-content small">
						<div class="modal-title">
							<h3 class="h-normal fs-28"><i class="fi fi-rr-coins"></i> 자산그룹 수정</h3>
						</div>
						<hr>
						<div class="modal-body small">
							<h5 class='h-normal fs-20'><i class="fi fi-rr-pencil"></i> 자산 그룹명</h5>
							<div id='up-group-check'>
								<p class='msg info'>그룹명은 특수문자 제외, 1~10 글자 입력</p>
							</div>
							<br>
							<div id="up-group-div">
								<input class="input" id="up-group-name">
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
									<p class='msg info'>그룹명은 특수문자 제외, 1~10 글자 입력</p>
								</div>
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