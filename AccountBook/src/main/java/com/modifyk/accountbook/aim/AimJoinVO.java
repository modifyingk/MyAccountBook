package com.modifyk.accountbook.aim;

public class AimJoinVO {
	private int aimid;
	private String moneytype;
	private String catename;
	private int aim_money;
	private int total;
	private String userid;
	
	public int getAimid() {
		return aimid;
	}
	public void setAimid(int aimid) {
		this.aimid = aimid;
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
	public int getAim_money() {
		return aim_money;
	}
	public void setAim_money(int aim_money) {
		this.aim_money = aim_money;
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
		return String.format("AimJoinVO [aimid=%s, moneytype=%s, catename=%s, aim_money=%s, total=%s, userid=%s]",
				aimid, moneytype, catename, aim_money, total, userid);
	}
	
}
