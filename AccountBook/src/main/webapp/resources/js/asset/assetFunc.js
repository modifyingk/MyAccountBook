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
/*
// 자산 선택 목록 html
function showSelectAsset(listDiv) {
	var list = assetnameList();
	var html = "<table class='select-table td-border tr-hover'>";
	for(let i = 0; i < list.length; i++) {
		html += "<tr><td>" + list[i] + "</td></tr>";
	}
	html += "</table>";
	$(listDiv).html(html);
}*/

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

// 자산 선택 및 값 자동 입력
function pickAsset(assetid, asset) {
	$(document).on("click", asset, function() {
		showSelectAsset(".select-asset-list");
		$(".select-asset-div").show();
	})
	$(document).on("click", ".select-asset-div tr", function() {
		var assetidVal = $(this).children().eq(0).text();
		var assetVal = $(this).children().eq(1).text();
		
		$(assetid).attr("value", assetidVal);
		$(asset).attr("value", assetVal);
		
		$(".select-asset-div").hide();
	})
}