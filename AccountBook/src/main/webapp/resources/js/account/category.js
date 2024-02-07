document.write('<script src="../resources/js/account/categoryFunc.js"></script>'); // 카테고리
document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 카테고리

$(function() {
	$(document).ready(function() {
		$.showCategory("수입", "#in-category-list-div");
		$.showCategory("지출", "#out-category-list-div");
	})
	
	// 수입 카테고리 추가
	$(document).on("click", "#add-income-btn", function() {
		$.addCategory("수입", "#income-catename");
	})
	
	// 지출 카테고리 추가
	$(document).on("click", "#add-spend-btn", function() {
		$.addCategory("지출", "#spend-catename");
	})
	
	// 카테고리 수정 가능
	$(document).on("dblclick", ".input-func", function() {
		var clickObj = $(this);
		$(this).attr("readonly", false);
		$(this).parent().children().eq(1).removeClass("hide");
		$(this).parent().children().eq(2).removeClass("hide");
		
		$(document).click(function(e) {
			if($(e.target).closest(clickObj).length == 0) { // 다른 영역 클릭 시 체크표시, 삭제표시 숨김
				$("#in-category-list-div button").addClass("hide");
				$("#out-category-list-div button").addClass("hide");
			}
		})
	})
	
	// 카테고리 수정
	$(document).on("click", "#update-btn", function() {
		var idVal = $(this).parent().parent().children().eq(0).text(); // 카테고리 id
		var typeVal = $(this).parent().parent().children().eq(1).text(); // 수입/지출
		var nameVal = $(this).parent().children().eq(0).val(); // 입력한 카테고리명
		
		if(!$.checkMustReg(nameVal)) { // 카테고리명 빈 값인지 확인
			alert("카테고리명을 확인해주세요.")
		} else {
			var chkName = $.overlapCategory(typeVal, nameVal, userid); // 카테고리 중복 확인
			if(chkName) {
				$.ajax({
					type : "post",
					url : "updateCategory",
					data : {
						categoryid : idVal,
						catename : nameVal,
						userid : userid
					},
					success : function(res) {
						if(res == true) { // 카테고리 수정 성공
							window.location.reload();
						} else { // 카테고리 수정 실패
							alert("다시 시도해주세요");
						}
					}
				})
			} else { // 카테고리가 중복되는 경우
				alert("중복되는 카테고리입니다.");
			}
		}
	})
	
	// 카테고리 삭제
	$(document).on("click", "#delete-btn", function() {
		var idVal = $(this).parent().parent().children().eq(0).text(); // 카테고리 id
		var op = confirm("정말로 삭제하시겠습니까?");
		if(op) {
			$.ajax({
				type : "post",
				url : "deleteCategory",
				data : {
					categoryid : idVal,
					userid : userid
				},
				success : function(res) {
					if(res == true) { // 카테고리 삭제 성공
						window.location.reload();
					} else { // 카테고리 삭제 실패
						alert("다시 시도해주세요");
					}
				}
			})
		}
	})
})