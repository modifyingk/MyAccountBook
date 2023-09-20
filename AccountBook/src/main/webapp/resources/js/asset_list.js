$(function() {
	$.assetList = function(userid, listDiv) {
		// 전체 자산 목록 가져오기
		$.ajax({
			type : "post",
			url : "../asset/assetInfo",
			dataType : "json",
			data : {
				userid : userid
			},
			success : function(map) {
				var html = "<table class='modal-table' id='asset-table'>"; // 자산 목록 테이블 만들기
				for(var key in map ) {
					var value = map[key].split(","); // 자산 그룹에 해당하는 자산이 여러 개이면 ,로 구분되어 있으므로 ,를 기준으로 분리하여 value 변수에 저장
					for(var i = 0; i < value.length; i++) {
						var asset = value[i].split("#"); // 자산이름과 자산메모는 #로 구분되어 있으므로 #를 기준으로 분리하여 asset 변수에 저장
							html += "<tr class='asset-name'><td class='group-list is-border'>" + asset[0] + "</td></tr>"; // asset[0]은 자산 이름
					}
				}
				html += "</table>";
				$(listDiv).html(html);
			}
		})
	}
})