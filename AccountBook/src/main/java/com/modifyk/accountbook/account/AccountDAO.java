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
	
	// 수입/지출 목록
	public List<AccountVO> accountInfo(String userid) {
		return my.selectList("accountMapper.accountInfo", userid);
	}
	
	// 수입/지출 수정
	public int updateAccount(AccountVO accountVO) {
		return my.update("accountMapper.updateAccount", accountVO);
	}
	
	// 수입/지출 삭제
	public int deleteAccount(AccountVO accountVO) {
		return my.delete("accountMapper.deleteAccount", accountVO);
	}
	
	// 즐겨찾는 지출 내역 중복 없이 가져오기
	public List<AccountVO> addBookmarkInfo(String userid) {
		return my.selectList("accountMapper.addBookmarkInfo", userid);
	}
	
	// 즐겨찾기 추가
	public int insertBookmark(BookmarkVO bookmarkVO) {
		return my.insert("bookmarkMapper.insertBookmark", bookmarkVO);
	}
	
	// 즐겨찾기 추가
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
	
	// 월별 지출 내역
	public List<AccountVO> monthSpend(AccountVO accountVO) {
		return my.selectList("accountMapper.monthSpend", accountVO);
	}
}
