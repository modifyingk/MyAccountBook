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
	
	// 목표 수정
	public int updateAim(AimVO aimVO) {
		return my.update("aimMapper.updateAim", aimVO);
	}
	
	// 목표 삭제
	public int deleteAim(AimVO aimVO) {
		return my.delete("aimMapper.deleteAim", aimVO);
	}
	
	// 목표 카테고리 중복 확인
	public String isOverlapAim(AimVO aimVO) {
		return my.selectOne("aimMapper.isOverlapAim", aimVO);
	}
	
	// 유저별 카테고리별 목표, 총 금액
	public List<AimJoinVO> aimAll(AimVO aimVO) {
		return my.selectList("aimMapper.aimAll", aimVO);
	}
}
