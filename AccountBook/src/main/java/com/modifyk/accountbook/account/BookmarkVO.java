package com.modifyk.accountbook.account;

public class BookmarkVO {
	private int bookmarkid;
	private String catename;
	private String content;
	private int total;
	private String userid;
	private String moneytype;

	public int getBookmarkid() {
		return bookmarkid;
	}
	public void setBookmarkid(int bookmarkid) {
		this.bookmarkid = bookmarkid;
	}
	public String getCatename() {
		return catename;
	}
	public void setCatename(String catename) {
		this.catename = catename;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getMoneytype() {
		return moneytype;
	}
	public void setMoneytype(String moneytype) {
		this.moneytype = moneytype;
	}
	@Override
	public String toString() {
		return "BookmarkVO [bookmarkid=" + bookmarkid + ", catename=" + catename + ", content=" + content + ", total="
				+ total + ", userid=" + userid + "moneytype=" + moneytype + "]";
	}
	
}
