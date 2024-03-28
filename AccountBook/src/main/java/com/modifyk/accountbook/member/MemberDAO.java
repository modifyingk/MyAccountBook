package com.modifyk.accountbook.member;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MemberDAO {
	@Autowired
	SqlSessionTemplate my;
	
	// 아이디 중복 확인
	public String overlapId(String userid) {
		return my.selectOne("memberMapper.overlapId", userid);
	}
	
	// 회원가입
	public int insertMember(MemberVO memberVO) {
		return my.insert("memberMapper.insertMember", memberVO);
	}
	
	// 로그인 / 비밀번호 확인
	public String login(MemberVO memberVO) {
		return my.selectOne("memberMapper.login", memberVO);
	}
	
	// 아이디 찾기
	public List<MemberVO> findId(MemberVO memberVO) {
		return my.selectList("memberMapper.findId", memberVO);
	}
	
	// 비밀번호 찾기
	public String findPw(MemberVO memberVO) {
		return my.selectOne("memberMapper.findPw", memberVO);
	}
	
	// 비밀번호 변경
	public int updatePw(MemberVO memberVO) {
		return my.update("memberMapper.updatePw", memberVO);
	}
	
	// 회원정보
	public MemberVO userInfo(String userid) {
		MemberVO info = my.selectOne("memberMapper.userInfo", userid);
		return info;
	}
	
	// 회원정보 수정
	public int updateMember(MemberVO memberVO) {
		return my.update("memberMapper.updateMember", memberVO);
	}
	
	// 회원 탈퇴
	public int deleteMember(String userid) {
		return my.delete("memberMapper.deleteMember", userid);
	}	
}