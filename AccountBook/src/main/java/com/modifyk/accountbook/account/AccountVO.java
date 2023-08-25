package com.modifyk.accountbook.account;

public class AccountVO {
	private String accountid;
	private String moneytype;
	private String date;
	private String astname;
	private String catename;
	private String content;
	private int total;
	private String memo;
	private String userid;
	
	public String getAccountid() {
		return accountid;
	}
	public void setAccountid(String accountid) {
		this.accountid = accountid;
	}
	public String getMoneytype() {
		return moneytype;
	}
	public void setMoneytype(String moneytype) {
		this.moneytype = moneytype;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getAstname() {
		return astname;
	}
	public void setAstname(String astname) {
		this.astname = astname;
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
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	@Override
	public String toString() {
		return "AccountVO [accountid=" + accountid + ", moneytype=" + moneytype + ", date=" + date + ", astname="
				+ astname + ", catename=" + catename + ", content=" + content + ", total=" + total + ", memo=" + memo
				+ ", userid=" + userid + "]";
	}
	
}
