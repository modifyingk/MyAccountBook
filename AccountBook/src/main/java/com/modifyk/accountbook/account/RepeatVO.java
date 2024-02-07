package com.modifyk.accountbook.account;

public class RepeatVO {
	private int repeatid;
	private String repeatcycle;
	private String date;
	private int accountid;
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
	public int getAccountid() {
		return accountid;
	}
	public void setAccountid(int accountid) {
		this.accountid = accountid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	@Override
	public String toString() {
		return String.format("RepeatVO [repeatid=%s, repeatcycle=%s, date=%s, accountid=%s, userid=%s]", repeatid,
				repeatcycle, date, accountid, userid);
	}
	
}
