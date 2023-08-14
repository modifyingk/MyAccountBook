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
				//alert(JSON.stringify(assetList));
				//alert(assetList[0].astname);
				var html = "<table class='signup-table'>";
				for(let i = 0; i < assetList.length; i++) {
					html += "<tr><td style='border: 1px solid lightgray; border-radius: 10px; padding: 20px; width: 250px;'>" + assetList[i].astname + "</td><tr>"
				}
				html += "</table>";
				$("#assetDiv").html(html);
			}
		})
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
					var groupTable = "<table id='grouptable'>";
					for(let i = 0; i < group.length; i++) {
						groupTable += "<tr><td class='group'>" + group[i] + "</td><td class='delGroup'><i class='fi fi-sr-minus-circle deleteIcon'></i></td></tr>";
					}
					groupTable += "</table>";
					$("#assetGroupDiv").html(groupTable);
				}
			})
			$("#modal").show();
		})
		// 자산 그룹 모달 닫기
		$("#closeModal").click(function() {
			$("#modal").hide();
		})
		
		// 자산 그룹 수정
		$(document).on("click","#grouptable tr .group",function() {
			var originName = $(this).text();
			$("#modal2").show();
			$("#updateGroupDiv").html("<div id='upGroupCheck'><p class='infoMsg'>영문이나 한글 1~10자만 입력 가능</p></div><input class='signup-input' id='updateName' value='" + originName + "'><button class='btn long green' id='updateGroup'>수정</button>");
			
			$("#updateGroup").click(function() {
				// 자산 그룹 빈 값 확인
				var groupReg = RegExp(/^[a-zA-Z가-힣]{1,10}$/);
				
				if(!groupReg.test($("#updateName").val())){ // 정규식에 맞지 않을 때
					$("#upGroupCheck p").attr("class", "warningMsg");
				} else {
					$("#upGroupCheck p").attr("class", "infoMsg");
					// 자산 그룹 중복 확인
					$.ajax({
						type : "post",
						url : "isOverlapGroup",
						data : {
							astgroup : $("#updateName").val(),
							userid : userid
						},
						success : function(x) {
							if(x == "possible") {
								$.ajax({
									type : "post",
									url : "updateGroup",
									data : {
										originName : originName,
										updateName : $("#updateName").val(),
										userid : userid
									},
									success : function(x) {
										if(x == "success") {
											$("#modal2").hide();
											$("#modal").hide();
										} else {
											alert("다시 시도해주세요");
										}
									}
								})
							} else {
								alert("중복되는 자산 그룹 이름이 있습니다");
							}
						}
					})
				}
			})
		})
		// 자산 그룹 수정 모달 닫기
		$("#closeModal2").click(function() {
			$("#modal2").hide();
		})
		
		// 자산 그룹 삭제
		$(document).on("click","#grouptable tr .delGroup",function() {
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
							$("#modal2").hide();
							$("#modal").hide();
						} else if(x == "constraint") {
							alert("자산이 존재하는 자산 그룹은 삭제할 수 없습니다");
						} else {
							alert("다시 시도해주세요");
						}
					}
				})	
			}
			
		})
		
		// 자산 그룹 추가 버튼
		$("#insertGroup").click(function() {
			$("#modal3").show();
		})
		// 자산 그룹 추가 모달 닫기
		$("#closeModal3").click(function() {
			$("#modal3").hide();
		})
		// 자산 그룹 추가
		$("#insertGroup2").click(function() {
			var astgroup = $("#astgroup").val();
			
			// 자산 그룹 빈 값 확인
			var groupReg = RegExp(/^[a-zA-Z가-힣]{1,10}$/);
			
			if(!groupReg.test($("#astgroup").val())){ // 정규식에 맞지 않을 때
				$("#groupCheck p").attr("class", "warningMsg");
			} else {
				$("#groupCheck p").attr("class", "infoMsg");
				// 자산 그룹 중복 확인
				$.ajax({
					type : "post",
					url : "isOverlapGroup",
					data : {
						astgroup : astgroup,
						userid : userid
					},
					success : function(x) {
						if(x == "possible") {
							$.ajax({
								type : "post",
								url : "insertGroup",
								data : {
									astgroup : astgroup,
									userid : userid
								},
								success : function(x) {
									if(x == "success") {
										$("#modal3").hide();
										$("#modal2").hide();
										$("#modal").hide();
									} else {
										alert("다시 시도해주세요");
									}
								}
							})
						} else {
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
	<div class="">
		<!-- 사이드바 -->
		<div class="left-20">
			<jsp:include page="../main/sidebar.jsp"></jsp:include>
		</div>

		<!-- 컨텐츠 -->
		<div class="right-80">
			<%
			/* 로그인이 되어 있을 때*/
			if(session.getAttribute("userid") != null) { %>
				<h3 class="h3"><i class="fi fi-rr-coins"></i> 자산관리</h3>
				<button class="btn long gray" id="astGroupBtn">자산그룹</button>
				<div id="assetDiv">
				
				</div>
				
				<div class="modal" id="modal" hidden>
					<div class="modal-content">
						<div class="modal-title">
							<div>
								<h3 class="h3"><i class="fi fi-rr-coins"></i> 자산그룹 관리</h3>
							</div>
						</div>
						<button class="btn green" id="insertGroup" style="margin-left: 10px;">추가</button>
						<div class="modal-body">
							<div id="assetGroupDiv"></div>
						</div>
						<div class="modal-footer">
							<button class="btn outline-green" id="closeModal" style="float: right;">닫기</button>
						</div>
					</div>
				</div>
				<div class="modal" id="modal2" hidden>
					<div class="modal-content mini">
						<div class="modal-title">
							<h3 class="h3"><i class="fi fi-rr-coins"></i> 자산그룹 수정</h3>
						</div>
						<hr>
						<div class="modal-body mini">
							<div><p class="warningMsg">* 변경 시 관련된 자산의 자산 그룹 이름도 함께 변경됩니다*</p></div>
							<br>
							<div id="updateGroupDiv"></div>
						</div>
						<hr>
						<div class="modal-footer">
							<button class="btn outline-green" id="closeModal2" style="float: right;">닫기</button>
						</div>
					</div>
				</div>
				<div class="modal" id="modal3" hidden>
					<div class="modal-content mini">
						<div class="modal-title">
							<h3 class="h3"><i class="fi fi-rr-coins"></i> 자산그룹 추가</h3>
						</div>
						<hr>
						<div class="modal-body mini">
							<div id="insertGroupDiv">
								<div id="groupCheck"><p class='infoMsg'>영문이나 한글 1~10자만 입력 가능</p></div>
								<input type="text" class="signup-input" id="astgroup" maxlength="10">
								<button class="btn long green" id="insertGroup2">추가</button>
							</div>
						</div>
						<hr>
						<div class="modal-footer">
							<button class="btn outline-green" id="closeModal3" style="float: right;">닫기</button>
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