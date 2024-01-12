package com.modifyk.accountbook.party;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PartyDAO {
	
	@Autowired
	SqlSessionTemplate my;
	
	// 그룹 생성
	public int insertParty(PartyVO partyVO) {
		return my.insert("partyMapper.insertParty", partyVO);
	}
	
	// 그룹 목록
	public List<PartyVO> selectParty() {
		return my.selectList("partyMapper.selectParty");
	}
	
	// 그룹명 중복확인
	public String isOverlapParty(String partyname) {
		return my.selectOne("partyMapper.isOverlapParty", partyname);
	}
	
	// 그룹 정보
	public PartyVO partyInfo(String partyname) {
		return my.selectOne("partyMapper.partyInfo", partyname);
	}
	
	// 그룹 검색
	public List<PartyVO> searchParty(String partyname) {
		return my.selectList("partyMapper.searchParty", partyname);
	}
}
