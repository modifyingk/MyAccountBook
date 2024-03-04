document.write('<script src="../resources/js/function/htmlFunc.js"></script>'); // html 함수
document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 유효성 검사 함수
document.write('<script src="../resources/js/function/dateFunc.js"></script>'); // 날짜 함수
document.write('<script src="../resources/js/asset/assetFunc.js"></script>'); // 자산 함수

document.write('<script src="../resources/js/account/accountFunc.js"></script>'); // 수입/지출 내역 함수
document.write('<script src="../resources/js/account/category.js"></script>'); // 카테고리

$(function() {
	var date;
	var today; // 현재 날짜 저장할 변수
	var year; // 현재 연도 저장할 변수
	var month;
	
	/* 카테고리 수정 모달 열기  변수 */
	var originCate; // 원래 카테고리명
	var originName; // 원래 이름
	
	var clickNum = 0; // 설정 클릭 횟수 (횟수에 따라 설정 열고 닫음)
	
	var cycleChk = false;
	
	$(document).ready(function() {
		// 현재 날짜 가져오기
		date = $.createDate();
		today = $.getYearMonth(date);
		year = date.getFullYear();
		month = date.getMonth() + 1;

		// 날짜 세팅
		$.setDate(year, month);
		
		// 월별 수입/지출 목록
		$.showAccount(today, userid, "all");
		
		// 합계
		$.showTotal();
		// 카테고리 통계
	//	$.showStats($.categoryStatsList(today, userid, "spend"));
		
		// 연도별 지출 그래프
		//$.detailsOfYear("지출", year, userid);
		
		// 금액에 숫자만 입력되도록
		$.onlyNum("#update-total");
		$.onlyNum("#add-total");
		//$.onlyNum("#rep-acttotal");
		
		// 금액 세 자리마다 콤마
		$.moneyFmt("#update-total");
		$.moneyFmt("#add-total");
		//$.moneyFmt("#rep-acttotal");
		
		// 자산 선택
		$.pickAsset("#add-asset"); // 자산 선택 및 값 자동 입력
		$.pickBigcate("#add-bigcate"); // 대분류 선택 및 값 자동 입력
		$.pickSmallcate("#add-smallcate"); // 소분류 선택 및 값 자동 입력
		
/*		// 카테고리 설정 열고 닫기 (우측 상단 설정 버튼)
		$.settingDiv(clickNum, "#open-cate-setting", "#cate-setting");
		
		// 카테고리 목록 가져오기
		$.categoryList(userid, "#in-category-list-div", "#out-category-list-div"); // 카테고리 목록
		$.categoryList(userid, "#select-incate-list-div", "#select-outcate-list-div"); // 카테고리 선택 모달*/
		
		// 자산 목록 가져오기
	//	$.assetList(userid, "#asset-list-div");
		
	/*	// 카테고리 수정 모달 열기 및 자동 입력
		$.openUpdateCate("#in-category-list-div #in-category-table tr");
		$.openUpdateCate("#out-category-list-div #out-category-table tr");*/
		
		// 모달 열기
	//	$.openModal("#in-category-btn", "#in-category-modal"); // 수입 카테고리 모달 열기
	//	$.openModal("#out-category-btn", "#out-category-modal"); // 지출 카테고리 모달 열기
	//	$.openModal("#bookmark-page", "#bookmark-modal"); // 즐겨찾기 모달 열기
	//	$.openModal("#add-bookmark-page", "#add-bookmark-modal"); // 즐겨찾기 추가 모달 열기
	//	$.openModal("#open-graph", "#graph-modal"); // 그래프 모달 열기
	//	$.openModal("#repeat-page", "#repeat-modal"); // 반복 모달 열기
	//	$.openModal("#add-repeat-list-btn", "#add-repeat-list-modal"); // 반복할 내역 찾기 모달 열기

		// 모달 닫기
	//	$.closeModal("#close-in-category", "#in-category-modal"); // 수입 카테고리 모달 닫기
	//	$.closeModal("#close-out-category", "#out-category-modal"); // 지출 카테고리 모달 닫기
	//	$.closeModal("#close-add-category", "#add-category-modal"); // 카테고리 추가 모달 닫기
	//	$.closeModal("#close-up-category", "#up-category-modal"); // 카테고리 수정 모달 닫기
	//	$.closeModal("#close-select-moneytype", "#select-moneytype-modal"); // 카테고리 추가/수정 시 moneytype 선택 모달 닫기
	//	$.closeModal("#close-select-incate", "#select-incate-modal"); // 수입 카테고리 선택 모달 닫기
	//	$.closeModal("#close-select-outcate", "#select-outcate-modal"); // 지출 카테고리 선택 모달 닫기
	//	$.closeModal("#close-select-asset", "#select-asset-modal"); // 자산 선택 모달 닫기
		
	//	$.closeModal("#close-add-account", "#add-account-modal"); // 수입/지출 추가 모달 닫기
		
	//	$.closeModal("#close-up-account", "#up-account-modal"); // 수입/지출 수정 모달 닫기
	//	$.closeModal("#close-catespend", "#catespend-modal"); // 카테고리별 지출 내역 모달 닫기
	//	$.closeModal("#close-bookmark", "#bookmark-modal"); // 즐겨찾기 모달 닫기
	//	$.closeModal("#close-add-bookmark", "#add-bookmark-modal"); // 즐겨찾기 추가 모달 닫기
	//	$.closeModal("#close-graph", "#graph-modal"); // 그래프 모달 닫기
	//	$.closeModal("#close-search", "#search-modal"); // 검색 모달 닫기
	//	$.closeModal("#close-repeat", "#repeat-modal"); // 반복 모달 닫기
	//	$.closeModal("#close-add-repeat", "#add-repeat-modal"); // 반복 추가 모달 닫기
	//	$.closeModal("#close-add-repeat-list", "#add-repeat-list-modal"); // 반복할 내역 찾기 모달 닫기
	//	$.closeModal("#close-up-repeat", "#up-repeat-modal"); // 반복 수정 모달 닫기
		
		// 다른 영역 클릭 시 창 닫기
		$.autoClose("#select-month"); // 날짜 선택 닫기
		$.autoClose(".select-asset-div"); // 자산 선택 닫기
		$.autoClose(".select-incate-div"); // 분류 선택 닫기
		$.autoClose(".select-outcate-div"); // 분류 선택 닫기
		$.autoClose(".select-smallcate-div"); // 분류 선택 닫기
//		$.autoClose("#catespend-modal"); // 카테고리별 내역 모달 닫기
	//	$.autoClose("#graph-modal"); // 그래프 모달 닫기
	//	$.autoClose("#search-modal"); // 검색 모달 닫기
		
		// 카테고리 초기화
	//	$.resetCategory("#reset-incate-btn", "수입"); // 수입 카테고리 초기화
	//	$.resetCategory("#reset-outcate-btn", "지출"); // 지출 카테고리 초기화
		
	//	$.pickAsset("#up-actasset");
	//	$.pickAsset("#rep-actasset");
	//	$.pickAsset("#up-rep-actasset");
		
		
//		$.chgMtype("#add-actcatename", "select-mtype");
//		$.chgMtype("#up-actcatename", "up-mtype");
//		$.chgMtype("#rep-actcatename", "rep-mtype");
//		$.chgMtype("#up-rep-actcatename", "up-rep-mtype");
		
		// 카테고리 선택 및 값 자동 입력 (수입/지출 추가)
	//	$.openSelectCate("#add-actcatename", "select-mtype"); // 카테고리 선택 모달 열기
	//	$.pickCategory("#select-incate-list-div #in-category-table tr", "#add-actcatename", "#select-outcate-modal"); // 수입 카테고리 선택
	//	$.pickCategory("#select-outcate-list-div #out-category-table tr", "#add-actcatename", "#select-outcate-modal"); // 지출 카테고리 선택

		// 카테고리 선택 및 값 자동 입력 (수입/지출 수정)
	//	$.openSelectCate("#up-actcatename", "up-mtype"); // 카테고리 선택 모달 열기
	//	$.pickCategory("#select-incate-list-div #in-category-table tr", "#up-actcatename", "#select-incate-modal"); // 수입 카테고리 선택
	//	$.pickCategory("#select-outcate-list-div #out-category-table tr", "#up-actcatename", "#select-outcate-modal"); // 지출 카테고리 선택
		
		// 카테고리 선택 및 값 자동 입력 (반복 추가)
	//	$.openSelectCate("#rep-actcatename", "rep-mtype"); // 카테고리 선택 모달 열기
	//	$.pickCategory("#select-incate-list-div #in-category-table tr", "#rep-actcatename", "#select-incate-modal"); // 수입 카테고리 선택
	//	$.pickCategory("#select-outcate-list-div #out-category-table tr", "#rep-actcatename", "#select-outcate-modal"); // 지출 카테고리 선택
		
		// 카테고리 선택 및 값 자동 입력 (반복 수정)
	//	$.openSelectCate("#up-rep-actcatename", "up-rep-mtype"); // 카테고리 선택 모달 열기
	//	$.pickCategory("#select-incate-list-div #in-category-table tr", "#up-rep-actcatename", "#select-incate-modal"); // 수입 카테고리 선택
	//	$.pickCategory("#select-outcate-list-div #out-category-table tr", "up-#rep-actcatename", "#select-outcate-modal"); // 지출 카테고리 선택
		
	})

	// 날짜 선택 창 보여주기
	$(document).on("click", "#date-div", function() {
		$.showSelectDate(year);
	})
	
	// 날짜 선택 창에서 이전 연도 클릭
	$(document).on("click", "#before-year", function() {
		year = $.selectBeforeYear(year);
	})
	
	// 날짜 선택 창에서 다음 연도 클릭
	$(document).on("click", "#after-year", function() {
		year = $.selectAfterYear(year);
	})
	
	// 날짜 선택 창에서 월 선택
	$(document).on("click", ".month-td", function() {
		$.activeBtn("#in-account-btn", "#out-account-btn", "#total-account-btn"); // 전체 보기 버튼 활성화
		$.activeBtn("#in-stats-btn", "", "#out-stats-btn"); // 통계 지출 버튼 활성화
		
		today = $.selectDate($("#current-year").text(), $(this).text());
		year = $.getYear(today);
		month = $.getMonth(today);
		
		// 월별 수입/지출 목록
		$.setDate(year, month);
		$.showAccount(today, userid, "all");
		$.showTotal();
//		$.showStats($.categoryStatsList(today, userid, "spend"));
		//$.detailsOfYear("지출", today.split("-")[0], userid); // 월별 그래프 보여주기
		
		$("#select-month").hide();
		$("#details-category-div").hide();
	})
	
	// 이전 달 클릭
	$(document).on("click", "#before", function() {
		$.activeBtn("#in-account-btn", "#out-account-btn", "#total-account-btn"); // 전체 보기 버튼 활성화
		$.activeBtn("#in-stats-btn", "", "#out-stats-btn"); // 통계 지출 버튼 활성화
		
		// 이전 달로 month-div 세팅
		today = $.beforeDate(today);
		year = $.getYear(today);
		month = $.getMonth(today);
		$.setDate(year, month);
		
		// 해당 날짜의 수입/지출 내역
		$.showAccount(today, userid, "all");
		$.showTotal();
//		$.showStats($.categoryStatsList(today, userid, "spend"));
		$("#details-category-div").hide();
		//$.detailsOfYear("지출", year, userid); // 월별 그래프 보여주기
	})
	
	// 다음 달 클릭
	$(document).on("click", "#after", function() {
		$.activeBtn("#in-account-btn", "#out-account-btn", "#total-account-btn"); // 전체 보기 버튼 활성화
		$.activeBtn("#in-stats-btn", "", "#out-stats-btn"); // 통계 지출 버튼 활성화
		
		// 다음 달로  month-div 세팅
		today = $.afterDate(today);
		year = $.getYear(today);
		month = $.getMonth(today);
		$.setDate(year, month);
		
		// 해당 날짜의 수입/지출 내역
		$.showAccount(today, userid, "all");
		$.showTotal();
	//	$.showStats($.categoryStatsList(today, userid, "spend"));
		$("#details-category-div").hide();
		
		//$.detailsOfYear("지출", today.split("-")[0], userid); // 월별 그래프 보여주기
	})
	/*
	// 그래프 이전 연도 클릭
	$(document).on("click", "#before-graph", function() {
		year = parseInt(year) - 1;
		$.detailsOfYear("지출", year, userid); // 월별 그래프 보여주기
	})
	
	// 그래프 다음 연도 클릭
	$(document).on("click", "#after-graph", function() {
		year = parseInt(year) + 1;
		$.detailsOfYear("지출", year, userid); // 월별 그래프 보여주기
	})
	*/
	/*
	// 그래프 모달 닫으면
	$(document).on("click", "#close-graph", function() {
		year = $.getYear(today); // year 값 원래대로 돌리기
	})
	*/
	/*
	// 전체 내역 보기
	$(document).on("click", "#total-account-btn", function() {
		$.activeBtn("#in-account-btn", "#out-account-btn", "#total-account-btn"); // 전체 보기 버튼 활성화
		$.showAccount(today, userid, "all");
		$.showTotal();
	})
	
	// 수입 내역만 보기
	$(document).on("click", "#in-account-btn", function() {
		$.activeBtn("#total-account-btn", "#out-account-btn", "#in-account-btn"); // 수입만 보기 버튼 활성화
		$.showAccount(today, userid, "income");
	})
	
	// 지출 내역만 보기
	$(document).on("click", "#out-account-btn", function() {
		$.activeBtn("#total-account-btn", "#in-account-btn", "#out-account-btn"); // 지출만 보기 버튼 활성화
		$.showAccount(today, userid, "spend");
	})*/
	
	// 수입/지출 선택
	$(document).on("click", ".switch", function() {
		let mtype = $(this).children().eq(1).text();
		if(mtype == "지출") {
			// 수입으로 바꾸기
			$(".switch").removeClass("spend");
			$(".switch").addClass("income");
			$(".switch label").text("수입");
		} else {
			// 지출로 바꾸기
			$(".switch").removeClass("income");
			$(".switch").addClass("spend");
			$(".switch label").text("지출");
		}
		$("#add-bigcate").attr("value", "");
	})
	
	// 대분류 선택 시 소분류 보여주기
	$(document).on("click", ".select-table td", function() {
		let mtype = $("input[name='add-moneytype']+label").text();
		let bigcate = $(this).text();
		
		$.ajax({
			type: "post",
			url: "smallcateList",
			data: {
				bigcate: bigcate,
				userid: userid,
				mtype: mtype
			},
			success: function(list) {
				let html = "<table class='select-table td-border td-hover'>";
				for(let i = 0; i < list.length; i++) {
					html += "<tr><td>" + list[i] + "</td></tr>";
				}
				$(".select-smallcate-list").html(html);
			}
		})
		
		$(".select-smallcate-div").show();
	})
	
	
	/*
	// 수입/지출 추가 div 열기
	$(document).on("click", "#open-add-account", function() {
		// 자산, 카테고리 값 다 비우고 추가 (수입/지출내역 수정할 때 자산, 카테고리 선택하면 같이 변경되므로)
		$("#add-date").attr("value", $.getFullDate(date));
		$("#add-asset").attr("value", "");
		$("#add-category").attr("value", "");
		$("#add-content").attr("value", "");
		$("#add-total").attr("value", "");
		
		$("#stats-div").hide();
		$("#update-account-div").hide();
		$("#repeat-list-div").hide();
		$("#add-account-div").show();
		
		$.pickAsset("#add-assetid", "#add-asset"); // 자산 선택 및 값 자동 입력
		$.pickCategory("#add-category", "select-mtype"); // 카테고리 선택 시 값 자동 입력
		$.chgMtype("#add-category", "select-mtype"); // moneytype radio 값 변경 시 카테고리 값 비우기
		
	})
*/
	// 반복 설정
	$(document).on("click", "#add-repeat", function() {
		$("#select-repeat-div").show();
		$(document).on("click", ".td-repeat-option", function() {
			$("#add-repeat").val($(this).text());
			$("#select-repeat-div").hide();
			if($(this).text() == "없음") {
				$("input[type=radio][name=add-repeat]").prop("checked", false);
				$(".select-repeat label[for='add-repeat']").html("<i class='fi fi-rr-arrows-repeat'></i>");
			} else {
				$(".select-repeat label[for='add-repeat']").text($(this).text());
			}
		})
	})
	/*
	// 수입/지출 추가 div 닫기
	$(document).on("click", "#close-add-account", function() {
		$("#add-account-div").hide();
	})
	*/
	// 수입/지출 추가
	$(document).on("click", "#add-account-btn", function() {
		let mtype = $(".switch label").text();
		let date = $("#add-date").val().replaceAll("-", "");
		let asset = $("#add-asset").val();
		let bigcate = $("#add-bigcate").val();
		let smallcate = $("#add-smallcate").val();
		let content = $("#add-content").val();
		let total = $("#add-total").val().replaceAll(",", "");
		
		if(!$.checkMustReg("#add-date") || !$.checkMustReg("#add-asset") || !$.checkMustReg("#add-bigcate") || !$.checkMustReg("#add-total")){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			$.ajax({
				type: "post",
				url: "insertAccount",
				data: {
					moneytype: mtype,
					date: date,
					assetname: asset,
					bigcate: bigcate,
					smallcate: smallcate,
					content: content,
					total: total,
					userid : userid,
				},
				success : function(res) { // 수입/지출 추가 시 포인트 적립
					if(res == true) {
						window.location.reload();
					} else {
						alert("다시 시도해주세요.")
					}
				}
			})
		}
	})
	
	// 수입/지출 내역 테이블에서 날짜 tr 클릭 시
	$(document).on("click", "#month-account-list-div .tr-date", function() {
		var d = $(this).text().substring(0, 2);
		var dateVal = year + "-" + $.monthFmt(month) + "-" + d;
		$("#stats-div").hide();
		$("#update-account-div").hide();
		$("#repeat-list-div").hide();
		$("#add-account-div").show(); // 수입/지출 추가 div 열기
		$("#add-date").attr("value", dateVal);
	})
	
	// 수입/지출 내역 내용 tr 클릭 시 수정 div 열기
	$(document).on("click", "#month-account-list-div .tr-content", function() {
		var d = $(this).children().eq(0).text();
		var id = $(this).children().eq(1).text();
		var mtype = $(this).children().eq(2).text();
		var catename = $(this).children().eq(3).text();
		var content = $(this).children().eq(4).children().eq(0).text();
		var asset = $(this).children().eq(4).children().eq(1).text();
		var assetid = $(this).children().eq(4).children().eq(2).text();
		var total = $(this).children().eq(5).text();
		var memo = $(this).children().eq(6).text();
		
		// 수정 모달 값 setting
		$("#update-date").attr("value", d);
		$("#update-id").attr("value", id);
		$("#update-asset").attr("value", asset);
		$("#update-assetid").attr("value", assetid);
		$("#update-category").attr("value", catename);
		$("#update-content").attr("value", content);
		$("#update-total").attr("value", total.split("원")[0]);
		$("#update-memo").html(memo);
		
		if(mtype == "수입") {
			var html = "<input type='radio' name='update-mtype' id='update-in' value='수입' checked><label for='update-in'>수입</label>";
			$("#update-account-div .select").html(html);
		} else {
			var html = "<input type='radio' name='update-mtype' id='update-out' value='지출' checked><label for='update-out'>지출</label>";
			$("#update-account-div .select").html(html);
		}
		
		$("#stats-div").hide();
		$("#add-account-div").hide();
		$("#repeat-list-div").hide();
		$("#update-account-div").show();
		
		$.pickAsset("#update-assetid", "#update-asset");
		$.pickCategory("#update-category", "update-mtype");
	})
	
	// 수입/지출 수정 div 닫기
	$(document).on("click", "#close-update-account", function() {
		$("#update-account-div").hide();
	})
	
	// 수입/지출 수정
	$(document).on("click", "#update-account-btn", function() {
		if(!$.checkMustReg("#update-date") || !$.checkMustReg("#up-dateasset") || !$.checkMustReg("#update-category") || !$.checkMustReg("#update-total")){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			$.ajax({
				type : "post",
				url : "updateAccount",
				data : {
					moneytype :  $("input[name=update-mtype]:checked").val(),
					date : $("#update-date").val(),
					assetid: $("#update-assetid").val(),
					assetname : $("#update-asset").val(),
					catename : $("#update-category").val(),
					content : $("#update-content").val(),
					total : ($("#update-total").val()).replaceAll(",", ""),
					memo : $("#update-memo").val(),
					accountid : $("#update-id").val(),
					userid : userid
				},
				success : function(res) {
					if(res == true) {
						window.location.reload();
					} else {
						alert("다시 시도해주세요.");
					}
				}
			})
		}
	})
	
	// 수입/지출 삭제
	$(document).on("click", "#delete-account-btn", function() {
		var op = confirm("내역을 삭제하시겠습니까?")
		if(op) {
			$.ajax({
				type : "post",
				url : "deleteAccount",
				data : {
					accountid : $("#update-id").val(),
					userid : userid
				},
				success : function(res) {
					if(res == true) {
						window.location.reload();
					} else {
						alert("다시 시도해주세요.");
					}
				}
			})
		}
	})
	
	/*
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
	*/
	// 카테고리 통계 보여주기 버튼
	$(document).on("click", "#category-stats-btn", function() {
		location.href = "category_stats.jsp?today=" + today;
	})
	
	// 자산 통계 보여주기 버튼
	$(document).on("click", "#asset-stats-btn", function() {
		location.href = "asset_stats.jsp?today=" + today;
	})
	
	// 반복 내역 보여주기
	$(document).on("click", "#repeat-btn", function() {
		$.ajax({
			type: "post",
			url: "repeatList",
			data: {
				userid: userid
			},
			success: function(list) {
				var html = "<table class='list-table'>";
				for(var i = 0; i < list.length; i++) {
					html += "<tr><td class='hide'>" + list[i].repeatid + "</td>";
					html += "<td>" + list[i].repeatcycle + "</td>";
					html += "<td>" + $.getMonth(list[i].date) + "-" + $.getDay(list[i].date) + "</td>";
					html += "<td>" + list[i].catename + "</td>";
					html += "<td><div>" + list[i].content + "</div><div><span class='fs-16 info'>" + list[i].assetname + "</span></div><div class='hide'>" + list[i].assetid + "</div></td>";
					if(list[i].moneytype == "수입") {
						html += "<td class='text-right blue'>" + parseInt(list[i].total).toLocaleString() + "원</td>";
					} else {
						html += "<td class='text-right red'>" + parseInt(list[i].total).toLocaleString() + "원</td>";
					}
					html += "<td id='delete-repeat-icon'><i class='fi fi-rr-cross red'></i></td></tr>"
				}
				html += "</table>"
				$("#repeat-list").html(html);
			}
		})

		$("#stats-div").hide();
		$("#add-account-div").hide();
		$("#update-account-div").hide();
		$("#repeat-list-div").show();
	})
	
	// 반복 내역 보여주기
	$(document).on("click", "#close-repeat-list", function() {
		$("#repeat-list-div").hide();
	})
	
	// 반복 내역 삭제
	$(document).on("click", "#delete-repeat-icon", function() {
		var rid= $(this).parent().children().eq(0).text();
		var op = confirm("정말로 삭제하시겠습니까?");
		if(op) {
			$.ajax({
				type: "post",
				url: "deleteRepeat",
				data: {
					repeatid: rid,
					userid: userid
				},
				success: function(res) {
					if(res == 1)
						window.location.reload();
					else
						alert("다시 시도해주세요.");
				}
			})
		}
	})
	/*
	// 수입 통계 보여주기
	$(document).on("click", "#in-stats-btn", function() {
		$.activeBtn("#out-stats-btn", "", "#in-stats-btn"); // 수입 버튼 활성화
		$.showStats($.categoryStatsList(today, userid, "income"));
		$(".td-statsTotal").attr("class", "blue");
	})
	
	// 지출 통계 보여주기
	$(document).on("click", "#out-stats-btn", function() {
		$.activeBtn("#in-stats-btn", "", "#out-stats-btn"); // 지출 버튼 활성화
		$.showStats($.categoryStatsList(today, userid, "spend"));
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
		var html = $.accountHtml($.detailsOfCategory(catename, moneytype, today, userid));
		$("#category-account-list-div").html(html);
		$("#category-name-div").html("<i class='fi fi-rr-usd-circle'></i> " + catename); // 카테고리명 html
		$.showCategoryTotal(moneytype); // 카테고리별 합계 html
		$("#details-category-div").show();
	})
	
	// 카테고리 내역 div 닫기
	$(document).on("click", "#close-category-account", function() {
		$("#details-category-div").hide();
	})
	*/
	/* 즐겨찾기 */
/*	// 즐겨찾기에 추가 가능한 내역 가져오기
	$.ajax({
		type : "post",
		url : "selectBookmark",
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
			success : function(res) {
				if(res == true) {
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
		url : "bookmarkList",
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
			url : "activeCategory",
			data : {
				moneytype : "지출",
				catename : catename,
				userid : userid
			},
			success : function(res) {
				if(res == true) {
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
				success : function(res) {
					if(res == true) {
						window.location.reload();
					} else {
						alert("다시 시도해주세요.");
					}
				}
			})
		}
	})*/
	
	/* 반복 */
/*	// 반복 추가 모달 열기
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
		
		if(!$.checkMustReg("#rep-actasset") || !$.checkMustReg("#rep-actcatename") || !$.checkMustReg("#rep-acttotal") || cycleChk == false){ // 정규식에 맞지 않을 때 (빈 값인 경우)
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

		if(!$.checkMustReg("#up-rep-actasset") || !$.checkMustReg("#up-rep-actcatename") || !$.checkMustReg("#up-rep-acttotal") || cycleChk == false){ // 정규식에 맞지 않을 때 (빈 값인 경우)
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
	})*/
})