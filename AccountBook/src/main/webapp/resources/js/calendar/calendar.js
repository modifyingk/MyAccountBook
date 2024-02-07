document.write('<script src="../resources/js/function/htmlFunc.js"></script>'); // html 함수
document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 유효성 검사 함수
document.write('<script src="../resources/js/function/dateFunc.js"></script>'); // 날짜 함수
document.write('<script src="../resources/js/calendar/calendarFunc.js"></script>'); // 날짜 함수

$(function() {
	var dates = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
	var days = ["일", "월", "화", "수", "목", "금", "토"];
	
	var today; // 현재 날짜 저장할 변수
	var year;
	var month;
	var day;
	/*
	var todayYear; // 현재 연도 저장할 변수
	var todayMonth; // 현재 월 저장할 변수
	var todayDate; // 현재 일 저장할 변수*/
	
	$(document).ready(function() {
		// 현재 날짜 가져오기
		date = $.createDate();
		today = $.getYearMonth(date);
		
		year = date.getFullYear();
		month = $.monthFmt(date.getMonth() + 1);
		day = $.dayFmt(date.getDate());
		/*
		todayYear = $.currentYear();
		todayMonth = $.currentMonth();
		todayDate = $.currentD();*/
		
		// 달력 생성 및 날짜별 수입/지출 합계 표시
		$.calendar(today, year, month, day);
		
		// 모달 닫기
		$.closeModal("#close-date-account", "#date-account-modal");
		
		// 다른 영역 클릭 시 창 닫기
		$.autoClose("#select-month"); // 날짜 선택 닫기
	})
	
	// 이전 달 클릭
	$(document).on("click", "#before", function() {
		today = $.beforeDate(today); // 날짜 이전 달로 setting
		year = $.getYear(today);
		month = $.getMonth(today);
		
		$.clearCalendar(); // 달력 비우기
		$.calendar(today, year, month, day);
	})
	
	// 다음 달 클릭
	$(document).on("click", "#after", function() {
		today = $.afterDate(today); // 날짜 다음 달로 setting
		year = $.getYear(today);
		month = $.getMonth(today);
		
		$.clearCalendar(); // 달력 비우기
		$.calendar(today, year, month, day);
	})
	
	// 날짜 선택
	$(document).on("click", "#month-div", function() {
		$.showSelectDate(year);
	})
	
	// 날짜 선택에서 이전 연도 클릭
	$(document).on("click", "#before-year", function() {
		year = $.selectBeforeYear(year);
	})
	
	// 날짜 선택에서 다음 연도 클릭
	$(document).on("click", "#after-year", function() {
		year = $.selectAfterYear(year);
	})
	
	// 날짜 월 선택 시 보여줄 연월 값 변경
	$(document).on("click", ".month-td", function() {
		today = $("#current-year").text().split("년")[0] + "-" + $(this).text().split("월")[0];
		year = $.getYear(today);
		month = $.getMonth(today);

		$.clearCalendar(); // 달력 비우기
		$.calendar(today, year, month, day);
		
		$("#select-month").hide();
	})
	
	// 달력 네모 칸 선택 시 해당 내역 보여주기
	$(".calendar-table .tr-content td").click(function() {
		if($(this).children().eq(0).text() != "") {
			var selectDate = $(this).children().eq(0).text(); // 요일
			var selectIn = $(this).children().eq(1).text(); // 수입
			var selectOut = $(this).children().eq(2).text(); // 지출
				
			if(selectDate.length == 1) {
				selectDate = "0" + selectDate;
			}
			var selectAll = today + "-" + selectDate;
			
			$.ajax({
				type : "post",
				url : "../account/dateAccount",
				data : {
					date : selectAll,
					userid : userid
				},
				success : function(list) {
					var total_income = 0;
					var total_spend = 0;
					
					var html = "";
					
					if(list != "") {
						html = "<table class='list-table'>";
						for(var i = 0; i < list.length; i++) {
							html += "<tr><td style='display:none;'>" + list[i].accountid + "</td>";
							html += "<td>" + list[i].catename + "</td>";
							html += "<td><div>" + list[i].content + "</div><div><span class='fs-16 info'>" + list[i].assetname + "</span></div></td>";
							if(list[i].moneytype == "수입") {
								html += "<td class='text-right blue'>" + list[i].total.toLocaleString() + "</td></tr>";
								total_income += list[i].total;
							} else {
								html += "<td class='text-right red'>" + list[i].total.toLocaleString() + "</td></tr>";
								total_spend += list[i].total;
							}
						}
						html += "</table>";
					} else {
						html = "<div class='no-data-div'><i class='fi fi-rr-cloud-question fs-35'></i><br>데이터가 없습니다.</div>";
					}
					
					var date_html = "<h3 class='h-normal fs-28'><i class='fi fi-rs-calendar-check'></i> " + selectAll + "</h3>";
					var in_html = "<h4 class='h-normal fs-18 info'>총 수입</h4><i class='blue h-normal fs-20'>" + total_income.toLocaleString() + "원</i>";
					var out_html = "<h4 class='h-normal fs-18 info'>총 지출</h4><i class='red h-normal fs-20'>" + total_spend.toLocaleString() + "원</i>";
					
					$("#select-date-div").html(date_html);
					$("#total-income-div").html(in_html);
					$("#total-spend-div").html(out_html);
					$("#date-account-list-div").html(html);
					
					$("#date-account-modal").show();
				}
			})
		}
	})
})
