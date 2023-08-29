package com.modifyk.accountbook.aim;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AimDAO {
	
	@Autowired
	SqlSessionTemplate my;
	
	// 목표 추가
	public int insertAim(AimVO aimVO) {
		return my.insert("aimMapper.insertAim", aimVO);
	}
	
	// 목표 가져오기
	public List<AimJoinVO> aimInfo(AimVO aimVO) {
		return my.selectList("aimMapper.aimInfo", aimVO);
	}
}
