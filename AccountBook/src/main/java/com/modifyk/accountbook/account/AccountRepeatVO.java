package com.modifyk.accountbook.account;

public class AccountRepeatVO {
	private int repeatid;
	private String repeatcycle;
	private String date;
	private String moneytype;
	private int assetid;
	private String assetname;
	private String catename;
	private String content;
	private int total;
	private String userid;
	
	public int getRepeatid() {
		return repeatid;
	}
	public void setRepeatid(int repeatid) {
		this.repeatid = repeatid;
	}
	public String getRepeatcycle() {
		return repeatcycle;
	}
	public void setRepeatcycle(String repeatcycle) {
		this.repeatcycle = repeatcycle;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getMoneytype() {
		return moneytype;
	}
	public void setMoneytype(String moneytype) {
		this.moneytype = moneytype;
	}
	public int getAssetid() {
		return assetid;
	}
	public void setAssetid(int assetid) {
		this.assetid = assetid;
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
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	@Override
	public String toString() {
		return String.format(
				"AccountRepeatVO [repeatid=%s, repeatcycle=%s, date=%s, moneytype=%s, assetid=%s, assetname=%s, catename=%s, content=%s, total=%s, userid=%s]",
				repeatid, repeatcycle, date, moneytype, assetid, assetname, catename, content, total, userid);
	}
}
