document.write('<script src="../resources/js/account/account_list.js"></script>'); // 수입/지출 내역, 통계 js
document.write('<script src="../resources/js/account/category.js"></script>'); // 카테고리 js
document.write('<script src="../resources/js/asset/asset_list.js"></script>'); // 자산 목록 js
document.write('<script src="../resources/js/account/category_list.js"></script>'); // 카테고리 목록 js
document.write('<script src="../resources/js/cal_date.js"></script>'); // 이전 달, 다음 달 구하기 js
document.write('<script src="../resources/js/reg_exp.js"></script>'); // 정규식 js
document.write('<script src="../resources/js/main.js"></script>'); // 모달 및 카테고리 설정 js

$(function() {
	var todayAll; // 현재 날짜 저장할 변수
	var todayYear; // 현재 연도 저장할 변수
	
	/* 카테고리 수정 모달 열기  변수 */
	var originCate; // 원래 카테고리명
	var originName; // 원래 이름
	
	var clickNum = 0; // 설정 클릭 횟수 (횟수에 따라 설정 열고 닫음)
	
	var cycleChk = false;
	
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
	
	// moneytype 선택
	$.selectMtype = function(mtype, radioName) {
		if(mtype == "수입") {
			$("input:radio[name='" + radioName + "'][value='지출']").attr("checked", false);
			$("input:radio[name='" + radioName + "'][value='수입']").attr("checked", true);
		} else {
			$("input:radio[name='" + radioName + "'][value='수입']").attr("checked", false);
			$("input:radio[name='" + radioName + "'][value='지출']").attr("checked", true);
		}
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
	
	// 반복 옵션 선택 함수
	// parameter : 매년/매월/매주 선택 값, 매년 div, 매월 div, 매주 div
	$.selectRepeatOption = function(selectID, everyYearDiv, everyMonthDiv, everyWeekDiv) {
		if(selectID == "매년") {
			$(everyMonthDiv).hide();
			$(everyWeekDiv).hide();
			$(everyYearDiv).show();
		} else if(selectID == "매월") {
			$(everyYearDiv).hide();
			$(everyWeekDiv).hide();
			$(everyMonthDiv).show();
		} else if(selectID == "매주") {
			$(everyYearDiv).hide();
			$(everyMonthDiv).hide();
			$(everyWeekDiv).show();
		} else {
			$(everyYearDiv).hide();
			$(everyMonthDiv).hide();
			$(everyWeekDiv).hide();
		}
	}
	
	// 반복 형식 확인
	// parameter : 매년/매월/매주 선택 값, 매년 월, 매년 일, 매월 일, 매주 요일
	$.checkRepeat = function(repeatOption, everyYearMonth, everyYearDate, everyMonth, everyWeek) {
		if($(repeatOption).val() == "매년") {
			if($(everyYearMonth).val() == "월") {
				cycleChk = false;
			} else {
				cycleChk = $.checkDate(everyYearDate, "");
			}
		} else if($(repeatOption).val() == "매월") {
			cycleChk = $.checkDate(everyMonth, "");
		} else if($(repeatOption).val() == "매주") {
			if($(everyWeek).val() == "요일") {
				cycleChk = false;
			} else {
				cycleChk = true;
			}
		} else if($(repeatOption).val() == "매일") {
			cycleChk = true;
		} else {
			cycleChk = false;
		}
	}
	
	// 반복 주기 생성
	// parameter : 매년/매월/매주 선택 값, 매년 월, 매년 일, 매월 일, 매주 요일
	$.makeCycle = function(repeatOption, everyYearMonth, everyYearDate, everyMonth, everyWeek) {
		 var cycle = "";
		 if($(repeatOption).val() == "매년") {
			 if($(everyYearDate).val().length == 1) {
				 cycle = "매년 " + $(everyYearMonth).val() + "/0" + $(everyYearDate).val();
			 } else {
				 cycle = "매년 " + $(everyYearMonth).val() + "/" + $(everyYearDate).val();
			 }
		 } else if($(repeatOption).val() == "매월") {
			 if($(everyMonth).val().length == 1) {
				 cycle = "매월 0" + $(everyMonth).val();
			 } else {
				 cycle = "매월 " + $(everyMonth).val();
			 }
		 } else if($(repeatOption).val() == "매주") {
			 cycle = "매주 " + $(everyWeek).val();
		 } else {
			 cycle = "매일";
		 }
		 return cycle;
	}
	
	// 반복 중복 확인
	$.isOverlapRepeat = function(moneytype, astname, catename, total, content, userid) {
		var result;
		$.ajax({
			type: "post",
			url : "isOverlapRepeat",
			async : false,
			data : {
				moneytype : moneytype,
				astname : astname,
				catename : catename,
				total : total,
				content : content,
				userid : userid
			},
			success : function(x) {
				if(x == "possible") {
					result = true;
				} else {
					result = false;
				}
			}
		})
		return result;
	}
	
	// 반복 수정
	$.updateRepeat = function(cycle, repeatid, moneytype, astname, catename, total, content, userid) {
		$.ajax({
			type: "post",
			url : "updateRepeat",
			data : {
				repeatcycle : cycle,
				repeatid : repeatid,
				moneytype : moneytype,
				astname : astname,
				catename : catename,
				total : total,
				content : content,
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
	
	$(document).ready(function() {
		// 현재 날짜 가져오기
		todayAll = $.currentYM();
		todayYear = todayAll.split("-")[0];
		
		// 월별로 수입/지출 목록 가져오기
		$.accountList("monthAccount", todayAll, userid, "#month-div", "#month-account-list-div", "#total-div", "#total-income-div", "#total-spend-div");
		$.accountStats(todayAll, userid, "#category-stats-div");
		
		// 월별 그래프 보여주기
		$.monthAccountTotal("지출", todayAll.split("-")[0], userid);
		
		// 금액에 숫자만 입력되도록
		$.onlyNum("#up-acttotal");
		$.onlyNum("#add-acttotal");
		$.onlyNum("#rep-acttotal");
		
		// 금액 세 자리마다 콤마
		$.moneyFmt("#up-acttotal");
		$.moneyFmt("#add-acttotal");
		$.moneyFmt("#rep-acttotal");
		
		// 수입/지출 추가 및 수정의 내용, 메모에 #이 들어가지 않도록
		$.noHash("#add-actcontent");
		$.noHash("#add-actmemo");
		$.noHash("#up-actcontent");
		$.noHash("#up-actmemo");
		$.noHash("#rep-actcontent");
		
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
		$.openModal("#open-graph", "#graph-modal"); // 그래프 모달 열기
		$.openModal("#repeat-page", "#repeat-modal"); // 반복 모달 열기
		$.openModal("#add-repeat-list-btn", "#add-repeat-list-modal"); // 반복할 내역 찾기 모달 열기

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
		$.closeModal("#close-graph", "#graph-modal"); // 그래프 모달 닫기
		$.closeModal("#close-search", "#search-modal"); // 검색 모달 닫기
		$.closeModal("#close-repeat", "#repeat-modal"); // 반복 모달 닫기
		$.closeModal("#close-add-repeat", "#add-repeat-modal"); // 반복 추가 모달 닫기
		$.closeModal("#close-add-repeat-list", "#add-repeat-list-modal"); // 반복할 내역 찾기 모달 닫기
		$.closeModal("#close-up-repeat", "#up-repeat-modal"); // 반복 수정 모달 닫기
		
		// 다른 영역 클릭 시 창 닫기
		$.autoClose("#select-month"); // 날짜 선택 닫기
		$.autoClose("#catespend-modal"); // 카테고리별 내역 모달 닫기
		$.autoClose("#graph-modal"); // 그래프 모달 닫기
		$.autoClose("#search-modal"); // 검색 모달 닫기
		
		// 카테고리 초기화
		$.resetCategory("#reset-incate-btn", "수입"); // 수입 카테고리 초기화
		$.resetCategory("#reset-outcate-btn", "지출"); // 지출 카테고리 초기화
		
		// 자산 선택 및 값 자동 입력
		$.pickAsset("#add-actasset");
		$.pickAsset("#up-actasset");
		$.pickAsset("#rep-actasset");
		$.pickAsset("#up-rep-actasset");
		
		// 카테고리 선택 및 값 자동 입력 (수입/지출 추가)
		$.openSelectCate("#add-actcatename", "select-mtype"); // 카테고리 선택 모달 열기
		$.pickCategory("#select-incate-list-div #in-category-table tr", "#add-actcatename", "#select-outcate-modal"); // 수입 카테고리 선택
		$.pickCategory("#select-outcate-list-div #out-category-table tr", "#add-actcatename", "#select-outcate-modal"); // 지출 카테고리 선택

		// 카테고리 선택 및 값 자동 입력 (수입/지출 수정)
		$.openSelectCate("#up-actcatename", "up-mtype"); // 카테고리 선택 모달 열기
		$.pickCategory("#select-incate-list-div #in-category-table tr", "#up-actcatename", "#select-incate-modal"); // 수입 카테고리 선택
		$.pickCategory("#select-outcate-list-div #out-category-table tr", "#up-actcatename", "#select-outcate-modal"); // 지출 카테고리 선택
		
		// 카테고리 선택 및 값 자동 입력 (반복 추가)
		$.openSelectCate("#rep-actcatename", "rep-mtype"); // 카테고리 선택 모달 열기
		$.pickCategory("#select-incate-list-div #in-category-table tr", "#rep-actcatename", "#select-incate-modal"); // 수입 카테고리 선택
		$.pickCategory("#select-outcate-list-div #out-category-table tr", "#rep-actcatename", "#select-outcate-modal"); // 지출 카테고리 선택
		
		// 카테고리 선택 및 값 자동 입력 (반복 수정)
		$.openSelectCate("#up-rep-actcatename", "up-rep-mtype"); // 카테고리 선택 모달 열기
		$.pickCategory("#select-incate-list-div #in-category-table tr", "#up-rep-actcatename", "#select-incate-modal"); // 수입 카테고리 선택
		$.pickCategory("#select-outcate-list-div #out-category-table tr", "up-#rep-actcatename", "#select-outcate-modal"); // 지출 카테고리 선택
		
		// moneytype radio 값 변경 시 카테고리 재선택
		$.chgMtype("#add-actcatename", "select-mtype");
		$.chgMtype("#up-actcatename", "up-mtype");
		$.chgMtype("#rep-actcatename", "rep-mtype");
		$.chgMtype("#up-rep-actcatename", "up-rep-mtype");
		
	})

	// 수입 통계 보여주기
	$(document).on("click", "#in-stats-btn", function() {
		$.activeBtn("#out-stats-btn", "", "#in-stats-btn"); // 수입 버튼 활성화
		$.incomeStats(todayAll, userid, "#category-stats-div");
	})
	
	// 지출 통계 보여주기
	$(document).on("click", "#out-stats-btn", function() {
		$.activeBtn("#in-stats-btn", "", "#out-stats-btn"); // 지출 버튼 활성화
		$.accountStats(todayAll, userid, "#category-stats-div");
	})
	
	// 날짜 선택
	$(document).on("click", "#month-div", function() {
		$.selectDate(todayYear);
	})
	
	// 날짜 선택에서 이전 연도 클릭
	$(document).on("click", "#before-year", function() {
		todayYear = $.selectBeforeYear(todayYear);
	})
	
	// 날짜 선택에서 다음 연도 클릭
	$(document).on("click", "#after-year", function() {
		todayYear = $.selectAfterYear(todayYear);
	})
	
	// 날짜 월 선택 시 보여줄 연월 값 변경
	$(document).on("click", ".month-td", function() {
		$.activeBtn("#in-account-btn", "#out-account-btn", "#total-account-btn"); // 전체 보기 버튼 활성화
		$.activeBtn("#in-stats-btn", "", "#out-stats-btn"); // 통계 지출 버튼 활성화
		
		todayAll = $("#current-year").text().split("년")[0] + "-" + $(this).text().split("월")[0];
		todayYear = todayAll.split("-")[0];
		
		$.accountList("monthAccount", todayAll, userid, "#month-div", "#month-account-list-div", "#total-div", "#total-income-div", "#total-spend-div");
		$.accountStats(todayAll, userid, "#category-stats-div");
		$.monthAccountTotal("지출", todayAll.split("-")[0], userid); // 월별 그래프 보여주기
		
		$("#select-month").hide();
	})
	
	// 이전 달 클릭
	$(document).on("click", "#before", function() {
		$.activeBtn("#in-account-btn", "#out-account-btn", "#total-account-btn"); // 전체 보기 버튼 활성화
		$.activeBtn("#in-stats-btn", "", "#out-stats-btn"); // 통계 지출 버튼 활성화
		todayAll = $.beforeDate(todayAll); // 날짜 이전 달로 setting
		todayYear = todayAll.split("-")[0];
		$.accountList("monthAccount", todayAll, userid, "#month-div", "#month-account-list-div", "#total-div", "#total-income-div", "#total-spend-div");
		$.accountStats(todayAll, userid, "#category-stats-div");
		$.monthAccountTotal("지출", todayAll.split("-")[0], userid); // 월별 그래프 보여주기
	})
	
	// 다음 달 클릭
	$(document).on("click", "#after", function() {
		$.activeBtn("#in-account-btn", "#out-account-btn", "#total-account-btn"); // 전체 보기 버튼 활성화
		$.activeBtn("#in-stats-btn", "", "#out-stats-btn"); // 통계 지출 버튼 활성화
		todayAll = $.afterDate(todayAll); // 날짜 다음 달로 setting
		todayYear = todayAll.split("-")[0];
		$.accountList("monthAccount", todayAll, userid, "#month-div", "#month-account-list-div", "#total-div", "#total-income-div", "#total-spend-div");
		$.accountStats(todayAll, userid, "#category-stats-div");
		$.monthAccountTotal("지출", todayAll.split("-")[0], userid); // 월별 그래프 보여주기
	})
	
	// 그래프 이전 연도 클릭
	$(document).on("click", "#before-graph", function() {
		todayYear = parseInt(todayYear) - 1;
		$.monthAccountTotal("지출", todayYear, userid); // 월별 그래프 보여주기
	})
	
	// 그래프 다음 연도 클릭
	$(document).on("click", "#after-graph", function() {
		todayYear = parseInt(todayYear) + 1;
		$.monthAccountTotal("지출", todayYear, userid); // 월별 그래프 보여주기
	})
	
	// 그래프 모달 닫으면
	$(document).on("click", "#close-graph", function() {
		todayYear = todayAll.split("-")[0]; // year 값 원래대로 돌리기
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
	
	// 검색 모달 열기
	$(document).on("click", "#open-search", function() {
		$("#search-modal").show();
		$("#search-input").val(""); // input 값 비우기
		$("#autosearch-div").hide(); // 자동완성 지우기
	})
	// 수입/지출 검색
	$(document).on("click", "#search-btn", function() {
		$.searchAccountList($("#search-input").val(), userid);
		$("#autosearch-div").hide();
	})
	
	// 수입/지출 검색 자동완성
	$(document).on("keyup", "#search-input", function() {
		if($("#search-input").val() != "") { // 사용자가 입력한 값이 있을 경우에만
			$.ajax({
				type : "post",
				url : "autoSearch",
				data : {
					content : $("#search-input").val(),
					userid : userid
				},
				success : function(list) {
					if(list.length > 0) { // 사용자가 입력한 값이 포함되는 단어가 존재할 경우 자동완성 리스트 보여주기
						var html = "<ul class='autocomplete'>";
						for(var i = 0; i < list.length; i++) {
							html += "<li class='autocomplete-list'>" + list[i] + "</li>";
						}
						html += "</ul>";
						$("#autosearch-list-div").html(html);
						
						$("#autosearch-div").show();
					}
				}
			})
		} else { // 내용을 입력했다 지운 경우는 리스트 숨기기
			$("#autosearch-div").hide();
		}
	})
	
	// 수입/지출 검색 자동완성된 단어 선택
	$(document).on("click", ".autocomplete-list", function () {
		$("#search-input").val($(this).text());
		$("#search-btn").trigger("click"); // 검색 버튼 자동 클릭
		
		$("#autosearch-div").hide();
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
						window.location.reload();
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
		
		$.selectMtype(actmoneytype, "up-mtype");
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
		var moneytype;
		if($(this).children().eq(1).hasClass("blue")) {
			moneytype = "수입";
		} else {
			moneytype = "지출";
		}
		$.cateAccountList(catename, moneytype, todayAll, userid);
	})
	
	/* 즐겨찾기 */
	// 즐겨찾기에 추가 가능한 내역 가져오기
	$.ajax({
		type : "post",
		url : "canBookmarkInfo",
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
	
	/* 반복 */
	// 반복 추가 모달 열기
	$(document).on("click", "#add-repeat-page", function() {
		$("#add-repeat-modal").show();
		
		$("#rep-actasset").attr("value", "");
		$("#rep-actcatename").attr("value", "");
		$("#rep-acttotal").attr("value", "");
		$("#rep-actcontent").attr("value", "");
	})
	
	// 반복 추가에서 반복 옵션 선택
	$(document).on("change", "#repeat-option", function() {
		$.selectRepeatOption($(this).val(), "#every-year-div", "#every-month-div", "#every-week-div");
	})
	
	// 반복에 추가 가능한 내역 가져오기
	$.ajax({
		type : "post",
		url : "canRepeatInfo",
		data : {
			userid : userid
		},
		success : function(list) {
			var html;
			if(list.length > 0) {
				html = "<table class='list-table' style='width:450px;'>";
				for(var i = 0; i < list.length; i++) {
					html += "<tr class='tr-addrepeat'>";
					html += "<td>" + list[i].catename + "</td>";
					html += "<td><div>" + list[i].content + "</div><div><span class='fs-16 info'>" + list[i].astname + "</span></div></td>";
					if(list[i].moneytype == "수입") {
						html += "<td class='text-right blue'>" + parseInt(list[i].total).toLocaleString() + "원</td>";
					} else {
						html += "<td class='text-right red'>" + parseInt(list[i].total).toLocaleString() + "원</td>";
					}
					html += "<td style='display:none;'>" + list[i].moneytype + "</td></tr>";
				}
				html += "</table>";
			} else {
				html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
			}
			
			$("#add-repeat-list-div").html(html);
		}
	})
	
	// 반복 가능한 내역 tr 클릭 시 반복 내역에 자동입력
	$(document).on("click", ".tr-addrepeat", function() {
		var astname = $(this).children().eq(1).children().eq(1).text();
		var catename = $(this).children().eq(0).text();
		var content = $(this).children().eq(1).children().eq(0).text();
		var total = ($(this).children().eq(2).text().split("원")[0]);
		var moneytype = $(this).children().eq(3).text();
		
		// 반복 추가 자동입력
		$("#rep-actasset").attr("value", astname); // 자산
		$("#rep-actcatename").attr("value", catename); // 카테고리
		$("#rep-acttotal").attr("value", total); // 금액
		$("#rep-actcontent").attr("value", content); // 내용
		$.selectMtype(moneytype, "rep-mtype"); // 수입/지출
		
		// 반복 수정 자동입력
		$("#up-rep-actasset").attr("value", astname); // 자산
		$("#up-rep-actcatename").attr("value", catename); // 카테고리
		$("#up-rep-acttotal").attr("value", total); // 금액
		$("#up-rep-actcontent").attr("value", content); // 내용
		$.selectMtype(moneytype, "up-rep-mtype"); // 수입/지출
		
		$("#add-repeat-list-modal").hide();
	})
	
	// 반복 추가
	$(document).on("click", "#add-repeat-btn", function() {
		cycleChk = false;
		// 반복 형식 확인
		$.checkRepeat("#repeat-option", "#every-year-month", "#every-year-date", "#every-month-date", "#every-week-day");

		var moneytype = $("input[name='rep-mtype']:checked").val();
		var astname = $("#rep-actasset").val();
		var catename = $("#rep-actcatename").val();
		var total =  $("#rep-acttotal").val().replaceAll(",", "");
		var content = $("#rep-actcontent").val();
		
		if(!$.noEmpty("#rep-actasset") || !$.noEmpty("#rep-actcatename") || !$.noEmpty("#rep-acttotal") || cycleChk == false){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			// 중복 확인
			var chkRepeat = $.isOverlapRepeat(moneytype, astname, catename, total, content, userid);
			if(chkRepeat) { // 중복되는 반복 내역이 없는 경우 추가
				
				var cycle = $.makeCycle("#repeat-option", "#every-year-month", "#every-year-date", "#every-month-date", "#every-week-day");
				
				$.ajax({
					type: "post",
					url : "insertRepeat",
					data : {
						repeatcycle : cycle,
						moneytype : moneytype,
						astname : astname,
						catename : catename,
						total : total,
						content : content,
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
			} else { // 중복되는 경우
				alert("이미 반복이 설정된 내역입니다.");
			}
		}
	})
	
	// 반복 내역
	$.ajax({
		type : "post",
		url : "repeatInfo",
		data : {
			userid : userid
		},
		success : function(map) {
			var repeat_html;
			if(Object.keys(map) != "no") {
				repeat_html = "<table class='list-table'>";
				
				for(var key in map) {
					repeat_html += "<tr><td class='h-bold' colspan='5'>" + key + "</td></tr>";
					var value = map[key].split(",");
					for(var i = 0; i < value.length; i++) {
						var repeat = value[i].split("#");
						repeat_html += "<tr class='tr-repeat'><td class='td-repeat' style='display:none;'>" + key + "</p></td>"; // 주기
						repeat_html += "<td class='td-repeat h-bold' style='width:15%;'><p class='text-box green'>" + repeat[0] + "</p></td>"; // 주기 일자
						repeat_html += "<td class='td-repeat' style='display:none;'>" + repeat[1] + "</td>"; // 반복 ID
						repeat_html += "<td class='td-repeat' style='width:25%;'>" + repeat[4] + "</td>"; // 카테고리
						repeat_html += "<td class='td-repeat' style='width:25%;'><div>" + repeat[5] + "</div><div><span class='fs-16 info'>" + repeat[3] + "</span></div></td>"; // 내용, 자산
						if(repeat[2] == "수입") {
							repeat_html += "<td class='td-repeat text-right blue' style='width:25%;'>" + parseInt(repeat[6]).toLocaleString() + "원</td>"; // 돈
						} else {
							repeat_html += "<td class='td-repeat text-right red' style='width:25%;'>" + parseInt(repeat[6]).toLocaleString() + "원</td>";
						}
						repeat_html += "<td class='td-repeat' style='display:none;'>" + repeat[2] + "</td></tr>";
					}
				}
				
				repeat_html += "</table>";
			} else {
				repeat_html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
			}
			
			$("#repeat-list-div").html(repeat_html);
		}
	})
	
	var originAsset;
	var originCatename;
	var originContent;
	
	// 반복 수정 자동입력
	$(document).on("click", ".tr-repeat", function() {
		$("#up-repeat-modal").show();
		
		var cycle1 = $(this).children().eq(0).text();
		var cycle2 = $(this).children().eq(1).text();
		var repeatid = $(this).children().eq(2).text();
		var astname = $(this).children().eq(4).children().eq(1).text();
		var catename = $(this).children().eq(3).text();
		var content = $(this).children().eq(4).children().eq(0).text();
		var total = $(this).children().eq(5).text().split("원")[0];
		var moneytype = $(this).children().eq(6).text();

		originAsset = astname;
		originCatename = catename;
		originContent = content;
			
		$("#up-repeat-option").val(cycle1).prop("selected", true);

		$.selectRepeatOption(cycle1, "#up-every-year-div", "#up-every-month-div", "#up-every-week-div");
		
		if(cycle1 == "매년") {
			$("#up-every-year-month").val(cycle2.split("/")[0]).prop("selected", true);
			$("#up-every-year-date").attr("value", cycle2.split("/")[1]);
		} else if(cycle1 == "매월") {
			$("#up-every-month-date").attr("value", cycle2);
		} else if(cycle1 == "매주") {
			$("#up-every-week-div").show();
			$("#up-every-week-day").val(cycle2).prop("selected", true);
		}
		
		$.selectMtype(moneytype, "up-rep-mtype");
		
		$("#up-repeatid").attr("value", repeatid);
		$("#up-rep-actasset").attr("value", astname);
		$("#up-rep-actcatename").attr("value", catename);
		$("#up-rep-acttotal").attr("value", total);
		$("#up-rep-actcontent").attr("value", content);
	})
	
	// 반복 수정에서 반복 옵션 선택
	$(document).on("change", "#up-repeat-option", function() {
		$.selectRepeatOption($(this).val(), "#up-every-year-div", "#up-every-month-div", "#up-every-week-div");
	})
	
	// 반복 수정
	$(document).on("click", "#up-repeat-btn", function() {
		cycleChk = false;
		$.checkRepeat("#up-repeat-option", "#up-every-year-month", "#up-every-year-date", "#up-every-month-date", "#up-every-week-day");

		var repeatid = $("#up-repeatid").val();
		var moneytype = $("input[name='up-rep-mtype']:checked").val();
		var astname = $("#up-rep-actasset").val();
		var catename = $("#up-rep-actcatename").val();
		var total =  $("#up-rep-acttotal").val().replaceAll(",", "");
		var content = $("#up-rep-actcontent").val();

		if(!$.noEmpty("#up-rep-actasset") || !$.noEmpty("#up-rep-actcatename") || !$.noEmpty("#up-rep-acttotal") || cycleChk == false){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			if(astname != originAsset || catename != originCatename || content != originContent) { // 자산/카테고리/내용 중 하나라도 변경되었다면 중복 확인
				var chkRepeat = $.isOverlapRepeat(moneytype, astname, catename, total, content, userid); // 중복 확인
				if(chkRepeat) { // 중복되는 반복 내역이 없는 경우 수정
					var cycle = $.makeCycle("#up-repeat-option", "#up-every-year-month", "#up-every-year-date", "#up-every-month-date", "#up-every-week-day");
					$.updateRepeat(cycle, repeatid, moneytype, astname, catename, total, content, userid);
				} else { // 중복되는 경우
					alert("이미 반복이 설정된 내역입니다.");
				}
			} else { // 반복 주기만 변경되었다면 중복 확인 없이 수정
				var cycle = $.makeCycle("#up-repeat-option", "#up-every-year-month", "#up-every-year-date", "#up-every-month-date", "#up-every-week-day");
				$.updateRepeat(cycle, repeatid, moneytype, astname, catename, total, content, userid);
			}
		}
	})
	
	// 반복 삭제
	$(document).on("click", "#del-repeat-btn", function() {
		var op = confirm("정말로 삭제하시겠습니까?");
		if(op) {
			$.ajax({
				type : "post",
				url : "deleteRepeat",
				data : {
					 repeatid : $("#up-repeatid").val(),
					 userid : userid
				},
				success : function(x) {
					if(x == "success") {
						window.location.reload();
					} else {
						alert("다시 시도해주세요.")
					}
				}
			})
		}
	})
})