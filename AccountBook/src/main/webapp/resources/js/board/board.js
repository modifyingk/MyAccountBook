document.write('<script src="../resources/js/main.js"></script>'); // 모달 및 카테고리 설정 js

$(function() {
	var currentEndPage; // 현재 보여진 페이지 번호 중 마지막

	// 게시물 목록 불러오기 함수
	// parameter : 페이지
	$.boardList = function(currentPage) {
		// 게시물 목록
		$.ajax({
			type : "post",
			data : {
				currentPage : currentPage
			},
			async : false,
			url : "selectBoard",
			success : function(list) {
				var html;
				html = "<table class='list-table'>"; 
				for(var i = 0; i < list.length; i++) {
					var writer;
					if(list[i].isanony == "o") {
						writer = "익명";
					} else {
						writer = list[i].userid;
					}
					
					html += "<tr class='tr-board'><td style='display:none;'>" + list[i].bno + "</td><td><div class='fs-20'>" + list[i].title + "</div><div><span class='fs-16 info'>" + writer + " | " + list[i].date + "</span></div></td>";
					html += "</tr>";
					
				}
				html += "</table>";
				$("#board-list-div").html(html);
				
				// 페이지 번호
				var showPage;
				if(currentPage % 5 != 0) {
					showPage = parseInt(currentPage / 5) + 1;
				} else {
					showPage = parseInt(currentPage / 5);
				}
				$.ajax({
					url : "countBoard",
					data : {
						showPage : showPage
					},
					async : false,
					success : function(page) {
						var page_html = "";
						if(page.startPage > 5) {
							page_html += "<button class='btn outline-green page' id='before-btn'><</button>";
						}
						for(var i = page.startPage; i <= page.endPage; i++) {
							if(i > page.totalPage) break;
							page_html += "<button class='btn outline-green page page-btn'>" + i + "</button>";
						}
						if(page.totalPage > page.endPage) {
							page_html += "<button class='btn outline-green page' id='after-btn'>></button>";
						}
						$("#page-div").html(page_html);
						
						currentEndPage = page.endPage;
					}
				})
			}
		})
		return currentEndPage;
	}
	
	// 게시물 검색 함수
	// parameter : 페이지, 검색할 내용
	$.searchBoardList = function(currentPage) {
		// 게시물 목록
		$.ajax({
			type : "post",
			data : {
				currentPage : currentPage,
				search : $("#search").val()
			},
			async : false,
			url : "searchBoard",
			success : function(list) {
				var html;
				html = "<table class='list-table'>"; 
				for(var i = 0; i < list.length; i++) {
					var writer;
					if(list[i].isanony == "o") {
						writer = "익명";
					} else {
						writer = list[i].userid;
					}
					
					html += "<tr class='tr-board'><td style='display:none;'>" + list[i].bno + "</td><td><div class='fs-20'>" + list[i].title + "</div><div><span class='fs-16 info'>" + writer + " | " + list[i].date + "</span></div></td>";
					html += "</tr>";
					
				}
				html += "</table>";
				$("#board-list-div").html(html);
				
				// 페이지 번호
				var showPage;
				if(currentPage % 5 != 0) {
					showPage = parseInt(currentPage / 5) + 1;
				} else {
					showPage = parseInt(currentPage / 5);
				}
				$.ajax({
					url : "countSearch",
					data : {
						showPage : showPage,
						search : $("#search").val()
					},
					async : false,
					success : function(page) {
						var page_html = "";
						if(page.startPage > 5) {
							page_html += "<button class='btn outline-green page' id='search-before-btn'><</button>";
						}
						for(var i = page.startPage; i <= page.endPage; i++) {
							if(i > page.totalPage) break;
							page_html += "<button class='btn outline-green page search-page-btn'>" + i + "</button>";
						}
						if(page.totalPage > page.endPage) {
							page_html += "<button class='btn outline-green page' id='search-after-btn'>></button>";
						}
						$("#page-div").html(page_html);
						
						currentEndPage = page.endPage;
					}
				})
			}
		})
		return currentEndPage;
	}
	
	$(document).ready(function() {
		currentEndPage = $.boardList(1); // 처음에는 1페이지 보여줌
		$(".page-btn").eq(0).addClass("active");
	})
	
	// 페이지 번호 클릭 시 해당 게시물 보여주기
	$(document).on("click", ".page-btn", function() {
		var currentPage = $(this).text();
		$.boardList(currentPage);
		$(".page-btn").removeClass("active"); // active 클래스 모두 제거
		$(".page-btn").eq((currentPage % 5) - 1).addClass("active"); // 클릭한 페이지에 active 클래스 추가
	})
	
	// 이전 버튼 클릭 시
	$(document).on("click", "#before-btn", function() {
		$.boardList(currentEndPage - 5);
		$(".page-btn").removeClass("active"); // active 클래스 모두 제거
		$(".page-btn").eq(4).addClass("active"); // 시작 페이지 번호에 active 클래스 추가
	})
	
	// 다음 버튼 클릭 시
	$(document).on("click", "#after-btn", function() {
		$.boardList(currentEndPage + 1);
		$(".page-btn").removeClass("active"); // active 클래스 모두 제거
		$(".page-btn").eq(0).addClass("active"); // 마지막 페이지 번호에 active 클래스 추가
	})
	
	// 글 작성하기 버튼
	$(document).on("click", "#write_btn", function() {
		location.href = "/accountbook/board/write.jsp";
	})
	
	// 게시물 클릭 시 해당 게시물 보여주기
	$(document).on("click", ".tr-board", function() {
		var bno = $(this).children().eq(0).text();
		location.href = "boardInfo?bno=" + bno;
	})
	
	// 게시물 검색 버튼
	$(document).on("click", "#search-btn", function() {
		currentEndPage = $.searchBoardList(1); // 처음에는 1페이지 보여줌
		$(".search-page-btn").eq(0).addClass("active");
	})
	
	// 게시물 검색 취소
	$(document).on("click", "#reset-btn", function() {
		currentEndPage = $.boardList(1); // 처음에는 1페이지 보여줌
		$(".page-btn").eq(0).addClass("active");
		$("#search").val("");
	})
	
	// 게시물 검색 버튼에서 페이지 번호 클릭
	$(document).on("click", ".search-page-btn", function() {
		var currentPage = $(this).text();
		$.searchBoardList(currentPage);
		$(".search-page-btn").removeClass("active"); // active 클래스 모두 제거
		$(".search-page-btn").eq((currentPage % 5) - 1).addClass("active"); // 클릭한 페이지에 active 클래스 추가
	})
	
	// 게시물 검색 버튼에서 이전 버튼 클릭
	$(document).on("click", "#search-before-btn", function() {
		$.searchBoardList(currentEndPage - 5);
		$(".search-page-btn").removeClass("active"); // active 클래스 모두 제거
		$(".search-page-btn").eq(4).addClass("active"); // 시작 페이지 번호에 active 클래스 추가
	})
	
	// 게시물 검색 버튼에서 다음 버튼 클릭
	$(document).on("click", "#search-after-btn", function() {
		$.searchBoardList(currentEndPage + 1);
		$(".search-page-btn").removeClass("active"); // active 클래스 모두 제거
		$(".search-page-btn").eq(0).addClass("active"); // 마지막 페이지 번호에 active 클래스 추가
	})
})