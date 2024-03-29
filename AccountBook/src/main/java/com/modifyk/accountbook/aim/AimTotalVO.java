package com.modifyk.accountbook.aim;

public class AimTotalVO {
	public String date;
	public String moneytype;
	public int total;
	public String userid;
	
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
		return String.format("AimTotalVO [date=%s, moneytype=%s, total=%s, userid=%s]", date, moneytype, total, userid);
	}
}
