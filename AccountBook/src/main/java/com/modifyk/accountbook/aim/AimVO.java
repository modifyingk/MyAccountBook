package com.modifyk.accountbook.aim;

public class AimVO {
	private int aimid;
	private String aimdate;
	private String moneytype;
	private String catename;
	private String total;
	private String memo;
	private String userid;
	
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
		StringBuilder builder = new StringBuilder();
		builder.append("AimVO [aimid=");
		builder.append(aimid);
		builder.append(", aimdate=");
		builder.append(aimdate);
		builder.append(", moneytype=");
		builder.append(moneytype);
		builder.append(", catename=");
		builder.append(catename);
		builder.append(", total=");
		builder.append(total);
		builder.append(", memo=");
		builder.append(memo);
		builder.append(", userid=");
		builder.append(userid);
		builder.append("]");
		return builder.toString();
	}
}
