package com.modifyk.accountbook.transfer;

public class TransferVO {
	private String transferid;
	private String date;
	private String withdraw;
	private String deposit;
	private int total;
	private String memo;
	private String userid;
	
	public String getTransferid() {
		return transferid;
	}
	public void setTransferid(String transferid) {
		this.transferid = transferid;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getWithdraw() {
		return withdraw;
	}
	public void setWithdraw(String withdraw) {
		this.withdraw = withdraw;
	}
	public String getDeposit() {
		return deposit;
	}
	public void setDeposit(String deposit) {
		this.deposit = deposit;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
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
		return String.format(
				"TransferVO [transferid=%s, date=%s, withdraw=%s, deposit=%s, total=%s, memo=%s, userid=%s]",
				transferid, date, withdraw, deposit, total, memo, userid);
	}
}
