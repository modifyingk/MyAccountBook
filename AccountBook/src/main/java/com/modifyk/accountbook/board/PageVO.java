package com.modifyk.accountbook.board;

public class PageVO {
	private int startBoard; // 현제 페이지 시작 게시물 번호
	private int endBoard;  // 현재 페이지 마지막 게시물 번호
	private int currentPage; // 현재 페이지 번호
	
	public PageVO(int pageSize, int currentPage) {
		this.currentPage = currentPage;
		this.startBoard = 1 + (currentPage - 1) * pageSize;
		this.endBoard = currentPage * pageSize;
	}

	public int getStartBoard() {
		return startBoard;
	}

	public int getEndBoard() {
		return endBoard;
	}

	public int getCurrentPage() {
		return currentPage;
	}
	
}
