package com.modifyk.accountbook.account;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class RepeatDAO {
	@Autowired
	SqlSessionTemplate my;
	
	// 반복 추가
	public int insertRepeat(RepeatVO repeatVO) {
		return my.insert("repeatMapper.insertRepeat", repeatVO);
	}
		
	// 반복 내역 가져오기
	public List<AccountRepeatVO> repeatList(String userid) {
		return my.selectList("repeatMapper.repeatList", userid);
	}
		
	// 반복 삭제
	public int deleteRepeat(RepeatVO repeatVO) {
		return my.delete("repeatMapper.deleteRepeat", repeatVO);
	}
	
	// 모든 반복 내역 가져오기
	public List<AccountRepeatVO> repeatAll() {
		return my.selectList("repeatMapper.repeatAll");
	}
}
