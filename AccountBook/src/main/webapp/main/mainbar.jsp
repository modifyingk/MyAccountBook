<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>	
	/* 메뉴 클릭 시 이벤트 -> 해당 메뉴에 대한 content 출력 */
	$(function() {
		$("li").click(function() { // li 클릭하면
			var idx = $(this).index(); // tab-ul li 중 클릭한 것이 몇 번째인지 확인
			if(idx == 0) {
				location.href = "/accountbook/main/main.jsp";
			} else if(idx == 1) {
				location.href = "/accountbook/member/sign_up.jsp";
			} else if(idx == 2) {
				location.href = "/accountbook/member/login.jsp"; // 로그인 페이지로
			} else if(idx == 3) {
				location.href = "/accountbook/member/find_id.jsp"; // 아이디 찾기 페이지로
			} else {
				location.href = "/accountbook/member/find_pw.jsp"; // 비밀번호 찾기 페이지로
			}
		})
	});
</script>