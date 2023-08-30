package com.modifyk.accountbook.aim;

public class AimJoinVO {
	private int aimid;
	private String moneytype;
	private String catename;
	private int aim_money;
	private int total;
	
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
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("AimJoinVO [aimid=");
		builder.append(aimid);
		builder.append(", moneytype=");
		builder.append(moneytype);
		builder.append(", catename=");
		builder.append(catename);
		builder.append(", aim_money=");
		builder.append(aim_money);
		builder.append(", total=");
		builder.append(total);
		builder.append("]");
		return builder.toString();
	}
	
}
