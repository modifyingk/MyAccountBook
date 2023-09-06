package com.modifyk.accountbook.asset;

public class AssetVO {
	private String astname;
	private String astgroup;
	private String astmemo;
	private String userid;
	private String showasset;
	
	public String getAstname() {
		return astname;
	}
	public void setAstname(String astname) {
		this.astname = astname;
	}
	public String getAstgroup() {
		return astgroup;
	}
	public void setAstgroup(String astgroup) {
		this.astgroup = astgroup;
	}
	public String getAstmemo() {
		return astmemo;
	}
	public void setAstmemo(String astmemo) {
		this.astmemo = astmemo;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getShowasset() {
		return showasset;
	}
	public void setShowasset(String showasset) {
		this.showasset = showasset;
	}
	
	@Override
	public String toString() {
		return "AssetVO [astname=" + astname + ", astgroup=" + astgroup + ", astmemo=" + astmemo + ", userid=" + userid
				+ "showassett=" + showasset + "]";
	}
	
}
