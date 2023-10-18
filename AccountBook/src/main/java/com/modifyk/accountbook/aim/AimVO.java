package com.modifyk.accountbook.aim;

public class AimVO {
	private int aimid;
	private String aimdate;
	private String moneytype;
	private String catename;
	private String total;
	private String userid;
	private char achieveaim;
	
	public int getAimid() {
		return aimid;
	}
	public void setAimid(int aimid) {
		this.aimid = aimid;
	}
	public String getAimdate() {
		return aimdate;
	}
	public void setAimdate(String aimdate) {
		this.aimdate = aimdate;
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
	public char isAchieveaim() {
		return achieveaim;
	}
	public void setAchieveaim(char achieveaim) {
		this.achieveaim = achieveaim;
	}
	
	@Override
	public String toString() {
		return String.format(
				"AimVO [aimid=%s, aimdate=%s, moneytype=%s, catename=%s, total=%s, userid=%s, achieveaim=%s]", aimid,
				aimdate, moneytype, catename, total, userid, achieveaim);
	}
	
}
