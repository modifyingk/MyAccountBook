package com.modifyk.accountbook.member;

public class MemberVO {
	private String userid;
	private String pw;
	private String username;
	private String gender;
	private String birth;
	private String email;
	private String joindate;
	private String partyname;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getJoindate() {
		return joindate;
	}
	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}
	public String getPartyname() {
		return partyname;
	}
	public void setPartyname(String partyname) {
		this.partyname = partyname;
	}
	
	@Override
	public String toString() {
		return String.format(
				"MemberVO [userid=%s, pw=%s, username=%s, gender=%s, birth=%s, email=%s, joindate=%s, partyname=%s, getUserid()=%s, getPw()=%s, getUsername()=%s, getGender()=%s, getBirth()=%s, getEmail()=%s, getJoindate()=%s, getPartyname()=%s, getClass()=%s, hashCode()=%s, toString()=%s]",
				userid, pw, username, gender, birth, email, joindate, partyname, getUserid(), getPw(), getUsername(),
				getGender(), getBirth(), getEmail(), getJoindate(), getPartyname(), getClass(), hashCode(),
				super.toString());
	}
	
}
