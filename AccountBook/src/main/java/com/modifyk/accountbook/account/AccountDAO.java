package com.modifyk.accountbook.account;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.modifyk.accountbook.asset.AssetVO;

@Component
public class AccountDAO {

	@Autowired
	SqlSessionTemplate my;
	
	// 수입/지출 추가
	public int insertAccount(AccountVO accountVO) {
		return my.insert("accountMapper.insertAccount", accountVO);
	}
	
	// 수입/지출 내역
	public List<AccountVO> selectAccount(AccountVO accountVO) {
		return my.selectList("accountMapper.selectAccount", accountVO);
	}
	
	// 수입/지출 수정
	public int updateAccount(AccountVO accountVO) {
		return my.update("accountMapper.updateAccount", accountVO);
	}
	
	// 수입/지출 삭제
	public int deleteAccount(AccountVO accountVO) {
		return my.delete("accountMapper.deleteAccount", accountVO);
	}
	
	// 업데이트 전 수입/지출
	public AccountVO beforeAccount(AccountVO accountVO) {
		return my.selectOne("accountMapper.beforeAccount", accountVO);
	}
	
	// 수입/지출 검색
	public List<AccountVO> searchAccount(AccountVO accountVO) {
		return my.selectList("accountMapper.searchAccount", accountVO);
	}
		
	// 수입/지출 검색 자동완성
	public List<String> autoComplete(AccountVO accountVO) {
		return my.selectList("accountMapper.autoComplete", accountVO);
	}

	// 날짜별 합계
	public List<AccountVO> groupByDate(AccountVO accountVO) {
		return my.selectList("accountMapper.groupByDate", accountVO);
	}
	
	// 특정 날짜의 수입/지출 내역
	public List<AccountVO> detailsOfDate(AccountVO accountVO) {
		return my.selectList("accountMapper.detailsOfDate", accountVO);
	}
	
	// 대분류별 합계
	public List<AccountVO> groupByBigcate(AccountVO accountVO) {
		return my.selectList("accountMapper.groupByBigcate", accountVO);
	}
	
	// 특정 대분류의 수입/지출 내역
	public List<AccountVO> detailsOfBigcate(AccountVO accountVO) {
		return my.selectList("accountMapper.detailsOfBigcate", accountVO);
	}
	
	// 소분류별 합계
	public List<AccountVO> groupBySmallcate(AccountVO accountVO) {
		return my.selectList("accountMapper.groupBySmallcate", accountVO);
	}

	// 특정 소분류의 수입/지출 내역
	public List<AccountVO> detailsOfSmallcate(AccountVO accountVO) {
		return my.selectList("accountMapper.detailsOfSmallcate", accountVO);
	}
	
	// 자산별 합계
	public List<AccountVO> groupByAsset(AccountVO accountVO) {
		return my.selectList("accountMapper.groupByAsset", accountVO);
	}
	
	// 특정 자산의 수입/지출 내역
	public List<AccountVO> detailsOfAsset(AccountVO accountVO) {
		return my.selectList("accountMapper.detailsOfAsset", accountVO);
	}
	
	// 이체 수정
	public int updateTransfer(AccountVO accountVO) {
		return my.update("accountMapper.updateTransfer", accountVO);
	}
	
	// 이번 달 수입/지출 합계
	public List<AccountVO> monthAccount(AccountVO accountVO) {
		return my.selectList("accountMapper.monthAccount", accountVO);
	}
	
	// 최근 수입/지출 합계
	public List<AccountVO> recentAccount(AccountVO accountVO) {
		return my.selectList("accountMapper.recentAccount", accountVO);
	}
}
