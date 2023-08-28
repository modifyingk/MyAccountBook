package com.modifyk.accountbook.account;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AccountController {
	
	@Autowired
	AccountDAO aDao;
	
	@Autowired
	MakeAccountIDService actIDSvc;
	
	@Autowired
	AccountToMapService toMapSvc;
	
	@Autowired
	StatsMapService stMapSvc;
	
	// 수입/지출 추가
	@ResponseBody
	@RequestMapping("account/insertAccount")
	public String insertAccount(AccountVO accountVO) {
        
		// 수입/지출 아이디(분류코드) 생성
		String accountid = actIDSvc.makeAccountID(accountVO.getMoneytype());
		accountVO.setAccountid(accountid);
		
		int result = aDao.insertAccount(accountVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 수입/지출 목록
	@ResponseBody
	@RequestMapping("account/accountInfo")
	public HashMap<String, Object> accountInfo(String userid) {
		List<AccountVO> accountList = aDao.accountInfo(userid);
		HashMap<String, Object> map = toMapSvc.toMap(accountList);
		return map;
	}
	
	// 수입/지출 수정
	@ResponseBody
	@RequestMapping("account/updateAccount")
	public String updateAccount(AccountVO accountVO) {
		int result = aDao.updateAccount(accountVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 수입/지출 삭제
	@ResponseBody
	@RequestMapping("account/deleteAccount")
	public String deleteAccount(AccountVO accountVO) {
		int result = aDao.deleteAccount(accountVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 즐겨찾는 지출 내역 중복 없이 가져오기
	@ResponseBody
	@RequestMapping("account/addBookmarkInfo")
	public List<AccountVO> addBookmarkInfo(String userid) {
		List<AccountVO> addmarkList = aDao.addBookmarkInfo(userid);
		return addmarkList;
	}
	
	// 즐겨찾기에 추가
	@ResponseBody
	@RequestMapping("account/insertBookmark")
	public String addBookmark(BookmarkVO bookmarkVO) {
		int result = aDao.insertBookmark(bookmarkVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 즐겨찾기 목록
	@ResponseBody
	@RequestMapping("account/bookmarkInfo")
	public List<BookmarkVO> bookmarkInfo(String userid) {
		List<BookmarkVO> bookmarkList = aDao.bookmarkInfo(userid);
		return bookmarkList;
	}
	
	// 즐겨찾기 삭제
	@ResponseBody
	@RequestMapping("account/deleteBookmark")
	public String deleteBookmark(BookmarkVO bookmarkVO) {
		int result = aDao.deleteBookmark(bookmarkVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 수입/지출 목록
	@ResponseBody
	@RequestMapping("account/monthAccount")
	public HashMap<String, Object> monthAccount(AccountVO accountVO) {
		List<AccountVO> accountList = aDao.monthAccount(accountVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(accountList.size() < 1) {
			map.put("no", "no");
		} else {
			map = toMapSvc.toMap(accountList);
		}
		return map;
	}
	
	// 카테고리별 합계
	@ResponseBody
	@RequestMapping("account/cateSpend")
	public HashMap<String, Object> cateSpend(AccountVO accountVO) {
		List<AccountVO> accountList = aDao.monthSpend(accountVO);
		HashMap<String, Object> map = stMapSvc.toMap(accountList);
		return map;
	}
}
