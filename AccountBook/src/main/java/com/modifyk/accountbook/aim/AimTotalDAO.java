package com.modifyk.accountbook.aim;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AimTotalDAO {
	
	@Autowired
	SqlSessionTemplate my;
	
	// 총 목표 값 가져오기
	public String selectTotal(AimTotalVO aimtotalVO) {
		return my.selectOne("aimtotalMapper.selectTotal", aimtotalVO);
	}
	
	// 총 목표 값 추가
	public int insertTotal(AimTotalVO aimtotalVO) {
		return my.insert("aimtotalMapper.insertTotal", aimtotalVO);
	}
	
	// 총 목표 값 수정
	public int updateTotal(AimTotalVO aimtotalVO) {
		return my.insert("aimtotalMapper.updateTotal", aimtotalVO);
	}
	
	// 총 지출 목표 값 대비 지출량
	public AimJoinVO spendPerAim(AimTotalVO aimtotalVO) {
		return my.selectOne("aimtotalMapper.spendPerAim", aimtotalVO);
	}
	
	// 분배 가능한 금액
	public String selectBalance(String userid) {
		return my.selectOne("aimtotalMapper.selectBalance", userid);
	}
	
	// 총 수입 목표 값 대비 총 자산
	public AimJoinVO incomePerAim(String userid) {
		return my.selectOne("aimtotalMapper.incomePerAim", userid);
	}
}
