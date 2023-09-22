$(function() {
	// 자산 그룹 목록 보기
	$.astgroupList = function() {
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
	}
	
	// 자산 그룹 중복 확인
	$.overlapGroup = function(astgroupID) {
		var result;
		$.ajax({
			type : "post",
			url : "isOverlapGroup",
			async : false,
			data : {
				astgroup : $(astgroupID).val(),
				userid : userid
			},
			success : function(x) {
				if(x == "possible") { // 자산 그룹 이름이 중복되지 않으면 해당 이름으로 수정
					result = true;
				} else {
					result = false;
				}
			}
		})
		return result;
	}
	
	// 자산 그룹 추가 모달 열기
	$(document).on("click", "#add-group-page", function() {
		$("#add-group-modal").show();
		$("#astgroup").focus();
	})
	
	// 자산 그룹 추가
	$(document).on("click", "#add-group-btn", function() {
		var chkGroup = $.checkNaming("#astgroup", "#add-group-check p");
		if(chkGroup) {
			var chkName = $.overlapGroup();
			if(chkName) {
				$.ajax({
					type : "post",
					url : "insertGroup",
					data : {
						astgroup : $("#astgroup").val(),
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
			} else {
				alert("중복되는 자산 그룹 이름입니다");
			}
		}
		
	})
	
	// 자산 그룹 수정 모달 열기
	$(document).on("click","#astgroup-table tr .group-list",function() { // 수정하려는 자산 그룹(테이블 행) 클릭 시
		originGroup = $(this).text(); // 클릭한 자산 그룹명 변수에 저장 및 자동 입력
		$("#up-group-name").attr("value", originGroup);

		$("#up-group-modal").show();
		$("#up-group-name").focus();
	})
	
	// 자산 그룹 수정
	$(document).on("click", "#up-group-btn", function() {
		var chkGroup = $.checkNaming("#up-group-name", "#up-group-check p");
		if(chkGroup) {
			var chkName = $.overlapGroup();
			if(chkName) {
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
			} else {
				alert("중복되는 자산 그룹 이름입니다");
			}
		}
	})
	
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
})