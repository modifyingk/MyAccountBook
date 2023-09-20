$(function() {
	$.categoryList = function(userid, inListDiv, outListDiv) {
		// 전체 카테고리 목록 가져오기
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
				//$("#select-incate-list-div").html(in_html);
				//$("#select-outcate-list-div").html(out_html);
			}
		})
	}
})