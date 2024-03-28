document.write('<script src="../resources/js/function/htmlFunc.js"></script>'); // html 함수
document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 유효성 검사 함수
document.write('<script src="../resources/js/function/dateFunc.js"></script>'); // 날짜 함수
document.write('<script src="../resources/js/asset/assetFunc.js"></script>'); // 자산 함수

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
		selectRepeat(twoDigits(month));
		
		$("#add-date").attr("value", makeDateFmt(date)); // 현재 날짜로 미리 값 세팅
		
		// 금액에 숫자만 입력되도록
		onlyNum("#update-total");
		onlyNum("#add-total");
		onlyNum("#repeat-date");
		
		// 금액 세 자리마다 콤마
		moneyFmt("#update-total");
		moneyFmt("#add-total");
		moneyFmt("#repeat-total");
	
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
		autoClose(".select-withdraw"); // 출금 자산 선택 닫기
		autoClose(".select-deposit"); // 입금 자산 선택 닫기
		autoClose("#search-list"); // 검색 자동완성 닫기
		autoClose(".repeatMenu"); // 반복 선택 닫기 
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
		selectRepeat(twoDigits(month));
		
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
		selectRepeat(twoDigits(month));
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
		selectRepeat(twoDigits(month));
	})

	// 수입/지출 내역 옵션 (전체/수입/지출)
	$(document).on("click", "#show-all", function() {
		$(".tr-date").show();
		$(".td-income").parent().show();
		$(".td-spend").parent().show();
		$(".td-transfer").parent().show();
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
				$(".part-income").eq(i).parent().parent().hide();
			}
		}
		$(".td-spend").parent().hide();
		$(".td-transfer").parent().hide();
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
				$(".part-spend").eq(i).parent().parent().hide();
			}
		}
		$(".td-income").parent().hide();
		$(".td-transfer").parent().hide();
		$(".td-spend").parent().show();
		$(".part-income").hide();
		$(".part-spend").show();
		$(".show-range").removeClass("active");
		$("#show-spend").addClass("active");
	})
	
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
	
	// 이체 내역 수정 - 자산 선택
	$(document).on("click", "#transfer-withdraw", function() {
		showSelectAsset("#withdraw-list");
		$(".select-withdraw").show();
	})
	$(document).on("click", ".select-withdraw tr", function() {
		let assetVal = $(this).children().eq(0).text();
		$("#transfer-withdraw").attr("value", assetVal);
		$(".select-withdraw").hide();
	})
	$(document).on("click", "#transfer-deposit", function() {
		showSelectAsset("#deposit-list");
		$(".select-deposit").show();
	})
	$(document).on("click", ".select-deposit tr", function() {
		let assetVal = $(this).children().eq(0).text();
		$("#transfer-deposit").attr("value", assetVal);
		$(".select-deposit").hide();
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
		let mtype = $(this).children().eq(2).text();
		let date = $(this).children().eq(0).text();
		let id = $(this).children().eq(1).text();
		let bigcate = $(this).children().eq(3).children().eq(0).text();
		let smallcate = $(this).children().eq(3).children().eq(1).text();
		let asset = $(this).children().eq(4).text();
		let content = $(this).children().eq(5).text();
		let total = $(this).children().eq(6).text().replace("-", "");
		
		if(mtype == "이체") {
			$("#update-transfer-modal").show();
			$("#transfer-date").attr("value", getDateFmt(date));
			$("#transfer-id").attr("value", id);
			$("#transfer-content").attr("value", content);
			$("#transfer-withdraw").attr("value", asset.split("→")[0]);
			$("#transfer-deposit").attr("value", asset.split("→")[1]);
			$("#transfer-total").attr("value", total.split("원")[0]);
			
		} else {
			$("#update-account-modal").show();
			
			let date = $(this).children().eq(0).text();
			let id = $(this).children().eq(1).text();
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
		}
	})
	
	// 수입/지출 수정 모달 닫기
	$(document).on("click", "#close-update-account", function() {
		$("#update-account-modal").hide();
	})
	
	// 이체 내역 수정 모달 닫기
	$(document).on("click", "#close-update-transfer", function() {
		$("#update-transfer-modal").hide();
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
	
	// 이체 내역 수정
	$(document).on("click", "#update-transfer-btn", function() {
		let date = $("#transfer-date").val().replaceAll("-", "");
		let id = $("#transfer-id").val();
		let content = $("#transfer-content").val();
		let withdraw = $("#transfer-withdraw").val();
		let deposit = $("#transfer-deposit").val();
		let total = $("#transfer-total").val().replaceAll(",", "");
		
		let asset = withdraw + "→" + deposit;
		
		if(!checkMustReg(date) || !checkMustReg(withdraw) || !checkMustReg(deposit) || !checkMustReg(total)){ // 정규식에 맞지 않을 때 (빈 값인 경우)
			alert("입력 값을 확인해주세요.")
		} else {
			$.ajax({
				type : "post",
				url : "updateTransfer",
				data : {
					accountid: id,
					date: date,
					assetname: asset,
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

	// 이체 내역 삭제
	$(document).on("click", "#delete-transfer-btn", function() {
		let id = $("#transfer-id").val();
		var op = confirm("내역을 삭제하시겠습니까?")
		if(op) {
			$.ajax({
				type : "post",
				url : "deleteTransfer",
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
	
	// 반복 설정
	$(document).on("mousedown", "#account-list-div .tr-content", function(e) {
		let date = $(this).children().eq(0).text();
		let mtype = $(this).children().eq(2).text();
		let bigcate = $(this).children().eq(3).children().eq(0).text();
		let smallcate = $(this).children().eq(3).children().eq(1).text();
		let asset = $(this).children().eq(4).text();
		let content = $(this).children().eq(5).text();
		let total = $(this).children().eq(6).text().split("원")[0];
		
		if(event.button == 2) { // 우클릭
			window.oncontextmenu = function() {
				return false;
			}
			let x = e.pageX + 'px';
			let y = e.pageY + 'px';
			
			const repeatMenu = $(".repeatMenu");
			repeatMenu.css("position", "absolute");
			repeatMenu.css("left", x);
			repeatMenu.css("top", y);
			repeatMenu.css("display", "block");
			
			insertRepeat(mtype, date, asset, bigcate, smallcate, content, total);
			event.stopImmediatePropagation();
		}
	})
	
	// 반복 삭제
	$(document).on("click", "#delete-repeat-btn", function() {
		let op = confirm("정말로 삭제하시겠습니까?");
		let repeatid = $("#repeat-id").val();
		if(op) {
			$.ajax({
				type: "post",
				url: "../repeat/deleteRepeat",
				data: {
					repeatid: repeatid,
					userid: userid
				},
				success: function(res) {
					if(res == true) {
						window.location.reload();
					} else {
						alert("다시 시도해주세요");
					}
				}
			})
		}
	})
	
	// 반복 내역 모달 닫기
	$(document).on("click", "#close-update-repeat", function() {
		$("#update-repeat-modal").hide();
	})
})

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

//반복 중복확인
function overlapRepeat(mtype, date, asset, bigcate, smallcate, content, total) {
	var result;
	$.ajax({
		type: "post",
		url: "../repeat/overlapRepeat",
		async: false,
		data: {
			moneytype: mtype,
			date: date,
			assetname: asset,
			bigcate: bigcate,
			smallcate: smallcate,
			content: content,
			total: total.replaceAll(",", ""),
			userid: userid
		},
		success: function(res) {
			result = res;
		}
	})
	return result;
}

// 반복 추가
function insertRepeat(mtype, date, asset, bigcate, smallcate, content, total) {
	$(document).on("click", "#set-repeat tr", function() {
		let select = $(this).text();
		let repeatcycle;
		if(select == "매월 반복") {
			repeatcycle = "매월";
		} else if(select == "매년 반복") {
			repeatcycle = "매년";
		}
		let op = confirm("해당 내역을 " + repeatcycle + " 반복하시겠습니까?");
		if(op) {
			let chk = overlapRepeat(mtype, date, asset, bigcate, smallcate, content, total);
			if(chk) {
				$.ajax({
					type: "post",
					url: "../repeat/insertRepeat",
					data: {
						repeatcycle: repeatcycle,
						moneytype: mtype,
						date: date,
						assetname: asset,
						bigcate: bigcate,
						smallcate: smallcate,
						content: content,
						total: total.replaceAll(",", ""),
						userid: userid
					},
					success: function(res) {
						if(res == true) {
							window.location.reload();
						} else {
							alert("다시 시도해주세요");
						}
					}
				})
			} else {
				alert("반복이 설정되어 있는 내역입니다.");
			}
			
		}
		$(".repeatMenu").hide();
	})
}


//반복 내역
function selectRepeat(month) {
	$.ajax({
		type: "post",
		url: "../repeat/selectRepeat",
		data: {
			date: month,
			userid: userid,
		},
		success: function(res) {
			$("#schedule-list").html(res);
		}
	})
}