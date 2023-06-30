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
}