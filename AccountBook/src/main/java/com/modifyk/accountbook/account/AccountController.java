package com.modifyk.accountbook.account;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modifyk.accountbook.asset.AssetDAO;
import com.modifyk.accountbook.asset.AssetVO;

@Controller
public class AccountController {
	
	@Autowired
	AccountDAO aDao;
	
	@Autowired
	CategoryDAO cDao;
	
	@Autowired
	AssetDAO astDao;
	
	@Autowired
	AccountToMapService toMapSvc;
	
	@Autowired
	StatsMapService stMapSvc;
	
	@Autowired
	RepeatToMapService repMapSvc;
	
	// 수입/지출 추가
	@ResponseBody
	@RequestMapping("account/insertAccount")
	public String insertAccount(AccountVO accountVO) {
        
		int result = aDao.insertAccount(accountVO);
		if(result == 1) {
			// 수입/지출이 추가되었을 경우, 자산 금액 업데이트
			AssetVO assetVO = new AssetVO();
			assetVO.setAstname(accountVO.getAstname());
			assetVO.setTotal(accountVO.getTotal());
			assetVO.setUserid(accountVO.getUserid());
			
			if(accountVO.getMoneytype().equals("지출")) {
				astDao.minusTotal(assetVO);
			} else if(accountVO.getMoneytype().equals("수입")) {
				astDao.plusTotal(assetVO);
			}

			return "success";
		} else {
			return "fail";
		}
	}
	
	// 수입/지출 수정
	@ResponseBody
	@RequestMapping("account/updateAccount")
	public String updateAccount(AccountVO accountVO) {
		// 해당 accountid의 값들 조회하기
		AccountVO idResult = aDao.accountidInfo(accountVO);
		
		// 수정
		int result = aDao.updateAccount(accountVO);
		if(result == 1) {
			// 수입/지출이 수정되었을 경우, 자산 금액 업데이트
			int beforeMoney = idResult.getTotal(); // 수정하기 전 금액
			int afterMoney = accountVO.getTotal(); // 수정한 후 금액
			
			int updateValue = afterMoney - beforeMoney;
			
			AssetVO assetVO = new AssetVO();
			assetVO.setAstname(idResult.getAstname());
			assetVO.setTotal(updateValue);
			assetVO.setUserid(idResult.getUserid());
					
			if(idResult.getMoneytype().equals("지출")) {
				astDao.minusTotal(assetVO);
			} else if(idResult.getMoneytype().equals("수입")) {
				astDao.plusTotal(assetVO);
			}
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 수입/지출 삭제
	@ResponseBody
	@RequestMapping("account/deleteAccount")
	public String deleteAccount(AccountVO accountVO) {
		// 해당 accountid의 값들 조회하기
		AccountVO idResult = aDao.accountidInfo(accountVO);

		// 삭제
		int result = aDao.deleteAccount(accountVO);
		if(result == 1) {
			// 수입/지출이 삭제되었을 경우, 자산 금액 업데이트
			AssetVO assetVO = new AssetVO();
			assetVO.setAstname(idResult.getAstname());
			assetVO.setTotal(idResult.getTotal());
			assetVO.setUserid(idResult.getUserid());
			
			if(idResult.getMoneytype().equals("지출")) {
				astDao.plusTotal(assetVO);
			} else if(idResult.getMoneytype().equals("수입")) {
				astDao.minusTotal(assetVO);
			}
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 즐겨찾기에 추가 가능한 내역 중복 없이 가져오기
	@ResponseBody
	@RequestMapping("account/canBookmarkInfo")
	public List<AccountVO> canBookmarkInfo(String userid) {
		List<AccountVO> addmarkList = aDao.canBookmarkInfo(userid);
		return addmarkList;
	}
	
	// 즐겨찾기에 추가
	@ResponseBody
	@RequestMapping("account/insertBookmark")
	public String insertBookmark(BookmarkVO bookmarkVO) {
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
	
	// 즐겨찾기의 카테고리가 존재하는지 확인
	@ResponseBody
	@RequestMapping("account/isPossibleCate")
	public String isPossibleCate(CategoryVO categoryVO) {
		// 카테고리 목록 가져오기 (숨김 아닌 것들만)
		List<CategoryVO> cateList = cDao.CategoryInfo(categoryVO);
		String result = "impossible";
		for(int i = 0; i < cateList.size(); i++) {
			// 북마크의 카테고리명이 카테고리에 존재하는지 확인
			if(cateList.get(i).getCatename().equals(categoryVO.getCatename())) {
				result = "possible";
			}
		}
		return result;
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
	
	// 수입 목록
	@ResponseBody
	@RequestMapping("account/monthIncome")
	public HashMap<String, Object> monthIncome(AccountVO accountVO) {
		List<AccountVO> incomeList = aDao.monthIncome(accountVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(incomeList.size() < 1) {
			map.put("no", "no");
		} else {
			map = toMapSvc.toMap(incomeList);
		}
		return map;
	}
	
	// 지출 목록
	@ResponseBody
	@RequestMapping("account/monthSpend")
	public HashMap<String, Object> monthSpend(AccountVO accountVO) {
		List<AccountVO> spendList = aDao.monthSpend(accountVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(spendList.size() < 1) {
			map.put("no", "no");
		} else {
			map = toMapSvc.toMap(spendList);
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
	
	// 카테고리별 합계
	@ResponseBody
	@RequestMapping("account/cateIncome")
	public HashMap<String, Object> cateIncome(AccountVO accountVO) {
		List<AccountVO> accountList = aDao.monthIncome(accountVO);
		HashMap<String, Object> map = stMapSvc.toMap(accountList);
		return map;
	}
	
	// 해당 월의 카테고리별 수입/지출 내역
	@ResponseBody
	@RequestMapping("account/monthCateList")
	public HashMap<String, Object> monthCateList(AccountVO accountVO) {
		List<AccountVO> catespendList = aDao.monthCateList(accountVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(catespendList.size() < 1) {
			map.put("no", "no");
		} else {
			map = toMapSvc.toMap(catespendList);
		}
		return map;
	}
	
	// 달력에 표시할 날짜별 합계
	@ResponseBody
	@RequestMapping("account/calendarTotal")
	public List<AccountVO> calendarTotal(AccountVO accountVO) {
		List<AccountVO> list = aDao.calendarTotal(accountVO);
		return list;
	}
	
	// 해당 날짜의 내역
	@ResponseBody
	@RequestMapping("account/dateAccount")
	public List<AccountVO> dateAccount(AccountVO accountVO) {
		List<AccountVO> list = aDao.dateAccount(accountVO);
		return list;
	}
	
	// 월별 수입/지출 합계
	@ResponseBody
	@RequestMapping("account/monthTotal")
	public List<AccountVO> monthTotal(AccountVO accountVO) {
		List<AccountVO> list = aDao.monthTotal(accountVO);
		return list;
	}
	
	// 수입/지출 검색
	@ResponseBody
	@RequestMapping("account/searchAccount")
	public HashMap<String, Object> searchAccount(AccountVO accountVO) {
		List<AccountVO> list = aDao.searchAccount(accountVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(list.size() < 1) {
			map.put("no", "no");
		} else {
			map = toMapSvc.toMap(list);
		}
		return map;
	}

	// 수입/지출 검색 단어 자동완성
	@ResponseBody
	@RequestMapping("account/autoSearch")
	public List<String> autoSearch(AccountVO accountVO) {
		List<String> list = aDao.autoSearch(accountVO);
		return list;
	}
	
	// 반복에 추가 가능한 내역 중복 없이 가져오기
	@ResponseBody
	@RequestMapping("account/canRepeatInfo")
	public List<AccountVO> canRepeatInfo(String userid) {
		List<AccountVO> list = aDao.canRepeatInfo(userid);
		return list;
	}
	
	// 반복에 추가
	@ResponseBody
	@RequestMapping("account/insertRepeat")
	public String insertRepeat(RepeatVO repeatVO) {
		int result = aDao.insertRepeat(repeatVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 반복 중복 확인
	@ResponseBody
	@RequestMapping("account/isOverlapRepeat")
	public String isOverlapRepeat(RepeatVO repeatVO) {
		String result = aDao.isOverlapRepeat(repeatVO);
		if(result != null) {
			return "impossible";
		} else {
			return "possible";
		}
	}
	
	// 반복 내역 가져오기
	@ResponseBody
	@RequestMapping("account/repeatInfo")
	public HashMap<String, Object> repeatInfo(String userid) {
		List<RepeatVO> repeatList = aDao.repeatInfo(userid);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(repeatList.size() < 1) {
			map.put("no", "no");
		} else {
			map = repMapSvc.toMap(repeatList);
		}
		return map;
	}
	
	// 반복 삭제
	@ResponseBody
	@RequestMapping("account/deleteRepeat")
	public String deleteRepeat(RepeatVO repeatVO) {
		int result = aDao.deleteRepeat(repeatVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
		
	/*// 월별 카테고리별 수입/지출 내역
	@ResponseBody
	@RequestMapping("account/cateAccount")
	public List<AccountVO> cateAccount(AccountVO accountVO) {
		List<AccountVO> list = aDao.cateAccount(accountVO);
		System.out.println(list);
		return list;
	}*/
}
