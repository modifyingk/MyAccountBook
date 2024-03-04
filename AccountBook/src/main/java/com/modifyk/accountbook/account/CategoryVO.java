package com.modifyk.accountbook.account;

public class CategoryVO {
	private int categoryid;
	private String bigcate;
	private String smallcate;
	private String userid;
	
	public int getCategoryid() {
		return categoryid;
	}
	public void setCategoryid(int categoryid) {
		this.categoryid = categoryid;
	}
	public String getBigcate() {
		return bigcate;
	}
	public void setBigcate(String bigcate) {
		this.bigcate = bigcate;
	}
	public String getSmallcate() {
		return smallcate;
	}
	public void setSmallcate(String smallcate) {
		this.smallcate = smallcate;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	@Override
	public String toString() {
		return String.format("CategoryVO [categoryid=%s, bigcate=%s, smallcate=%s, userid=%s]", categoryid, bigcate,
				smallcate, userid);
	}
	
}
