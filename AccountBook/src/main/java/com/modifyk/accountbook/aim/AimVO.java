package com.modifyk.accountbook.aim;

public class AimVO {
	private int aimid;
	private String bigcate;
	private String total;
	private String userid;
	private String date;
	
	public int getAimid() {
		return aimid;
	}
	public void setAimid(int aimid) {
		this.aimid = aimid;
	}
	public String getBigcate() {
		return bigcate;
	}
	public void setBigcate(String bigcate) {
		this.bigcate = bigcate;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
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
	
	@Override
	public String toString() {
		return String.format("AimVO [aimid=%s, bigcate=%s, total=%s, userid=%s, date=%s]", aimid, bigcate, total,
				userid, date);
	}
}
