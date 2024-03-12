// 모달 열기 함수
function openModal(btnID, modalID) {
	$(document).on("click", btnID, function() {
		$(modalID).show();
	})
}

//모달 닫기 함수
function closeModal(btnID, modalID) {
	$(document).on("click", btnID, function() {
		$(modalID).hide();
	})
}

//다른 영역 클릭 시 자동 창 닫기
function autoClose(docID) {
	$(document).mouseup(function (e) {
		var closeDoc = $(docID);
		if (closeDoc.has(e.target).length === 0) {
			closeDoc.hide();
		}
	});
}