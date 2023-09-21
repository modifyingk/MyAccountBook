$(function() {
	// 설정 열고 닫기
	// parameter : 클릭횟수 변수, 클릭 버튼 ID, 열고닫을 div ID
	$.settingDiv = function(clickNum, btnID, divID) {
		$(document).on("click", btnID, function() {
			clickNum++;
			if(clickNum % 2 != 0) {
				$(divID).show(); // 누르면 카테고리 버튼 보여주기
			} else {
				$(divID).hide(); // 한 번 더 누르면 카테고리 버튼 숨기기
			}
		})
	}
	
	// 모달 열기 함수
	// parameter : 닫기 버튼 ID, 닫을 모달 ID
	$.openModal = function(btnID, modalID) {
		$(document).on("click", btnID, function() {
			$(modalID).show();
		})
	}
	
	// 모달 닫기 함수
	// parameter : 닫기 버튼 ID, 닫을 모달 ID
	$.closeModal = function(btnID, modalID) {
		$(document).on("click", btnID, function() {
			$(modalID).hide();
		})
	}
})