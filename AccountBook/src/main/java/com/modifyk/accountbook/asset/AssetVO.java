package com.modifyk.accountbook.asset;

public class AssetVO {
	private int assetid;
	private String assetgroup;
	private String assetname;
	private int total;
	private String memo;
	private String userid;
	
	public int getAssetid() {
		return assetid;
	}
	public void setAssetid(int assetid) {
		this.assetid = assetid;
	}
	public String getAssetgroup() {
		return assetgroup;
	}
	public void setAssetgroup(String assetgroup) {
		this.assetgroup = assetgroup;
	}
	public String getAssetname() {
		return assetname;
	}
	public void setAssetname(String assetname) {
		this.assetname = assetname;
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
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
	@Override
	public String toString() {
		return String.format(
				"AssetVO [assetid=%s, assetgroup=%s, assetname=%s, total=%s, memo=%s, userid=%s", assetid,
				assetgroup, assetname, total, memo, userid);
	}
}
