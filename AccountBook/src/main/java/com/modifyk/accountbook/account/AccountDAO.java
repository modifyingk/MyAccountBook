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
	
	// 수입/지출 검색
	public List<AccountVO> searchAccount(AccountVO accountVO) {
		return my.selectList("accountMapper.searchAccount", accountVO);
	}
		
	// 수입/지출 검색 자동완성
	public List<String> autoComplete(AccountVO accountVO) {
		return my.selectList("accountMapper.autoComplete", accountVO);
	}

	// 날짜별 합계
	public List<AccountVO> sumGroupByDate(AccountVO accountVO) {
		return my.selectList("accountMapper.sumGroupByDate", accountVO);
	}
	
	/*
	// account의 반복 id 업데이트
	public int updateRepeatid(HashMap<String, Object> map) {
		return my.update("accountMapper.updateRepeatid", map);
	}
	
	// 수입/지출 금액 확인
	public AccountVO checkAccount(AccountVO accountVO) {
		return my.selectOne("accountMapper.checkAccount", accountVO);
	}
		
	// 수입/지출 수정
	public int updateAccount(AccountVO accountVO) {
		return my.update("accountMapper.updateAccount", accountVO);
	}
	
	// 수입/지출 삭제
	public int deleteAccount(AccountVO accountVO) {
		return my.delete("accountMapper.deleteAccount", accountVO);
	}
	/*
	// 즐겨찾기에 추가 가능한 내역 중복 없이 가져오기
	public List<AccountVO> selectBookmark(String userid) {
		return my.selectList("accountMapper.selectBookmark", userid);
	}
	
	// 즐겨찾기 추가
	public int insertBookmark(BookmarkVO bookmarkVO) {
		return my.insert("bookmarkMapper.insertBookmark", bookmarkVO);
	}
	
	// 즐겨찾기 목록
	public List<BookmarkVO> bookmarkList(String userid) {
		return my.selectList("bookmarkMapper.bookmarkList", userid);
	}
	
	// 즐겨찾기 삭제
	public int deleteBookmark(BookmarkVO bookmarkVO) {
		return my.delete("bookmarkMapper.deleteBookmark", bookmarkVO);
	}
	*/
	/*
	// 수입/지출 내역
	public List<AccountVO> accountList(AccountVO accountVO) {
		return my.selectList("accountMapper.accountList", accountVO);
	}
	
	// 수입 내역
	public List<AccountVO> incomeList(AccountVO accountVO) {
		return my.selectList("accountMapper.incomeList", accountVO);
	}
	
	// 지출 내역
	public List<AccountVO> spendList(AccountVO accountVO) {
		return my.selectList("accountMapper.spendList", accountVO);
	}
	
	// 자산별 내역
	public List<AccountVO> detailsOfAsset(AccountVO accountVO) {
		return my.selectList("accountMapper.detailsOfAsset", accountVO);
	}
		
	//  카테고리별 내역
	public List<AccountVO> detailsOfCategory(AccountVO accountVO) {
		return my.selectList("accountMapper.detailsOfCategory", accountVO);
	}
	
	// 달력에 표시할 날짜별 합계 
	public List<AccountVO> calendarTotal(AccountVO accountVO) {
		return my.selectList("accountMapper.calendarTotal", accountVO);
	}
	
	// 해당 날짜의 내역
	public List<AccountVO> dateAccount(AccountVO accountVO) {
		return my.selectList("accountMapper.dateAccount", accountVO);
	}
	
	// 해당 연도의 월별 수입/지출 합계
	public List<AccountVO> detailsOfYear(AccountVO accountVO) {
		return my.selectList("accountMapper.detailsOfYear", accountVO);
	}
	/*
	/* // 월별 카테고리별 수입/지출 내역
	public List<AccountVO> cateAccount(AccountVO accountVO) {
		return my.selectList("accountMapper.cateAccount", accountVO);
	} */
}
