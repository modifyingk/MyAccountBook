document.write('<script src="../resources/js/account/categoryFunc.js"></script>'); // 카테고리
document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 카테고리

$(function() {
	$(document).ready(function() {
		$.showIncategory(); // 수입 소분류 목록 보여주기
		$.showOutcategory(); // 수입 소분류 목록 보여주기
	})
	
	// 수입 카테고리 목록
	$(document).on("click", "#select-in", function() {
		$("#select-out").removeClass("active");
		$("#select-in").addClass("active");
		$("#outcategory-list").hide();
		$("#incategory-list").show();
	})
	
	// 지출 카테고리 목록
	$(document).on("click", "#select-out", function() {
		$("#select-in").removeClass("active");
		$("#select-out").addClass("active");
		$("#incategory-list").hide();
		$("#outcategory-list").show();
	})
	
	// 카테고리 추가
	$(document).on("click", "#add-btn", function() {
		let bigcate = $(this).closest("table").children().eq(0).children().children().children().eq(0).text();
		let smallcate = $(this).closest("td").children().eq(0).children().eq(1).children().val();
		let divName = $(this).closest("table").parent().attr("class");
		let mtype;
		if(divName == "incategory-div") {
			mtype = "수입";
		} else {
			mtype = "지출";
		}
		
		if(!$.checkMustReg(smallcate)) { // 카테고리명 빈 값인지 확인
			alert("카테고리명을 확인해주세요.")
		} else {
			let chkName = $.overlapCategory(smallcate, mtype); // 카테고리 중복 확인
			if(chkName) {
				$.insertCategory(bigcate, smallcate, mtype);
			} else { // 카테고리가 중복되는 경우
				alert("중복되는 카테고리입니다.");
			}
			$(this).closest("td").children().eq(0).children().eq(1).children().val("");
		}
	})
	
	// 카테고리 수정 가능
	$(document).on("click", ".input.inner.update", function() {
		let clickObj = $(this);
		$(this).parent().children().eq(1).removeClass("hide");
		$(this).parent().children().eq(2).removeClass("hide");
		
		$(document).click(function(e) {
			if($(e.target).closest(clickObj).length == 0) { // 다른 영역 클릭 시 체크표시, 삭제표시 숨김
				clickObj.parent().children().eq(1).addClass("hide");
				clickObj.parent().children().eq(2).addClass("hide");
			}
		})
	})
	
	// 수입 카테고리 수정
	$(document).on("click", "#update-btn", function() {
		let categoryid = $(this).closest("tr").children().eq(0).text();
		let smallcate = $(this).closest("td").children().children().val();
		let mtype;
		
		let divName = $(this).closest("table").parent().attr("class");
		if(divName == "incategory-div") {
			mtype = "수입";
		} else {
			mtype = "지출";
		}
		
		if(!$.checkMustReg(smallcate)) { // 카테고리명 빈 값인지 확인
			alert("카테고리명을 확인해주세요.")
		} else {
			let chkName = $.overlapCategory(smallcate, mtype); // 카테고리 중복 확인
			if(chkName) {
				$.updateCategory(categoryid, smallcate, mtype);
			} else { // 카테고리가 중복되는 경우
				alert("중복되는 카테고리입니다.");
			}
		}
	})
	
	// 카테고리 삭제
	$(document).on("click", "#delete-btn", function() {
		let categoryid = $(this).closest("tr").children().eq(0).text();
		let mtype;
		
		let divName = $(this).closest("table").parent().attr("class");
		if(divName == "incategory-div") {
			mtype = "수입";
		} else {
			mtype = "지출";
		}

		
		var op = confirm("정말로 삭제하시겠습니까?");
		if(op) {
			$(this).closest("tr").remove();
			$.ajax({
				type : "post",
				url : "deleteCategory",
				data : {
					categoryid: categoryid,
					userid: userid,
					mtype: mtype
				},
				success : function(res) {
					if(res == true) { // 카테고리 삭제 성공
					} else { // 카테고리 삭제 실패
						alert("다시 시도해주세요");
					}
				}
			})
		}
	})
})