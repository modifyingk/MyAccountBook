$(function() {
	
	// 카테고리 중복 확인
	$.overlapCategory = function(moneytype, catename, userid) {
		var result;
		$.ajax({ // 카테고리가 중복되는지 확인
			type : "post",
			url : "overlapCategory",
			async : false,
			data : {
				moneytype : moneytype,
				catename : catename,
				userid : userid
			},
			success : function(res) {
				result = res;
			}
		})
		return result;
	}
	
	// 카테고리 목록 가져오기
	$.categoryList = function(typeVal) {
		var result;
		$.ajax({
			type : "post",
			url : "../account/categoryList",
			async : false,
			data : {
				moneytype : typeVal,
				userid : userid
			},
			success : function(res) {
				result = res;
			}
		})
		return result;
	}
	
	// 카테고리 목록 보여주기
	$.showCategory = function(typeVal, listDiv) {
		var list = $.categoryList(typeVal);
		var html = "<table class='select-table td-border tr-hover'>";
		
		for(let i = 0; i < list.length; i++) {
			html += "<tr><td class='hide'>" + list[i].categoryid + "</td>";
			html += "<td class='hide'>" + list[i].moneytype + "</td>";
			html += "<td><input class='input-func' value='" + list[i].catename + "' readonly>" +
					"<button class='check-btn hide' id='update-btn'><i class='fi fi-rr-check'></i></button>" +
					"<button class='cross-btn hide' id='delete-btn'><i class='fi fi-rr-cross'></i></button></td></tr>";
		}
		html += "</table>";
		$(listDiv).html(html);
	}
	
	// 카테고리 선택 목록 보여주기
	$.showSelectCategory = function(typeVal, listDiv) {
		var list = $.categoryList(typeVal);
		var html = "<table class='select-table td-border tr-hover'>";

		for(let i = 0; i < list.length; i++) {
			html += "<tr><td class='hide'>" + list[i].categoryid + "</td>";
			html += "<td>" + list[i].catename + "</td></tr>";
		}
		html += "</table>";
		$(listDiv).html(html);
		return html;
	}
	
	// 카테고리 추가
	$.addCategory = function(typeVal, inputID) {
		if(!$.checkMustReg($(inputID).val())) { // 카테고리명 빈 값인지 확인
			alert("카테고리명을 확인해주세요.")
		} else {
			var chkName = $.overlapCategory(typeVal, $(inputID).val(), userid); // 카테고리 중복 확인
			if(chkName) {
				$.ajax({
					type : "post",
					url : "insertCategory",
					data : {
						moneytype : typeVal,
						catename : $(inputID).val(),
						userid : userid
					},
					success : function(res) {
						if(res == true) { // 카테고리 추가 성공
							window.location.reload();
						} else { // 카테고리 추가 실패
							alert("다시 시도해주세요");
						}
					}
				})
			} else { // 카테고리가 중복되는 경우
				$(inputID).focus();
				$(inputID).val("");
				alert("중복되는 카테고리입니다.");
			}
		}
	}
	
	/*
	// 카테고리 선택 모달 열기
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
	$.pickCategory = function(selectID, inputID, modalID) {
		$(document).on("click", selectID, function() {
			originName = $(this).children().eq(1).text();
			$(inputID).attr("value", originName); // 수정 모달 input에 현재 이름 값 삽입
			$(modalID).hide();
		})
	}
	
	// 카테고리 수정 모달 열기
	$.openUpdateCate = function(docID) {
		$(document).on("click", docID, function() {
			originCate = $(this).children().eq(0).text();
			originName = $(this).children().eq(1).text();
			$("#up-moneytype").attr("value", originCate); // 수정 모달 input에 현재 분류 값 삽입
			$("#up-catename").attr("value", originName); // 수정 모달 input에 현재 이름 값 삽입
			
			$("#up-category-modal").show(); // 모달 열기
		})
	}
	
	// 카테고리 초기화
	// parameter : 초기화 버튼 ID, moneytype(수입/지출)
	$.resetCategory = function(btnID, mtype) {
		$(document).on("click", btnID, function() {
			var op = confirm("초기화 시 생성한 카테고리가 모두 삭제되고 기본값으로 설정됩니다. 정말로 초기화하시겠습니까?");
			if(op) {
				$.ajax({
					type : "post",
					url : "resetCate",
					data : {
						moneytype: mtype,
						userid: userid
					},
					success : function() {
						window.location.reload();
					}
				})
			}
		})
	}*/
	
})