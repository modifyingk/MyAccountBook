package com.modifyk.accountbook.aim;

public class AimRateVO {
	private String userid;
	private int achieve_num;
	private int aim_num;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getAchieve_num() {
		return achieve_num;
	}
	public void setAchieve_num(int achieve_num) {
		this.achieve_num = achieve_num;
	}
	public int getAim_num() {
		return aim_num;
	}
	public void setAim_num(int aim_num) {
		this.aim_num = aim_num;
	}
	
	@Override
	public String toString() {
		return String.format("AimRateVO [userid=%s, achieve_num=%s, aim_num=%s]", userid, achieve_num, aim_num);
	}
	
}
