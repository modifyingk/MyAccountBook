document.write('<script src="../resources/js/account/account_list.js"></script>'); // 수입/지출 내역, 통계 js
document.write('<script src="../resources/js/account/category.js"></script>'); // 카테고리 js
document.write('<script src="../resources/js/account/asset_list.js"></script>'); // 자산 목록 js
document.write('<script src="../resources/js/cal_date.js"></script>'); // 이전 달, 다음 달 구하기 js
document.write('<script src="../resources/js/reg_exp.js"></script>'); // 정규식 js
document.write('<script src="../resources/js/main.js"></script>'); // 모달 및 카테고리 설정 js

$(function() {
	var todayAll; // 현재 날짜 저장할 변수
	
	/* 카테고리 수정 모달 열기  변수 */
	var originCate; // 원래 카테고리명
	var originName; // 원래 이름
	
	var clickNum = 0; // 설정 클릭 횟수 (횟수에 따라 설정 열고 닫음)
	
	// 자산 선택 및 값 자동 입력
	// parameter : 자산 선택 input ID
	$.pickAsset = function(assetID) {
		// 수입/지출 추가 - 자산 선택
		$(document).on("click", assetID, function() { // 자산선택 클릭 시
			$("#select-asset-modal").show(); // 자산 선택 모달 열기
		})
		// 자산 선택 시 input에 값 삽입
		$(document).on("click", "#asset-table tr", function() {
			var assetName = $(this).text();
			$(assetID).attr("value", assetName);
			$("#select-asset-modal").hide();
		})
	}
	
	// 카테고리 선택 모달 열기
	// parameter : 카테고리 선택 input ID, moneytype input name
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
	// parameter : 선택한 행 ID, 값 넣을 input ID, 닫을 모달 ID
	$.pickCategory = function(selectID, inputID, modalID) {
		$(document).on("click", selectID, function() {
			originName = $(this).children().eq(1).text();
			$(inputID).attr("value", originName); // 수정 모달 input에 현재 이름 값 삽입
			$(modalID).hide();
		})
	}
	
	// moneytype radio 값 변경 시 카테고리 재선택
	// parameter : 카테고리 선택 input ID, moneytype input name
	$.chgMtype = function(cateID, mtypeName) {
		$(document).on("click", "input:radio[name=" + mtypeName + "]", function() {
			$(cateID).attr("value", "");
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
	
	// 전체, 수입만, 지출만 버튼 활성화
	// parameter : active 지울 요소 ID 1, active 지울 요소 ID 2, 활성화할 요소 ID
	$.activeBtn = function(removeDoc1, removeDoc2, addDoc) {
		if($(removeDoc1).hasClass("active")) {
			$(removeDoc1).removeClass("active");
			$(addDoc).addClass("active");
		} else if($(removeDoc2).hasClass("active")) {
			$(removeDoc2).removeClass("active");
			$(addDoc).addClass("active");
		}
	}
	
	$(document).ready(function() {
		// 현재 날짜 가져오기
		todayAll = $.currentYM();

		// 월별로 수입/지출 목록 가져오기
		$.accountList("monthAccount", todayAll, userid, "#month-div", "#month-account-list-div", "#total-div", "#total-income-div", "#total-spend-div");
		$.accountStats(todayAll, userid, "#category-stats-div");
		
		// 금액에 숫자만 입력되도록
		$.onlyNum("#up-acttotal");
		$.onlyNum("#add-acttotal");
		
		// 금액 세 자리마다 콤마
		$.moneyFmt("#up-acttotal");
		$.moneyFmt("#add-acttotal");
		
		// 수입/지출 추가 및 수정의 내용, 메모에 #이 들어가지 않도록
		$.noHash("#add-actcontent");
		$.noHash("#add-actmemo");
		$.noHash("#up-actcontent");
		$.noHash("#up-actmemo");
		
		// 카테고리 설정 열고 닫기 (우측 상단 설정 버튼)
		$.settingDiv(clickNum, "#open-cate-setting", "#cate-setting");
		
		// 카테고리 목록 가져오기
		$.categoryList(userid, "#in-category-list-div", "#out-category-list-div"); // 카테고리 목록
		$.categoryList(userid, "#select-incate-list-div", "#select-outcate-list-div"); // 카테고리 선택 모달
		
		// 자산 목록 가져오기
		$.assetList(userid, "#asset-list-div");
		
		// 카테고리 수정 모달 열기 및 자동 입력
		$.openUpdateCate("#in-category-list-div #in-category-table tr");
		$.openUpdateCate("#out-category-list-div #out-category-table tr");
		
		// 모달 열기
		$.openModal("#in-category-btn", "#in-category-modal"); // 수입 카테고리 모달 열기
		$.openModal("#out-category-btn", "#out-category-modal"); // 지출 카테고리 모달 열기
		$.openModal("#bookmark-page", "#bookmark-modal"); // 즐겨찾기 모달 열기
		$.openModal("#add-bookmark-page", "#add-bookmark-modal"); // 즐겨찾기 추가 모달 열기

		// 모달 닫기
		$.closeModal("#close-in-category", "#in-category-modal"); // 수입 카테고리 모달 닫기
		$.closeModal("#close-out-category", "#out-category-modal"); // 지출 카테고리 모달 닫기
		$.closeModal("#close-add-category", "#add-category-modal"); // 카테고리 추가 모달 닫기
		$.closeModal("#close-up-category", "#up-category-modal"); // 카테고리 수정 모달 닫기
		$.closeModal("#close-select-moneytype", "#select-moneytype-modal"); // 카테고리 추가/수정 시 moneytype 선택 모달 닫기
		$.closeModal("#close-select-incate", "#select-incate-modal"); // 수입 카테고리 선택 모달 닫기
		$.closeModal("#close-select-outcate", "#select-outcate-modal"); // 지출 카테고리 선택 모달 닫기
		$.closeModal("#close-select-asset", "#select-asset-modal"); // 자산 선택 모달 닫기
		$.closeModal("#close-add-account", "#add-account-modal"); // 수입/지출 추가 모달 닫기
		$.closeModal("#close-up-account", "#up-account-modal"); // 수입/지출 수정 모달 닫기
		$.closeModal("#close-catespend", "#catespend-modal"); // 카테고리별 지출 내역 모달 닫기
		$.closeModal("#close-bookmark", "#bookmark-modal"); // 즐겨찾기 모달 닫기
		$.closeModal("#close-add-bookmark", "#add-bookmark-modal"); // 즐겨찾기 추가 모달 닫기
		
		// 카테고리 초기화
		$.resetCategory("#reset-incate-btn", "수입"); // 수입 카테고리 초기화
		$.resetCategory("#reset-outcate-btn", "지출"); // 지출 카테고리 초기화
		
		// 자산 선택 및 값 자동 입력
		$.pickAsset("#add-actasset");
		$.pickAsset("#up-actasset");
		
		// 카테고리 선택 및 값 자동 입력 (수입/지출 추가)
		$.openSelectCate("#add-actcatename", "select-mtype"); // 카테고리 선택 모달 열기
		$.pickCategory("#select-incate-list-div #in-category-table tr", "#add-actcatename", "#select-outcate-modal"); // 수입 카테고리 선택
		$.pickCategory("#select-outcate-list-div #out-category-table tr", "#add-actcatename", "#select-outcate-modal"); // 지출 카테고리 선택

		// 카테고리 선택 및 값 자동 입력 (수입/지출 수정)
		$.openSelectCate("#up-actcatename", "up-mtype"); // 카테고리 선택 모달 열기
		$.pickCategory("#select-incate-list-div #in-category-table tr", "#up-actcatename", "#select-incate-modal"); // 수입 카테고리 선택
		$.pickCategory("#select-outcate-list-div #out-category-table tr", "#up-actcatename", "#select-outcate-modal"); // 지출 카테고리 선택
		
		// moneytype radio 값 변경 시 카테고리 재선택
		$.chgMtype("#add-actcatename", "select-mtype");
		$.chgMtype("#up-actcatename", "up-mtype");
	})
	
	// 이전 달 클릭
	$(document).on("click", "#before", function() {
		$.activeBtn("#in-account-btn", "#out-account-btn", "#total-account-btn"); // 전체 보기 버튼 활성화
		todayAll = $.beforeDate(todayAll); // 날짜 이전 달로 setting
		$.accountList("monthAccount", todayAll, userid, "#month-div", "#month-account-list-div", "#total-div", "#total-income-div", "#total-spend-div");
		$.accountStats(todayAll, userid, "#category-stats-div");
	})
	
	// 다음 달 클릭
	$(document).on("click", "#after", function() {
		$.activeBtn("#in-account-btn", "#out-account-btn", "#total-account-btn"); // 전체 보기 버튼 활성화
		todayAll = $.afterDate(todayAll); // 날짜 다음 달로 setting
		$.accountList("monthAccount", todayAll, userid, "#month-div", "#month-account-list-div", "#total-div", "#total-income-div", "#total-spend-div");
		$.accountStats(todayAll, userid, "#category-stats-div");
	})
	
	// 전체 내역 보기 클릭
	$(document).on("click", "#total-account-btn", function() {
		$.activeBtn("#in-account-btn", "#out-account-btn", "#total-account-btn"); // 전체 보기 버튼 활성화
		$.accountList("monthAccount", todayAll, userid, "#month-div", "#month-account-list-div", "#total-div", "#total-income-div", "#total-spend-div");
	})
	
	// 수입 내역만 보기 클릭
	$(document).on("click", "#in-account-btn", function() {
		$.activeBtn("#total-account-btn", "#out-account-btn", "#in-account-btn"); // 수입만 보기 버튼 활성화
		$.accountList("monthIncome", todayAll, userid, "", "#month-account-list-div", "", "", "");
	})
	
	// 지출 내역만 보기 클릭
	$(document).on("click", "#out-account-btn", function() {
		$.activeBtn("#total-account-btn", "#in-account-btn", "#out-account-btn"); // 지출만 보기 버튼 활성화
		$.accountList("monthSpend", todayAll, userid, "", "#month-account-list-div", "", "", "");
	})
	
	// 수입/지출 추가 모달 열기
	$(document).on("click", "#add-account-page", function() {
		// 현재 날짜 가져오기
		var dateValue = $.currentDate();

		// 자산, 카테고리 값 다 비우고 추가 (수입/지출내역 수정할 때 자산, 카테고리 선택하면 같이 변경되므로)
		$("#add-actdate").attr("value", dateValue);
		$("#add-actasset").attr("value", "");
		$("#add-actcatename").attr("value", "");
		$("#add-actcontent").attr("value", "");
		$("#add-acttotal").attr("value", "");
		

		$("#add-account-modal").show();
	})
	
	// 수입/지출 추가
	$(document).on("click", "#add-account-btn", function() {
		var mtype = $("input[name=select-mtype]:checked").val();
		if(!$.noEmpty("#add-actdate") || !$.noEmpty("#add-actasset") || !$.noEmpty("#add-actcatename") || !$.noEmpty("#add-acttotal")){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			$.ajax({
				type : "post",
				url : "insertAccount",
				data : {
					date : $("#add-actdate").val(),
					moneytype : mtype,
					astname : $("#add-actasset").val(),
					catename : $("#add-actcatename").val(),
					total : $("#add-acttotal").val().replaceAll(",", ""),
					content : $("#add-actcontent").val(),
					memo : $("#add-actmemo").val(),
					userid : userid
				},
				success : function(x) { // 수입/지출 추가 시 포인트 적립
					if(x == "success") {
						$.ajax({
							type : "post",
							url : "../member/updatePoint",
							data : {
								point : 10,
								userid : userid
							},
							success : function(y) {
								if(y == "success") {
									alert("가계부를 기록하여 10P가 적립되었습니다.");
									window.location.reload();
								}
							}
						})
					} else {
						alert("다시 시도해주세요.")
					}
				}
			})
		}
	})
	
	// 수입/지출 내역 테이블에서 날짜 tr 클릭 시
	$(document).on("click", ".tr-date", function() {
		var date = $(this).text();
		$("#add-account-modal").show();
		$("#add-actdate").attr("value", date);
	})
	
	// 수입/지출 내역 테이블에서 내용 tr 클릭 시
	$(document).on("click", ".tr-content", function() {
		var actdate = $(this).children().eq(0).text();
		var actid = $(this).children().eq(1).text();
		var actmoneytype = $(this).children().eq(2).text();
		var actasset = $(this).children().eq(4).children().eq(1).text();
		var actcatename = $(this).children().eq(3).text();
		var actcontent = $(this).children().eq(4).children().eq(0).text();
		var acttotal = $(this).children().eq(5).text();
		var actmemo = $(this).children().eq(6).text();
		
		$("#up-account-modal").show(); // 수입/지출 내역 수정 모달 열기

		// 수정 모달 값 setting
		$("#up-actdate").attr("value", actdate);
		$("#up-actid").attr("value", actid);
		$("#up-actasset").attr("value", actasset);
		$("#up-actcatename").attr("value", actcatename);
		$("#up-actcontent").attr("value", actcontent);
		$("#up-acttotal").attr("value", acttotal.split("원")[0]);
		$("#up-actmemo").html(actmemo);
		
		if(actmoneytype == "수입") {
			$("input:radio[name='up-mtype'][value='수입']").attr("checked", true);
		} else {
			$("input:radio[name='up-mtype'][value='지출']").attr("checked", true);
		}
	})
	
	// 수입/지출 수정
	$(document).on("click", "#up-account-btn", function() {
		if(!$.noEmpty("#up-actdate") || !$.noEmpty("#up-actasset") || !$.noEmpty("#up-actcatename") || !$.noEmpty("#up-acttotal")){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			$.ajax({
				type : "post",
				url : "updateAccount",
				data : {
					moneytype :  $("input[name=up-mtype]:checked").val(),
					date : $("#up-actdate").val(),
					astname : $("#up-actasset").val(),
					catename : $("#up-actcatename").val(),
					content : $("#up-actcontent").val(),
					total : ($("#up-acttotal").val()).replaceAll(",", ""),
					memo : $("#up-actmemo").val(),
					accountid : $("#up-actid").val(),
					userid : userid
				},
				success : function(x) {
					if(x == "success") {
						window.location.reload();
					} else {
						alert("다시 시도해주세요.");
					}
				}
			})
		}
	})
	
	// 수입/지출 삭제
	$(document).on("click", "#del-account-btn", function() {
		var op = confirm("내역을 삭제하시겠습니까?")
		if(op) {
			$.ajax({
				type : "post",
				url : "deleteAccount",
				data : {
					accountid : $("#up-actid").val(),
					userid : userid
				},
				success : function(x) {
					if(x == "success") {
						window.location.reload();
					} else {
						alert("다시 시도해주세요.");
					}
				}
			})
		}
	})
	
	// 통계 카테고리 클릭 시 해당 카테고리 지출 내역
	$(document).on("click", ".tr-statscate", function() {
		var catename = $(this).children().eq(0).text();
		$.ajax({
			type : "post",
			url : "monthCateSpend",
			data : {
				catename : catename,
				date : todayAll,
				userid : userid
			},
			success : function(map) {
				if(Object.keys(map) != "no") {
					var spend_total = 0;
					var catepend_html = "<table class='list-table'>";
						
					for(var key in map) {
						catepend_html += "<tr class='tr-date'><td colspan='5' style='font-weight: bold;'>" + key + "</td></tr>";
						var value = map[key].split(",");
						for(var i = 0; i < value.length; i++) {
							var account = value[i].split("#");
							catepend_html += "<tr class='tr-content'><td style='display:none;'>" + key + "</td>"; // 날짜
							catepend_html += "<td style='display:none;'>" + account[0] + "</td>"; // 수입/지출 ID
							catepend_html += "<td style='display:none;'>" + account[1] + "</td>"; // 수입 또는 지출(moneytype)
							catepend_html += "<td>" + account[3] + "</td>"; // 카테고리
							catepend_html += "<td><div>" + account[4] + "</div><div><span class='fs-16 info'>" + account[2] + "</span></div></td>"; // 내용, 자산
							catepend_html += "<td class='text-right red'>" + parseInt(account[5]).toLocaleString() + "원</td>";
							spend_total += parseInt(account[5]);
							catepend_html += "<td style='display:none;'>" + account[6].toLocaleString() + "</td></tr>"; // 메모
						}
						catepend_html += "<tr style='border : 0;'></tr>";
					}
					catepend_html += "</table>";
						
				} else {
					var catepend_html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
				}
				$("#catespend-total-div").html("<h4 class='h-normal fs-23'>총 지출 <i class='red h-normal fs-20'>" + spend_total.toLocaleString() + "원</i></h4><br>");
				$("#catename-div").html("<h3 class='h-normal fs-28'><i class='fi fi-rr-money-check-edit'></i> " + catename + "</h3>");
				$("#catespend-list-div").html(catepend_html);
			}
		})
		$("#catespend-modal").show();
	})
	
	/* 즐겨찾기 */
	// 즐겨찾기에 추가 가능한 내역 가져오기
	$.ajax({
		type : "post",
		url : "addBookmarkInfo",
		data : {
			userid : userid
		},
		success : function(addmarkList) {
			var addmark_html = "<table class='list-table' style='width:450px;'>";
			for(var i = 0; i < addmarkList.length; i++) {
				addmark_html += "<tr class='tr-addmark'><td>" + addmarkList[i].catename + "</td>";
				addmark_html += "<td>" + addmarkList[i].content + "</td>";
				addmark_html += "<td class='text-right red'>" + parseInt(addmarkList[i].total).toLocaleString() + "원</td></tr>";
			}
			addmark_html += "</table>";
			$("#add-bookmark-list-div").html(addmark_html);
		}
	})
	
	// 즐겨찾기 내역 tr 클릭 시 즐겨찾기에 추가
	$(document).on("click", ".tr-addmark", function() {
		var catename = $(this).children().eq(0).text();
		var content = $(this).children().eq(1).text();
		var total = ($(this).children().eq(2).text().split("원")[0]).replaceAll(",", "");
		
		// 즐겨찾기 추가
		$.ajax({
			type : "post",
			url : "insertBookmark",
			data : {
				catename : catename,
				content : content,
				total : total,
				userid : userid
			},
			success : function(x) {
				if(x == "success") {
					window.location.reload();
				} else {
					alert("즐겨찾기 추가에 실패하였습니다.")
				}
			}
		})
	})
	
	// 즐겨찾기 리스트
	$.ajax({
		type : "post",
		url : "bookmarkInfo",
		data : {
			userid : userid
		},
		success : function(bookmarkList) {
			mark_html = "<table class='list-table' style='width:450px;'>";
			for(var i = 0; i < bookmarkList.length; i++) {
				mark_html += "<tr><td class='td-bookmark' style='display:none;'>" + bookmarkList[i].bookmarkid + "</td>";
				mark_html += "<td class='td-bookmark'>" + bookmarkList[i].catename + "</td>";
				mark_html += "<td class='td-bookmark'>" + bookmarkList[i].content + "</td>";
				mark_html += "<td class='td-bookmark text-right red'>" + bookmarkList[i].total.toLocaleString() + "원</td>";
				mark_html += "<td class='td-delmark'><i class='fi fi-sr-minus-circle del-icon'></i></td></tr>";
			}
			
			$("#bookmark-list-div").html(mark_html);
		}
	})
	
	// 즐겨찾기를 이용한 수입/지출 추가
	$(document).on("click", ".td-bookmark", function() { // 즐겨찾기 행 클릭 시
		var catename = $(this).parent().children().eq(1).text();
		var content = $(this).parent().children().eq(2).text();
		var total = $(this).parent().children().eq(3).text().split("원")[0];
		
		$("#bookmark-modal").hide();
		$("#add-account-modal").show(); // 수입/지출 추가 모달 열기
		
		$("#add-actcontent").attr("value", content); // 즐겨찾기 값 수입/지출에 자동 입력
		$("#add-acttotal").attr("value", total);
		
		// 즐겨찾기 리스트 중 카테고리가 없거나 숨겨져있는 경우에는 카테고리에 빈 값이 입력되도록
		$.ajax({
			type : "post",
			url : "isPossibleCate",
			data : {
				moneytype : "지출",
				catename : catename,
				userid : userid
			},
			success : function(x) {
				if(x == "possible") {
					$("#add-actcatename").attr("value", catename);
				}
			}
		})
	})
	
	// 즐겨찾기 삭제
	$(document).on("click", ".td-delmark", function() {
		var bookmarkid = $(this).parent().children().eq(0).text();
		var op = confirm("즐겨찾기를 삭제하시겠습니까?");
		if(op) {
			$.ajax({
				type : "post",
				url : "deleteBookmark",
				data : {
					bookmarkid : bookmarkid,
					userid : userid
				},
				success : function(x) {
					if(x == "success") {
						window.location.reload();
					} else {
						alert("다시 시도해주세요.");
					}
				}
			})
		}
	})
})