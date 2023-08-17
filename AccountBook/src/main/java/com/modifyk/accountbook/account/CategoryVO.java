package com.modifyk.accountbook.account;

public class CategoryVO {
	private String moneytype;
	private String catename;
	private String userid;
	
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
		return "CategoryVO [moneytype=" + moneytype + ", catename=" + catename + ", userid=" + userid + "]";
	}
	
}
