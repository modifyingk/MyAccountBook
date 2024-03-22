package com.modifyk.accountbook.repeat;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class RepeatDAO {
	@Autowired
	SqlSessionTemplate my;
	
	// 반복 중복 확인
	public RepeatVO overlapRepeat(RepeatVO repeatVO) {
		return my.selectOne("repeatMapper.overlapRepeat", repeatVO);
	}
	
	// 반복 추가
	public int insertRepeat(RepeatVO repeatVO) {
		return my.insert("repeatMapper.insertRepeat", repeatVO);
	}
		
	// 반복 내역 가져오기
	public List<RepeatVO> selectRepeat(RepeatVO repeatVO) {
		return my.selectList("repeatMapper.selectRepeat", repeatVO);
	}
		
	// 반복 삭제
	public int deleteRepeat(RepeatVO repeatVO) {
		return my.delete("repeatMapper.deleteRepeat", repeatVO);
	}
	
}
