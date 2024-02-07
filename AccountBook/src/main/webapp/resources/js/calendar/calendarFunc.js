$(function() {
	/* 달력 생성 */
	$.calendar = function(today, y, m, d) {

		// 연도와 월 보여주기
		var month_html = "<i class='h-normal fs-28'>" + y + "년 " + m + "월" + "</i>";
		$("#month-div").html(month_html);
		
		var dates = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		var days = ["일", "월", "화", "수", "목", "금", "토"];
		
		dates[1] = $.calcYear(y); // 평년 윤년 계산
		totalDays = $.calcDay(y, m); // 현재까지의 전체 날 수
		
		// 달력에 날짜 넣기
		var idx = parseInt(totalDays % 7); // 요일 index
		var j = 1;
		for(var i = 1; i <= dates[parseInt(m) - 1]; i++) {
			if(idx + 1 > 6) {
				j++;
				idx = -1;
			}
			$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).html(i);
			
			var htmlMonthVal = $("#month-div").text().substring(0, 4) + "-" + $("#month-div").text().substring(6, 8);
			
			if(htmlMonthVal + "-" + $.dayFmt($(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).text()) == today + "-" + d) {
				$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).addClass("active");
			} else {
				$(".calendar-table").children().children().eq(j).children().eq(idx + 1).children().eq(0).removeClass("active");
			}
			idx++;
		}
		
		$.calendarList(today);
	}
	
	/* 날짜별 수입/지출 내역  */
	$.calendarList = function(today) {
		$.ajax({
			type : "post",
			url : "../account/calendarTotal",
			data : {
				date : today,
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
})
