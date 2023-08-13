<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>	
/* 메뉴 클릭 시 이벤트 -> 해당 메뉴에 대한 content 출력 */
$(function() {
	$("li").click(function() { // li 클릭하면
		var idx = $(this).index(); // tab-ul li 중 클릭한 것이 몇 번째인지 확인
		$("li").removeClass("active"); // active 클래스 지워줌
		$(this).addClass("active"); // 클릭한 것에 active 클래스 추가
		if(idx == 0) {
			location.href = "/accountbook/member/mypage.jsp";
		} else if(idx == 1) {
			location.href = ""; // 수입지출관리 페이지로
		} else if(idx == 2) {
			location.href = "/accountbook/asset/asset.jsp"; // 자산관리 페이지로
		} else if(idx == 3) {
			location.href = ""; // 캘린더 페이지로
		} else {
			location.href = ""; // 목표지출 페이지로
		}
	});
});
</script>
<img src="../resources/img/logo.png" style="width: 90%;" onclick="location.href='../main/main.jsp'">
<ul class="menu-group">
	<li class="menu active"><i class="fi fi-rr-home"></i> 메인페이지</li>
	<li class="menu"><i class="fi fi-rr-add"></i> 수입/지출 관리</li>		
	<li class="menu"><i class="fi fi-rr-coins"></i> 자산관리</li>		
	<li class="menu"><i class="fi fi-rs-calendar-check"></i> 캘린더</li>		
	<li class="menu"><i class="fi fi-rs-chart-histogram"></i> 목표지출</li>
</ul>