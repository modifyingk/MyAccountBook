$(function() {
	// 수입 소분류 목록
	$.incategoryList = function() {
		var result;
		$.ajax({
			type: "post",
			url: "../account/incategoryList",
			async: false,
			data : {
				userid: userid
			},
			success: function(res) {
				result = res;
			}
		})
		return result;
	}
	
	// 수입 소분류 목록 html
	$.showIncategory = function() {
		var list = $.incategoryList();
		for(let i = 0; i < list.length; i++) {
			$.checkIncate(list[i].categoryid, list[i].bigcate, list[i].smallcate);
		}
	}
	
	// 지출 소분류 목록
	$.outcategoryList = function() {
		var result;
		$.ajax({
			type: "post",
			url: "../account/outcategoryList",
			async: false,
			data : {
				userid: userid
			},
			success: function(res) {
				result = res;
			}
		})
		return result;
	}
	
	// 지출 소분류 목록 html
	$.showOutcategory = function() {
		let list = $.outcategoryList();
		for(let i = 0; i < list.length; i++) {
			$.checkOutcate(list[i].categoryid, list[i].bigcate, list[i].smallcate);
		}
	}
	
	// 카테고리 중복 확인
	$.overlapCategory = function(cateVal, mtype) {
		var result;
		$.ajax({ // 카테고리가 중복되는지 확인
			type: "post",
			url: "overlapCategory",
			async: false,
			data: {
				smallcate: cateVal,
				userid: userid,
				mtype: mtype
			},
			success: function(res) {
				result = res;
			}
		})
		return result;
	}
	
	// 수입 소분류 판단
	$.checkIncate = function(categoryid, bigVal, smallVal) {
		let list_html = "<tr><td class='hide'>" + categoryid + "</td>" +
		"<td><div class='is-border'><input class='input inner update' value='" + smallVal + "'>" +
		"<button class='update-btn check-btn hide' id='update-btn'><i class='fi fi-rr-check'></i></button>" +
		"<button class='update-btn cross-btn hide' id='delete-btn'><i class='fi fi-rr-cross'></i></button></div></td></tr>";
		
		if(bigVal == "소득") {
			$("#income-t1").append(list_html);
		} else if(bigVal == "저축") {
			$("#income-t2").append(list_html);
		} else {
			$("#income-t3").append(list_html);
		}
	}
	
	// 지출 소분류 판단
	$.checkOutcate = function(categoryid, bigVal, smallVal) {
		let list_html = "<tr><td class='hide'>" + categoryid + "</td>" +
		"<td><div class='is-border'><input class='input inner update' value='" + smallVal + "'>" +
		"<button class='update-btn check-btn hide' id='update-btn'><i class='fi fi-rr-check'></i></button>" +
		"<button class='update-btn cross-btn hide' id='delete-btn'><i class='fi fi-rr-cross'></i></button></div></td></tr>";
		
		if(bigVal == "식비") {
			$("#spend-t1").append(list_html);
		} else if(bigVal == "문화/여가") {
			$("#spend-t2").append(list_html);
		} else if(bigVal == "패션/뷰티") {
			$("#spend-t3").append(list_html);
		} else if(bigVal == "공과금") {
			$("#spend-t4").append(list_html);
		} else if(bigVal == "마트/편의점") {
			$("#spend-t5").append(list_html);
		} else if(bigVal == "주거/통신") {
			$("#spend-t6").append(list_html);
		} else if(bigVal == "의료/건강") {
			$("#spend-t7").append(list_html);
		} else if(bigVal == "교육") {
			$("#spend-t8").append(list_html);
		} else if(bigVal == "생활용품") {
			$("#spend-t9").append(list_html);
		} else if(bigVal == "교통/차량") {
			$("#spend-t10").append(list_html);
		} else if(bigVal == "선물/경조사") {
			$("#spend-t11").append(list_html);
		} else {
			$("#spend-t12").append(list_html);
		}
	}
	
	// 카테고리 추가
	$.insertCategory = function(bigVal, smallVal, mtype) {
		$.ajax({
			type: "post",
			url: "insertCategory",
			data: {
				bigcate: bigVal,
				smallcate: smallVal,
				userid: userid,
				mtype: mtype
			},
			success: function(res) {
				if(res > 0) {
					if(mtype == "수입")
						$.checkIncate(res, bigVal, smallVal);
					else {
						$.checkOutcate(res, bigVal, smallVal);
					}
				} else {
					alert("다시 시도해주세요.");
				}
			}
		})
	}
	
	// 카테고리 수정
	$.updateCategory = function(idVal, cateVal, mtype) {
		$.ajax({
			type: "post",
			url: "updateCategory",
			data: {
				categoryid: idVal,
				smallcate: cateVal,
				userid: userid,
				mtype: mtype
			},
			success: function(res) {
				if(res != true) { // 카테고리 수정 실패
					alert("다시 시도해주세요");
				}
			}
		})
	}
	/*
	
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
	*/
	
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