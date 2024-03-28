// 자산이름 가져오기
function showSelectAsset(listDiv) {
	$.ajax({
		type : "post",
		url : "../asset/selectAssetName",
		async : false,
		data : {
			userid : userid,
		},
		success : function(res) {
			$(listDiv).html(res);
		}
	})
}

// 자산 그룹 선택 및 값 자동 입력
function pickGroup(groupID) {
	$(document).on("click", groupID, function() { // 자산그룹 선택 클릭 시
		$(".select-group-div").show(); // 자산그룹 선택 div 열기
	})
	$(document).on("click", "#asset-group-table td", function() {
		var idx = $(this).parent().index();
		var option = $("#asset-group-table td").eq(idx).text();
		$(groupID).attr("value", option); // input에 값 삽입
		$(".select-group-div").hide();
	})
}