package com.modifyk.accountbook.account;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class RepeatDAO {
	@Autowired
	SqlSessionTemplate my;
	
	// 반복에 추가 가능한 내역 중복 없이 가져오기
	public List<AccountVO> canRepeatInfo(String userid) {
		return my.selectList("accountMapper.canRepeatInfo", userid);
	}
		
	// 반복 추가
	public int insertRepeat(RepeatVO repeatVO) {
		return my.insert("repeatMapper.insertRepeat", repeatVO);
	}
		
	// 반복 중복 확인
	public String isOverlapRepeat(RepeatVO repeatVO) {
		return my.selectOne("repeatMapper.isOverlapRepeat", repeatVO);
	}
		
	// 반복 내역 가져오기
	public List<RepeatVO> repeatInfo(String userid) {
		return my.selectList("repeatMapper.repeatInfo", userid);
	}
		
	// 반복 삭제
	public int deleteRepeat(RepeatVO repeatVO) {
		return my.delete("repeatMapper.deleteRepeat", repeatVO);
	}
		
	// 반복 수정
	public int updateRepeat(RepeatVO repeatVO) {
		return my.update("repeatMapper.updateRepeat", repeatVO);
	}
	
	// 모든 반복 내역 가져오기
	public List<RepeatVO> repeatAll() {
		return my.selectList("repeatMapper.repeatAll");
	}
}
