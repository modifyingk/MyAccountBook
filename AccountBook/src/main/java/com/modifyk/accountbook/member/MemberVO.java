package com.modifyk.accountbook.member;

public class MemberVO {
	private String userid;
	private String pw;
	private String username;
	private String gender;
	private String birth;
	private String email;
	private String joindate;
	
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
	
	@Override
	public String toString() {
		return "MemberVO [userid=" + userid + ", pw=" + pw + ", username=" + username + ", gender=" + gender
				+ ", birth=" + birth + ", email=" + email + ", joindate=" + joindate + "]";
	}
}
