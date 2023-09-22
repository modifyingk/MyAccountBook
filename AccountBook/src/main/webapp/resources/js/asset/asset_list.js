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
	
	$.assetAllList = function(userid) {
		// 전체 자산 목록 및 금액 그룹별로 가져오기
		$.ajax({
			type : "post",
			url : "assetInfo",
			dataType : "json",
			data : {
				userid : userid
			},
			success : function(map) {
				var total = 0;
				var html = "<table class='modal-table' style='width: 500px;'>"; // 자산 목록 테이블 만들기
				for(var key in map ) {
					html += "<tr><td>" + key + "</td></tr>"; // key 값인 자산 그룹 이름 출력
					var value = map[key].split(","); // 자산 그룹에 해당하는 자산이 여러 개이면 ,로 구분되어 있으므로 ,를 기준으로 분리하여 value 변수에 저장
					
					for(var i = 0; i < value.length; i++) {
						var asset = value[i].split("#"); // 자산이름, 자산메모, 금액은 #로 구분되어 있으므로 #을 기준으로 분리하여 asset 변수에 저장
						html += "<tr class='asset-name'><td class='group-list is-border td-detail'><div class='col-5'>" + asset[0] + "</div>"; // asset[0]은 자산 이름
						
						if(parseInt(asset[2]) < 0) { // 금액이 음수면 빨간색으로 출력 
							html += "<div class='col-5 text-right red'>" + parseInt(asset[2]).toLocaleString() + "원</div></td>"
							total += parseInt(asset[2]);
						} else { // 금액이 양수면 파란색으로 출력 
							html += "<div class='col-5 text-right blue'>" + parseInt(asset[2]).toLocaleString() + "원</div></td>"
							total += parseInt(asset[2]);
						}
						
						html += "<td style='display:none;'>" + key + "</td>"; // key는 자산 그룹 (클릭 시 값 넘기기 위한 것으로, 화면에는 보이지 않도록 생성)
						html += "<td style='display:none;'>" + asset[1] + "</td>"; // asset[1]은 자산 메모 (클릭 시 값 넘기기 위한 것으로, 화면에는 보이지 않도록 생성)
						html += "<td class='update-btn' id='up-asset-page'><button class='update-icon'><i class='fi fi-rr-pencil fs-23'></i></button></td></tr>"; // 자산 수정 버튼
					}
					html += "<tr><td></td></tr>";
				}
				html += "</table>";
				$("#asset-total-div").html("<i class='h-normal fs-23 info'>합계</i><i class='h-normal fs-23'>" + total.toLocaleString() + "원</i>");
				$("#asset-list-div").html(html);
			}
		})
	}
})