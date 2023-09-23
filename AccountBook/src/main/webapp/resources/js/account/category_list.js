$(function() {
	// 전체 카테고리 목록 가져오기
	// parameter : 아이디, 수입 카테고리 Div, 지출 카테고리 Div
	$.categoryList = function(userid, inListDiv, outListDiv) {
		$.ajax({
			type : "post",
			url : "../account/categoryInfo",
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
	
	// 카테고리 선택 모달 열기
	// parameter : 카테고리 선택 input ID, moneytype input name
	$.openSelectCate = function(cateID, mtypeName) {
		$(document).on("click", cateID, function() {
			var mtype = $("input[name=" + mtypeName + "]:checked").val(); // 선택된 값 변수에 저장
			if(mtype == "수입") {
				// 수입 카테고리 리스트 모달
				$("#select-incate-modal").show();
			} else {
				// 지출 카테고리 리스트 모달
				$("#select-outcate-modal").show();
			}
		})
	}
	
	// 카테고리 선택 시 수정 모달 input에 값 삽입
	// parameter : 선택한 행 ID, 값 넣을 input ID, 닫을 모달 ID
	$.pickCategory = function(selectID, inputID, modalID) {
		$(document).on("click", selectID, function() {
			originName = $(this).children().eq(1).text();
			$(inputID).attr("value", originName); // 수정 모달 input에 현재 이름 값 삽입
			$(modalID).hide();
		})
	}
})