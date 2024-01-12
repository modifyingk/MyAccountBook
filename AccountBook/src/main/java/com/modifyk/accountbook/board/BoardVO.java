package com.modifyk.accountbook.board;

import java.util.List;

public class BoardVO {
	private int bno;
	private String title;
	private String content;
	private String isanony;
	private String userid;
	private String date;
	private List<FileVO> fileList;
	private int rownum;
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getIsanony() {
		return isanony;
	}
	public void setIsanony(String isanony) {
		this.isanony = isanony;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public List<FileVO> getFileList() {
		return fileList;
	}
	public void setFileList(List<FileVO> fileList) {
		this.fileList = fileList;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	
	@Override
	public String toString() {
		return String.format(
				"BoardVO [bno=%s, title=%s, content=%s, isanony=%s, userid=%s, date=%s, fileList=%s, rownum=%s]", bno,
				title, content, isanony, userid, date, fileList, rownum);
	}
	
}
