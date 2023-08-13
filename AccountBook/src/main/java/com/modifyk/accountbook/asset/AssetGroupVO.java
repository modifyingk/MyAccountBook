package com.modifyk.accountbook.asset;

public class AssetGroupVO {
	private String astgroup;
	private String userid;
	
	public String getAstgroup() {
		return astgroup;
	}
	public void setAstgroup(String astgroup) {
		this.astgroup = astgroup;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	@Override
	public String toString() {
		return "AssetGroupVO [astgroup=" + astgroup + ", userid=" + userid + "]";
	}
	
}
