package com.modifyk.accountbook.account;

public class AccountVO {
	private int accountid;
	private String moneytype;
	private String date;
	private String assetname;
	private String bigcate;
	private String smallcate;
	private String content;
	private int total;
	private String userid;
	
	public int getAccountid() {
		return accountid;
	}
	public void setAccountid(int accountid) {
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
	public String getAssetname() {
		return assetname;
	}
	public void setAssetname(String assetname) {
		this.assetname = assetname;
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
	
	@Override
	public String toString() {
		return String.format(
				"AccountVO [accountid=%s, moneytype=%s, date=%s, assetname=%s, bigcate=%s, smallcate=%s, content=%s, total=%s,userid=%s]",
				accountid, moneytype, date, assetname, bigcate, smallcate, content, total, userid);
	}
	
}
