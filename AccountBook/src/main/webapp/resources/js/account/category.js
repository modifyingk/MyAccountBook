$(function() {
	// 전체 카테고리 목록 가져오기
	// parameter : 아이디, 수입 카테고리 Div, 지출 카테고리 Div
	$.categoryList = function(userid, inListDiv, outListDiv) {
		$.ajax({
			type : "post",
			url : "categoryInfo",
			data : {
				userid : userid
			},
			success : function(cateList) {
				var in_html = "<table class='modal-table' id='in-category-table' style='width: 100%;'>";

				for(let i = 0; i < cateList.length; i++) {
					if(cateList[i].moneytype == "수입") {
						in_html += "<tr><td style='display: none;'>" + cateList[i].moneytype + "</td>";
						in_html += "<td class='group-list is-border'>" + cateList[i].catename + "</td></tr>";
					}
				}
				in_html += "</table>";

				var out_html = "<table class='modal-table' id='out-category-table' style='width: 100%;'>";
				for(let i = 0; i < cateList.length; i++) {
					if(cateList[i].moneytype == "지출") {
						out_html += "<tr><td style='display: none;'>" + cateList[i].moneytype + "</td>";
						out_html += "<td class='group-list is-border'>" + cateList[i].catename + "</td></tr>";
					}
				}
				out_html += "</table>";
				
				$(inListDiv).html(in_html);
				$(outListDiv).html(out_html);
			}
		})
	}
	
	// 카테고리 중복 확인
	// parameter : #moneytype, #catename, 아이디
	$.overlapCategory = function(moneytype, catename, userid) {
		var result;
		$.ajax({ // 카테고리가 중복되는지 확인
			type : "post",
			url : "isOverlapCate",
			async : false,
			data : {
				moneytype : $(moneytype).val(),
				catename : $(catename).val(),
				userid : userid
			},
			success : function(x) {
				if(x == "possible") { // 카테고리가 중복되지 않는 경우
					result = true;
				} else {
					result = false;
				}
			}
		})
		return result;
	}
	
	// 카테고리 추가 모달 열기
	$(document).on("click", "#add-in-category-page", function() {
		$("#add-category-modal").show();
		$("#moneytype").attr("value", "수입");
	})	
	$(document).on("click", "#add-out-category-page", function() {
		$("#add-category-modal").show();
		$("#moneytype").attr("value", "지출");
	})	

	// 카테고리 수정 모달 열기
	$.openUpdateCate = function(docID) {
		$(document).on("click", docID, function() {
			originCate = $(this).children().eq(0).text();
			originName = $(this).children().eq(1).text();
			$("#up-moneytype").attr("value", originCate); // 수정 모달 input에 현재 분류 값 삽입
			$("#up-catename").attr("value", originName); // 수정 모달 input에 현재 이름 값 삽입
			
			$("#up-category-modal").show(); // 모달 열기
		})
	}
	
	// 카테고리 초기화
	// parameter : 초기화 버튼 ID, moneytype(수입/지출)
	$.resetCategory = function(btnID, mtype) {
		$(document).on("click", btnID, function() {
			var op = confirm("초기화 시 생성한 카테고리가 모두 삭제되고 기본값으로 설정됩니다. 정말로 초기화하시겠습니까?");
			if(op) {
				$.ajax({
					type : "post",
					url : "resetCate",
					data : {
						moneytype: mtype,
						userid: userid
					},
					success : function(x) {
						window.location.reload();
					}
				})
			}
		})
	}
	
	// 카테고리 추가
	$(document).on("click", "#add-category-btn", function() {
		chkCate = $.checkNaming("#catename", "#add-catename-check-div p"); // 카테고리명 형식 확인
		if(chkCate) {
			var chkName = $.overlapCategory("#moneytype", "#catename", userid); // 카테고리 중복 확인
			if(chkName) {
				$.ajax({
					type : "post",
					url : "insertCategory",
					data : {
						moneytype : $("#moneytype").val(),
						catename : $("#catename").val(),
						userid : userid
					},
					success : function(x) {
						if(x == "success") { // 카테고리 추가 성공
							window.location.reload();
						} else { // 카테고리 추가 실패
							alert("다시 시도해주세요");
						}
					}
				})
			} else { // 카테고리가 중복되는 경우
				alert("중복되는 카테고리입니다.");
			}
		}
	})
	
	// 카테고리 수정
	$(document).on("click", "#up-category-btn", function() { // 수정 버튼 클릭
		chkCate = $.checkNaming("#up-catename", "#up-catename-check-div p"); // 카테고리명 형식 확인
		if(chkCate) {
			var chkName = $.overlapCategory("#up-moneytype", "#up-catename", userid); // 카테고리 중복 확인
			if(chkName) {
				$.ajax({
					type : "post",
					url : "updateCategory",
					data : {
						originType : originCate,
						originName : originName,
						updateType : $("#up-moneytype").val(),
						updateName : $("#up-catename").val(),
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
			} else { // 카테고리가 중복되는 경우
				alert("중복되는 카테고리입니다.");
			}
		}
	})
	
	// 카테고리 추가/수정 시 moneytype 선택 모달
	$(document).on("click", "#moneytype, #up-moneytype", function() {
		$("#select-moneytype-modal").show();
		$("#in").click(function() {
			$("#moneytype").attr("value", "수입");
			$("#up-moneytype").attr("value", "수입");
			$("#select-moneytype-modal").hide();
		})
		$("#out").click(function() {
			$("#moneytype").attr("value", "지출");
			$("#up-moneytype").attr("value", "지출");
			$("#select-moneytype-modal").hide();
		})
	})
	
})