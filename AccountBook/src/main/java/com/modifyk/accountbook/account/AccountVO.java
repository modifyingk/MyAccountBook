package com.modifyk.accountbook.account;

public class AccountVO {
	private int accountid;
	private String moneytype;
	private String date;
	private String assetname;
	private String catename;
	private String content;
	private int total;
	private String memo;
	private String userid;
	private int assetid;
	private int repeatid;
	
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
	public int getAssetid() {
		return assetid;
	}
	public void setAssetid(int assetid) {
		this.assetid = assetid;
	}
	public int getRepeatid() {
		return repeatid;
	}
	public void setRepeatid(int repeatid) {
		this.repeatid = repeatid;
	}
	
	@Override
	public String toString() {
		return String.format(
				"AccountVO [accountid=%s, moneytype=%s, date=%s, assetname=%s, catename=%s, content=%s, total=%s, memo=%s, userid=%s, assetid=%s, repeatid=%s]",
				accountid, moneytype, date, assetname, catename, content, total, memo, userid, assetid, repeatid);
	}
}
