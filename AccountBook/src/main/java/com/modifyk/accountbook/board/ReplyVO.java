package com.modifyk.accountbook.board;

public class ReplyVO {
	private int rno;
	private String content;
	private String userid;
	private String isanony;
	private int bno;
	private String date;
	
	public int getRno() {
		return rno;
	}
	public void setRno(int rno) {
		this.rno = rno;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getIsanony() {
		return isanony;
	}
	public void setIsanony(String isanony) {
		this.isanony = isanony;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	@Override
	public String toString() {
		return String.format("ReplyVO [rno=%s, content=%s, userid=%s, isanony=%s, bno=%s, date=%s]", rno, content,
				userid, isanony, bno, date);
	}
	
}
