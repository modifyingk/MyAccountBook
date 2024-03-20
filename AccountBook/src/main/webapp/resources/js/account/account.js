document.write('<script src="../resources/js/function/htmlFunc.js"></script>'); // html 함수
document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 유효성 검사 함수
document.write('<script src="../resources/js/function/dateFunc.js"></script>'); // 날짜 함수
document.write('<script src="../resources/js/asset/assetFunc.js"></script>'); // 자산 함수

//수입/지출 내역
function accountList(dateVal, useridVal) {
	$.ajax({
		type : "post",
		url : "selectAccount",
		data : {
			date : dateVal,
			userid : useridVal,
		},
		success : function(res) {
			$("#account-list-div").html(""); // 비우고
			$("#account-list-div").append(res); // 추가
		}
	})
}

// 미니 달력
function makeCalendar(today) {
	$.ajax({
		type: "post",
		url: "makeCalendar",
		data: {
			date: today,
			userid: userid,
			type: "mini"
		},
		success: function(res) {
			$("#left-div1").html(res);
		}
	})
}

// 소분류
function smallcateList(bigcate, mtype, divID) {
	$.ajax({
		type: "post",
		url: "../category/selectSmallcate",
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
			$(divID).html(html);
		}
	})
}

$(function() {
	var date;
	var today; // 현재 날짜 저장할 변수
	var year; // 현재 연도 저장할 변수
	var month; // 현재 월 저장할 변수
	
	$(document).ready(function() {
		// 현재 날짜 가져오기
		date = createDate();
		today = getYearMonth(date); // yyyymm
		year = date.getFullYear(); 
		month = date.getMonth() + 1;
		
		
		setDate(year, month); // 날짜 세팅
		accountList(today, userid); // 월별 수입/지출 목록
		makeCalendar(today);
		
		$("#add-date").attr("value", makeDateFmt(date)); // 현재 날짜로 미리 값 세팅
		
		// 금액에 숫자만 입력되도록
		onlyNum("#update-total");
		onlyNum("#add-total");
		
		// 금액 세 자리마다 콤마
		moneyFmt("#update-total");
		moneyFmt("#add-total");
	
		// 다른 영역 클릭 시 창 닫기
		autoClose("#select-date"); // 날짜 선택 닫기
		autoClose(".select-add-asset"); // 자산 선택 닫기
		autoClose(".select-add-incate"); // 분류 선택 닫기
		autoClose(".select-add-outcate"); // 분류 선택 닫기
		autoClose(".select-add-smallcate"); // 분류 선택 닫기
		autoClose(".select-update-asset"); // 자산 선택 닫기
		autoClose(".select-update-incate"); // 분류 선택 닫기
		autoClose(".select-update-outcate"); // 분류 선택 닫기
		autoClose(".select-update-smallcate"); // 분류 선택 닫기
		autoClose("#search-list"); // 검색 자동완성 닫기
		
	})

	// 날짜 선택 창 보여주기
	$(document).on("click", "#date-div", function() {
		showSelectDate(year);
	})
	
	// 날짜 선택 창에서 이전 연도 클릭
	$(document).on("click", "#last-year", function() {
		year = selectLastYear(year);
	})
	
	// 날짜 선택 창에서 다음 연도 클릭
	$(document).on("click", "#next-year", function() {
		year = selectNextYear(year);
	})
	
	// 날짜 선택 창에서 월 선택
	$(document).on("click", ".select-month td", function() {
		$("#mini-calendar td").removeClass("active");
		$(".show-range").removeClass("active");
		$("#show-all").addClass("active");
		
		today = selectDate($("#select-year").text(), $(this).text());
		year = getYear(today);
		month = getMonth(today);
		
		setDate(year, month);
		accountList(today, userid)
		makeCalendar(today);
		
		$("#select-date").hide();
	})
	
	// 이전 달 클릭
	$(document).on("click", "#last-month", function() {
		$("#mini-calendar td").removeClass("active");
		$(".show-range").removeClass("active");
		$("#show-all").addClass("active");
		
		today = lastMonth(today);
		year = getYear(today);
		month = getMonth(today);
		
		setDate(year, month);
		accountList(today, userid);
		makeCalendar(today);
	})
	
	// 다음 달 클릭
	$(document).on("click", "#next-month", function() {
		$("#mini-calendar td").removeClass("active");
		$(".show-range").removeClass("active");
		$("#show-all").addClass("active");
		
		today = nextMonth(today);
		year = getYear(today);
		month = getMonth(today);
		
		setDate(year, month);
		accountList(today, userid);
		makeCalendar(today);
	})

	// 수입/지출 내역 옵션 (전체/수입/지출)
	$(document).on("click", "#show-all", function() {
		$(".tr-date").show();
		$(".td-income").parent().show();
		$(".td-spend").parent().show();
		$(".part-income").show();
		$(".part-spend").show();
		$(".show-range").removeClass("active");
		$("#show-all").addClass("active");
	})
	$(document).on("click", "#show-income", function() {
		$(".tr-date").show();
		let n = $(".part-income").length;
		for(let i = 0; i < n; i++) {
			if($(".part-income").eq(i).text() == "0원") {
				$(".tr-date").eq(i).hide();
			}
		}
		$(".td-spend").parent().hide();
		$(".td-income").parent().show();
		$(".part-spend").hide();
		$(".part-income").show();
		$(".show-range").removeClass("active");
		$("#show-income").addClass("active");
	})
	$(document).on("click", "#show-spend", function() {
		$(".tr-date").show();
		let n = $(".part-spend").length;
		for(let i = 0; i < n; i++) {
			if($(".part-spend").eq(i).text() == "0원") {
				$(".tr-date").eq(i).hide();
			}
		}
		$(".td-income").parent().hide();
		$(".td-spend").parent().show();
		$(".part-income").hide();
		$(".part-spend").show();
		$(".show-range").removeClass("active");
		$("#show-spend").addClass("active");
	})
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
	
	// 수입/지출 추가 - 수입/지출 선택
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
		$("#add-smallcate").attr("value", "");
	})
	
	// 수입/지출 추가 - 자산 선택
	$(document).on("click", "#add-asset", function() {
		showSelectAsset("#add-asset-list");
		$(".select-add-asset").show();
	})
	$(document).on("click", ".select-add-asset tr", function() {
		let assetVal = $(this).children().eq(0).text();
		$("#add-asset").attr("value", assetVal);
		$(".select-add-asset").hide();
	})
	
	// 수입/지출 수정 - 자산 선택
	$(document).on("click", "#update-asset", function() {
		showSelectAsset("#update-asset-list");
		$(".select-update-asset").show();
	})
	$(document).on("click", ".select-update-asset tr", function() {
		let assetVal = $(this).children().eq(0).text();
		$("#update-asset").attr("value", assetVal);
		$(".select-update-asset").hide();
	})
	
	// 수입/지출 추가 - 대분류 선택
	$(document).on("click", "#add-bigcate", function() {
		let mtype = $(".switch label").text(); // 선택된 값 변수에 저장
			if(mtype == "수입") {
				$(".select-add-incate").show();
			} else {
				$(".select-add-outcate").show();
			}
	})
	$(document).on("click", ".select-add-incate td", function() {
		let categoryVal = $(this).text();
		$("#add-bigcate").attr("value", categoryVal);
		$(".select-add-incate").hide();
	})
	$(document).on("click", ".select-add-outcate td", function() {
		let categoryVal = $(this).text();
		$("#add-bigcate").attr("value", categoryVal);
		$(".select-add-outcate").hide();
	})
	
	// 수입/지출 수정 - 대분류 선택
	$(document).on("click", "#update-bigcate", function() {
		let mtype = $("input[name=update-mtype]:checked").val(); // 선택된 값 변수에 저장
		if(mtype == "수입") {
			$(".select-update-incate").show();
		} else if(mtype == "지출"){
			$(".select-update-outcate").show();
		}
	})
	$(document).on("click", ".select-update-incate td", function() {
		let categoryVal = $(this).text();
		$("#update-bigcate").attr("value", categoryVal);
		$(".select-update-incate").hide();
	})
	$(document).on("click", ".select-update-outcate td", function() {
		let categoryVal = $(this).text();
		$("#update-bigcate").attr("value", categoryVal);
		$(".select-update-outcate").hide();
	})
	
	// 수입/지출 추가 - 대분류 선택 시 소분류 활성화
	$(document).on("click", ".select-add-incate, .select-add-outcate .select-table", function() {
		let bigcate = $("#add-bigcate").val();
		if(bigcate != "") {
			$("#add-smallcate").attr("disabled", false);
		} else {
			$("#add-smallcate").attr("disabled", true);
		}
		$("#add-smallcate").attr("value", "");
	})
	
	// 수입/지출 수정 - 대분류 선택 시 소분류 활성화
	$(document).on("click", ".select-update-incate, .select-update-outcate .select-table", function() {
		let bigcate = $("#update-bigcate").val();
		if(bigcate != "") {
			$("#update-smallcate").attr("disabled", false);
		} else {
			$("#update-smallcate").attr("disabled", true);
		}
		$("#update-smallcate").attr("value", "");
	})
	
	// 수입/지출 추가 - 소분류 보여주기
	$(document).on("click", "#add-smallcate", function() {
		let mtype = $("input[name='add-moneytype']+label").text();
		let bigcate = $("#add-bigcate").val();
		smallcateList(bigcate, mtype, ".select-add-smallcate");
		$(".select-add-smallcate").show();
	})
	// 수입/지출 추가 - 소분류 선택 및 값 자동 입력
	$(document).on("click", ".select-add-smallcate td", function() {
		let categoryVal = $(this).text();
		$("#add-smallcate").attr("value", categoryVal);
		$(".select-add-smallcate").hide();
	})
	
	// 수입/지출 수정 - 소분류 보여주기
	$(document).on("click", "#update-smallcate", function() {
		let mtype = $("input[name='update-moneytype']+label").text();
		let bigcate = $("#update-bigcate").val();
		smallcateList(bigcate, mtype, ".select-update-smallcate");
		$(".select-update-smallcate").show();
	})
	// 수입/지출 수정 - 소분류 선택 및 값 자동 입력
	$(document).on("click", ".select-update-smallcate td", function() {
		let categoryVal = $(this).text();
		$("#update-smallcate").attr("value", categoryVal);
		$(".select-update-smallcate").hide();
	})
	
	// 수입/지출 추가
	$(document).on("click", "#add-account-btn", function() {
		let mtype = $(".switch label").text();
		let date = $("#add-date").val().replaceAll("-", "");
		let asset = $("#add-asset").val();
		let bigcate = $("#add-bigcate").val();
		let smallcate = $("#add-smallcate").val();
		let content = $("#add-content").val();
		let total = $("#add-total").val().replaceAll(",", "");
		
		if(!checkMustReg(date) || !checkMustReg(asset) || !checkMustReg(bigcate) || !checkMustReg(total)){ // 정규식에 맞지 않을 때 (빈 값인 경우)
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
					if(res > 0) {
						let html = "<tr class='tr-content'>" +
								"<td class='hide' id='td-key'>" + date + "</td>" +
								"<td class='hide'>" + res + "</td>" +
								"<td class='hide'>" + mtype + "</td><td class='td-category'>";
						if(mtype == "수입") {
							html += "<div class='key-div income'>" + bigcate + "</div>" +
									"<div class='td-smallcate income'>" + smallcate + "</div>";
						} else if(mtype == "지출") {
							html += "<div class='key-div spend'>" + bigcate + "</div>" +
							"<div class='td-smallcate spend'>" + smallcate + "</div>";
						}
						html += "<td class='td-content'>" + content + "</td>" +
								"<td class='td-asset gray'>" + asset + "</td>";
						if(mtype == "수입") {
							html += "<td class='td-income text-right blue'>" + parseInt(total).toLocaleString() + "원</td></tr>";
						} else if(mtype == "지출") {
							html += "<td class='td-spend text-right red'>" + (parseInt(total) * -1).toLocaleString() + "원</td></tr>";
						}
						
						if($("#account-list-div table").hasClass(date)) {  // 해당 날짜 내역이 존재한다면
							$("." + date).append(html);
						} else { // 해당 날짜 내역이 존재하지 않는다면
							window.location.reload();
						}
						
					} else {
						alert("다시 시도해주세요.")
					}
				}
			})
		}
	})
	
	// 수입/지출 내역 내용 tr 클릭 시 수정 모달 열기
	$(document).on("click", "#account-list-div .tr-content", function() {
		$("#update-account-modal").show();
		
		let date = $(this).children().eq(0).text();
		let id = $(this).children().eq(1).text();
		let mtype = $(this).children().eq(2).text();
		let bigcate = $(this).children().eq(3).children().eq(0).text();
		let smallcate = $(this).children().eq(3).children().eq(1).text();
		let asset = $(this).children().eq(4).text();
		let content = $(this).children().eq(5).text();
		let total = $(this).children().eq(6).text().replace("-", "");
		
		// 수정 모달 값 setting
		$("#update-date").attr("value", getDateFmt(date));
		$("#update-id").attr("value", id);
		$("#update-bigcate").attr("value", bigcate);
		$("#update-smallcate").attr("value", smallcate);
		$("#update-content").attr("value", content);
		$("#update-asset").attr("value", asset);
		$("#update-total").attr("value", total.split("원")[0]);
		if(mtype == "수입") {
			$("#update-in").attr("checked", true);
			$("#update-out").attr("checked", false);
		} else {
			$("#update-out").attr("checked", true);
			$("#update-in").attr("checked", false);
		}
		pickAsset("#update-asset"); // 자산 선택 및 값 자동 입력
		pickBigcate("#update-bigcate"); // 대분류 선택 및 값 자동 입력
	})
	
	// 수입/지출 수정 div 닫기
	$(document).on("click", "#close-update-account", function() {
		$("#update-account-modal").hide();
	})
	
	// 수입/지출 수정
	$(document).on("click", "#update-account-btn", function() {
		let date = $("#update-date").val().replaceAll("-", "");
		let id = $("#update-id").val();
		let bigcate = $("#update-bigcate").val();
		let smallcate = $("#update-smallcate").val();
		let content = $("#update-content").val();
		let asset = $("#update-asset").val();
		let total = $("#update-total").val().replaceAll(",", "");
		
		if(!checkMustReg(date) || !checkMustReg(asset) || !checkMustReg(bigcate) || !checkMustReg(total)){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			$.ajax({
				type : "post",
				url : "updateAccount",
				data : {
					accountid: id,
					moneytype :  $("input[name=update-mtype]:checked").val(),
					date: date,
					assetname: asset,
					bigcate: bigcate,
					smallcate: smallcate,
					content: content,
					total: total,
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
		let id = $("#update-id").val();
		var op = confirm("내역을 삭제하시겠습니까?")
		if(op) {
			$.ajax({
				type : "post",
				url : "deleteAccount",
				data : {
					accountid : id,
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
	
	// 검색 자동완성
	$(document).on("keyup", "#search-input", function() {
		let value = $("#search-input").val();
		if(value.length > 0) {
			$.ajax({
				type : "post",
				url : "autoComplete",
				data : {
					content : value,
					userid : userid
				},
				success : function(res) {
					$("#search-list").html(res);
					$("#search-list").show();
				}
			})
		}
	})
	$(document).on("click", "#search-list td", function() {
		let value = $(this).text().trim();
		$("#search-input").prop("value", value);
		$("#search-list").hide();
	})
	
	// 수입/지출 검색
	$(document).on("click", "#search-btn", function() {
		let value = $("#search-input").val();
			$.ajax({
				type : "post",
				url : "searchAccount",
				data : {
					content : value,
					userid : userid,
					date: today
				},
				success : function(res) {
					result = res;
					$("#account-list-div").html("");
					$("#account-list-div").append(result);
				}
			})
	})
	
	// 미니 달력 날짜 선택
	$(document).on("click", "#mini-calendar .il", function() {
		let value = $(this).children().children().eq(1).text(); // 선택 날짜

		$("#mini-calendar td").removeClass("active");
		$(this).addClass("active");
			
		let className = today + twoDigits(value);
		$(".account-table").show();
		$(".account-table").not("." + className).hide(); // 선택 날짜 빼고 숨기기
	})
	
	// 미니 달력 요일 선택
	$(document).on("click", ".yoil td", function() {
		let value = $(this).text(); // 선택 요일

		$("#mini-calendar td").removeClass("active");
		$(this).addClass("active");
			
		let className = value;
		$(".account-table").show();
		$(".account-table").not("." + className).hide(); // 선택 요일 빼고 숨기기
	})
	
	// 미니 달력 월 클릭 시 원래대로
	$(document).on("click", "#mini-date-div", function() {
		$("#mini-calendar td").removeClass("active");
		$(".account-table").show();
	})
	
	/*
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