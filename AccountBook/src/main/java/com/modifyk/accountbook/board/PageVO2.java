package com.modifyk.accountbook.board;

public class PageVO2 {
	private int totalBoard; // 총 게시물 개수
	private int totalPage; // 총 페이지 개수
	private int startPage; // 시작 페이지 번호
	private int endPage;  //  마지막 페이지 번호
	
	public PageVO2(int totalBoard, int showPage) {
		this.totalBoard = totalBoard;
		this.totalPage = (totalBoard - 1) / 10 + 1;
		this.startPage = (showPage - 1) * 5 + 1;
		this.endPage = showPage * 5;
	}

	public int getTotalBaord() {
		return totalBoard;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	@Override
	public String toString() {
		return String.format("PageVO2 [totalBaord=%s, totalPage=%s, startPage=%s, endPage=%s]", totalBoard, totalPage,
				startPage, endPage);
	}
	
}
