package com.modifyk.accountbook.member;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MemberDAO {
	@Autowired
	SqlSessionTemplate my;
	
	// 아이디 중복 확인
	public String isOverlapId(String userid) {
		return my.selectOne("memberMapper.isOverlapId", userid);
	}
	
	// 회원가입
	public int insertMember(MemberVO memberVO) {
		return my.insert("memberMapper.insertMember", memberVO);
	}
	
	// 로그인
	public String login(MemberVO memberVO) {
		return my.selectOne("memberMapper.login", memberVO);
	}
}
