package com.modifyk.accountbook.account;

public class CategoryVO {
	private int categoryid;
	private String moneytype;
	private String catename;
	private String userid;
	
	public int getCategoryid() {
		return categoryid;
	}
	public void setCategoryid(int categoryid) {
		this.categoryid = categoryid;
	}
	public String getMoneytype() {
		return moneytype;
	}
	public void setMoneytype(String moneytype) {
		this.moneytype = moneytype;
	}
	public String getCatename() {
		return catename;
	}
	public void setCatename(String catename) {
		this.catename = catename;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	@Override
	public String toString() {
		return String.format("CategoryVO [categoryid=%s, moneytype=%s, catename=%s, userid=%s]", categoryid, moneytype,
				catename, userid);
	}
}
