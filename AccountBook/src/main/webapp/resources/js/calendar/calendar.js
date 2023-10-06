document.write('<script src="../resources/js/cal_date.js"></script>'); // 이전 달, 다음 달 구하기 js
document.write('<script src="../resources/js/main.js"></script>'); // 모달 및 카테고리 설정 js

$(function() {
	var date = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
	var day = ["일", "월", "화", "수", "목", "금", "토"];
	
	var todayAll; // 현재 날짜 저장할 변수
	var todayYear; // 현재 연도 저장할 변수
	var todayMonth; // 현재 월 저장할 변수
	var todayDate; // 현재 일 저장할 변수
	
	var totalDate; // 전체 날짜 수
	
	/* 달력 생성
	   parameter : 연월, 연도, 월, 일 */
	$.calendar = function(todayAll, todayYear, todayMonth, todayDate) {
		// 연도와 월 보여주기
		var month_html = "<i class='h-normal fs-28'>" + todayYear + "년 " + todayMonth + "월" + "</i>";
		$("#month-div").html(month_html);
		
		date[1] = $.calYear(todayYear); // 평년 윤년 계산
		totalDate = $.calDay(todayYear, todayMonth, date); // 현재까지의 전체 날 수
		
		// 달력에 날짜 넣기
		var idx = parseInt(totalDate % 7); // 요일 index
		var j = 1;
		for(var i = 1; i <= date[parseInt(todayMonth) - 1]; i++) {
			if(idx + 1 > 6) {
				j++;
				idx = -1;
			}
			$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).html(i);
			
			if($("#month-div").text() + "-" + $(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).text() == todayAll + "-" + todayDate) {
				$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).addClass("active");
			} else {
				$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).removeClass("active");
			}
			idx++;
		}
		
		$.calendarList(todayAll);
	}
	
	/* 날짜별 수입/지출 내역
	   parameter : 현재 날짜 */
	$.calendarList = function(todayAll) {
		$.ajax({
			type : "post",
			url : "../account/calendarTotal",
			data : {
				date : todayAll,
				userid : userid
			},
			success : function(list) {
				for(var i = 1; i < 7; i++) {
					for(var j = 0; j < 7; j++) {
						var calNum = $(".calendar-table").children().children().eq(i).children().eq(j).children().eq(0).text();
						for(var k = 0; k < list.length; k++) {
							var dateNum = list[k].date.split("-")[2];
							if(dateNum.charAt(0) == "0") {
								dateNum = dateNum.replace("0", "");
							}
							if(dateNum == calNum) {
								if(list[k].moneytype == "수입") {
									$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(1).html("<i class='h-normal blue'>" + (list[k].total).toLocaleString() + "</i>");
								} else {
									$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(2).html("<i class='h-normal red'>" + (list[k].total).toLocaleString() + "</i>");
								}
							}
						}
					}
				}
			}
		})
	}
	
	// 달력 내용 다 지우기
	$.clearCalendar = function() {
		for(var i = 1; i < 7; i++) {
			for(var j = 0; j < 7; j++) {
				$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(0).html("");
				$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(1).html("");
				$(".calendar-table").children().children().eq(i).children().eq(j).children().eq(2).html("");
			}
		}
	}
	
	$(document).ready(function() {
		// 현재 날짜 가져오기
		todayAll = $.currentYM();
		todayYear = $.currentYear();
		todayMonth = $.currentMonth();
		todayDate = $.currentD();
		
		// 달력 생성 및 날짜별 수입/지출 합계 표시
		$.calendar(todayAll, todayYear, todayMonth, todayDate);
		
		// 모달 닫기
		$.closeModal("#close-date-account", "#date-account-modal");
		
		// 다른 영역 클릭 시 창 닫기
		$.autoClose("#select-month"); // 날짜 선택 닫기
	})
	
	// 이전 달 클릭
	$(document).on("click", "#before", function() {
		todayAll = $.beforeDate(todayAll); // 날짜 이전 달로 setting
		todayYear = todayAll.split("-")[0];
		todayMonth = todayAll.split("-")[1];
		
		$.clearCalendar(); // 달력 비우기
		$.calendar(todayAll, todayYear, todayMonth);
	})
	
	// 다음 달 클릭
	$(document).on("click", "#after", function() {
		todayAll = $.afterDate(todayAll); // 날짜 다음 달로 setting
		todayYear = todayAll.split("-")[0];
		todayMonth = todayAll.split("-")[1];
		
		$.clearCalendar(); // 달력 비우기
		$.calendar(todayAll, todayYear, todayMonth);
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
		todayAll = $("#current-year").text().split("년")[0] + "-" + $(this).text().split("월")[0];
		todayYear = todayAll.split("-")[0];
		todayMonth = todayAll.split("-")[1];
		
		$.clearCalendar(); // 달력 비우기
		$.calendar(todayAll, todayYear, todayMonth);
		
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
			var selectAll = todayAll + "-" + selectDate;
			
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
							html += "<td><div>" + list[i].content + "</div><div><span class='fs-16 info'>" + list[i].astname + "</span></div></td>";
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
