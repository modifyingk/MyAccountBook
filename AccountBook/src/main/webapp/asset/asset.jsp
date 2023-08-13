<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-rounded/css/uicons-regular-rounded.css'>
<link rel='stylesheet' href='https://cdn-uicons.flaticon.com/uicons-regular-straight/css/uicons-regular-straight.css'>
<link rel="stylesheet" type="text/css" href="../resources/css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	$(function() {
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
						groupTable += "<tr><td style='border: 1px solid lightgray; border-radius: 10px; padding: 20px; width: 250px;'>" + group[i] + "</td><td><i class='fi fi-rr-square-x' style='color:gray;'></i></td></tr>";
					}
					groupTable += "</table>";
					$("#assetGroupDiv").html(groupTable);
				}
			})
			$("#modal").show();
		})
		
		$("#closeBtn").click(function() {
			$("#modal").hide();
		})
		$(document).on("click","#grouptable tr",function() {
			alert($(this).text());
			
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
							<h3 class="h3"><i class="fi fi-rr-coins"></i> 자산그룹 관리</h3>
						</div>
						<hr>
						<div class="modal-body">
							<div id="assetGroupDiv"></div>
						</div>
						<br>
						<div class="modal-footer">
							<button class="btn green" id="closeBtn" style="float: right;">닫기</button>
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