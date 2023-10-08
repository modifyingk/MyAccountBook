package com.modifyk.accountbook.account;

public class RepeatVO {
	private int repeatid;
	private String repeatcycle;
	private String moneytype;
	private String astname;
	private String catename;
	private int total;
	private String content;
	private String userid;
	
	public int getRepeatid() {
		return repeatid;
	}
	public void setRepeatid(int repeatid) {
		this.repeatid = repeatid;
	}
	public String getRepeatcycle() {
		return repeatcycle;
	}
	public void setRepeatcycle(String repeatcycle) {
		this.repeatcycle = repeatcycle;
	}
	public String getMoneytype() {
		return moneytype;
	}
	public void setMoneytype(String moneytype) {
		this.moneytype = moneytype;
	}
	public String getAstname() {
		return astname;
	}
	public void setAstname(String astname) {
		this.astname = astname;
	}
	public String getCatename() {
		return catename;
	}
	public void setCatename(String catename) {
		this.catename = catename;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	
	@Override
	public String toString() {
		return String.format(
				"RepeatVO [repeatid=%s, repeatcycle=%s, moneytype=%s, astname=%s, catename=%s, total=%s, content=%s, userid=%s]",
				repeatid, repeatcycle, moneytype, astname, catename, total, content, userid);
	}
}
