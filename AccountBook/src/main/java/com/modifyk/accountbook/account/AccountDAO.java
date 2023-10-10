package com.modifyk.accountbook.account;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AccountDAO {

	@Autowired
	SqlSessionTemplate my;
	
	// 수입/지출 추가
	public int insertAccount(AccountVO accountVO) {
		return my.insert("accountMapper.insertAccount", accountVO);
	}
	
	// 수입/지출 수정
	public int updateAccount(AccountVO accountVO) {
		return my.update("accountMapper.updateAccount", accountVO);
	}
	
	// 수입/지출 삭제
	public int deleteAccount(AccountVO accountVO) {
		return my.delete("accountMapper.deleteAccount", accountVO);
	}
	
	// 즐겨찾기에 추가 가능한 내역 중복 없이 가져오기
	public List<AccountVO> canBookmarkInfo(String userid) {
		return my.selectList("accountMapper.canBookmarkInfo", userid);
	}
	
	// 즐겨찾기 추가
	public int insertBookmark(BookmarkVO bookmarkVO) {
		return my.insert("bookmarkMapper.insertBookmark", bookmarkVO);
	}
	
	// 즐겨찾기 목록
	public List<BookmarkVO> bookmarkInfo(String userid) {
		return my.selectList("bookmarkMapper.bookmarkInfo", userid);
	}
	
	// 즐겨찾기 삭제
	public int deleteBookmark(BookmarkVO bookmarkVO) {
		return my.delete("bookmarkMapper.deleteBookmark", bookmarkVO);
	}
	
	// 월별 수입/지출 내역
	public List<AccountVO> monthAccount(AccountVO accountVO) {
		return my.selectList("accountMapper.monthAccount", accountVO);
	}
	
	// 월별 수입 내역
	public List<AccountVO> monthIncome(AccountVO accountVO) {
		return my.selectList("accountMapper.monthIncome", accountVO);
	}
	
	// 월별 지출 내역
	public List<AccountVO> monthSpend(AccountVO accountVO) {
		return my.selectList("accountMapper.monthSpend", accountVO);
	}
	
	// 해당 월의 카테고리별 수입/지출 내역
	public List<AccountVO> monthCateList(AccountVO accountVO) {
		return my.selectList("accountMapper.monthCateList", accountVO);
	}
	
	// 달력에 표시할 날짜별 합계 
	public List<AccountVO> calendarTotal(AccountVO accountVO) {
		return my.selectList("accountMapper.calendarTotal", accountVO);
	}
	
	// 해당 날짜의 내역
	public List<AccountVO> dateAccount(AccountVO accountVO) {
		return my.selectList("accountMapper.dateAccount", accountVO);
	}
	
	// accountid 값으로 검색
	public AccountVO accountidInfo(AccountVO accountVO) {
		return my.selectOne("accountMapper.accountidInfo", accountVO);
	}
	
	// 월별 수입/지출 합계
	public List<AccountVO> monthTotal(AccountVO accountVO) {
		return my.selectList("accountMapper.monthTotal", accountVO);
	}
	
	// 수입/지출 검색
	public List<AccountVO> searchAccount(AccountVO accountVO) {
		return my.selectList("accountMapper.searchAccount", accountVO);
	}
	
	// 수입/지출 검색 자동완성
	public List<String> autoSearch(AccountVO accountVO) {
		return my.selectList("accountMapper.autoSearch", accountVO);
	}
	
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
	
	/* // 월별 카테고리별 수입/지출 내역
	public List<AccountVO> cateAccount(AccountVO accountVO) {
		return my.selectList("accountMapper.cateAccount", accountVO);
	} */
}
