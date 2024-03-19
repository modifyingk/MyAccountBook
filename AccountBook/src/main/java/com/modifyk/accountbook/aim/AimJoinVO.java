package com.modifyk.accountbook.aim;

public class AimJoinVO {
	private int aimid;
	private String bigcate;
	private int aim;
	private int spend;
	private String userid;
	
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
	public int getAim() {
		return aim;
	}
	public void setAim(int aim) {
		this.aim = aim;
	}
	public int getSpend() {
		return spend;
	}
	public void setSpend(int spend) {
		this.spend = spend;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	@Override
	public String toString() {
		return String.format("AimJoinVO [aimid=%s, bigcate=%s, aim=%s, spend=%s, userid=%s]", aimid, bigcate, aim,
				spend, userid);
	}
	
}
