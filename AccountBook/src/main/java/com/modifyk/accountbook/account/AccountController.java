package com.modifyk.accountbook.account;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modifyk.accountbook.asset.AssetDAO;

@Controller
public class AccountController {
	
	@Autowired
	AccountDAO aDao;
	
	@Autowired
	CategoryDAO cDao;
	
	@Autowired
	AssetDAO astDao;
	
	@Autowired
	RepeatDAO rDao;
	
	@Autowired
	AccountToMapService toMapSvc;
	
	@Autowired
	AssetService assetSvc;
	
	// 수입/지출 추가
	@ResponseBody
	@RequestMapping("account/insertAccount")
	public boolean insertAccount(AccountVO accountVO) {
		System.out.println(accountVO);
		if(accountVO.getMoneytype().equals("지출")) // 지출인 경우 마이너스 붙이기
			accountVO.setTotal(accountVO.getTotal() * -1);
		System.out.println(accountVO);
		int insertRes = aDao.insertAccount(accountVO);
		/*int accountid = accountVO.getAccountid();*/
		/*
		if(!repeatcycle.equals("없음")) {
			// 반복 값 세팅
			RepeatVO repeatVO = new RepeatVO();
			repeatVO.setRepeatcycle(repeatcycle);
			repeatVO.setDate(accountVO.getDate());
			repeatVO.setAccountid(accountid);
			repeatVO.setUserid(accountVO.getUserid());
			rDao.insertRepeat(repeatVO);
			int repeatid = repeatVO.getRepeatid();
			
			// account테이블에 repeatid 업데이트
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("accountid", accountid);
			map.put("repeatid", repeatid);
			map.put("userid", accountVO.getUserid());
			aDao.updateRepeatid(map);
		}
*/
		if(insertRes > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	// 수입/지출 수정
	@ResponseBody
	@RequestMapping("account/updateAccount")
	public boolean updateAccount(AccountVO accountVO) {
		AccountVO before = aDao.checkAccount(accountVO);
		int updateRes = aDao.updateAccount(accountVO); // 수입/지출 수정
		
		if(updateRes > 0) {
			assetSvc.updateAsset(before, accountVO);
			return true;
		} else {
			return false;
		}
	}
	
	// 수입/지출 삭제
	@ResponseBody
	@RequestMapping("account/deleteAccount")
	public boolean deleteAccount(AccountVO accountVO) {
		AccountVO before = aDao.checkAccount(accountVO); // 삭제 전 데이터
		System.out.println(before);
		int deleteRes = aDao.deleteAccount(accountVO); // 수입/지출 삭제

		if(deleteRes > 0) {
			// 수입/지출이 삭제되었을 경우, 자산 금액 업데이트
			accountVO.setAssetid(before.getAssetid());
			accountVO.setMoneytype(before.getMoneytype());
			accountVO.setTotal(before.getTotal() * (-1));
			assetSvc.updateAsset(accountVO);
			return true;
		} else {
			return false;
		}
	}
	
	// 수입/지출 목록
	public List<AccountVO> accountList(AccountVO accountVO, String moneytype) {
		List<AccountVO> accountList = new ArrayList<>();
		if(moneytype.equals("income")) {
			accountList = aDao.incomeList(accountVO);
		} else if(moneytype.equals("spend")) {
			accountList = aDao.spendList(accountVO);
		} else {
			accountList = aDao.accountList(accountVO);
		}
		return accountList;
	}
	
	// 수입/지출 목록 날짜별로 그룹화
	@ResponseBody
	@RequestMapping("account/groupByDate")
	public HashMap<String, List<AccountVO>> groupByDate(AccountVO accountVO, String moneytype) {
		List<AccountVO> list = accountList(accountVO, moneytype);
		HashMap<String, List<AccountVO>> map = toMapSvc.accountToMap(list); // 날짜별로 그룹한 map
		return map;
	}
	
	// 수입/지출 목록 카테고리별 합계
	@ResponseBody
	@RequestMapping("account/groupByCategory")
	public HashMap<String, Object> groupByCategory(AccountVO accountVO, String moneytype) {
		List<AccountVO> list = accountList(accountVO, moneytype);
		HashMap<String, Object> map = toMapSvc.categoryToMap(list); // 카테고리별로 그룹한 map
		return map;
	}

	// 수입/지출 목록 자산별 합계
	@ResponseBody
	@RequestMapping("account/groupByAsset")
	public HashMap<String, Object> groupByAsset(AccountVO accountVO, String moneytype) {
		List<AccountVO> list = accountList(accountVO, moneytype);
		HashMap<String, Object> map = toMapSvc.assetToMap(list); // 카테고리별로 그룹한 map
		return map;
	}
		
	// 카테고리별 내역
	@ResponseBody
	@RequestMapping("account/detailsOfCategory")
	public HashMap<String, List<AccountVO>> detailsOfCategory(AccountVO accountVO) {
		List<AccountVO> list = aDao.detailsOfCategory(accountVO);
		HashMap<String, List<AccountVO>> map = toMapSvc.accountToMap(list);
		return map;
	}
	
	// 자산별 내역
	@ResponseBody
	@RequestMapping("asset/detailsOfAsset")
	public HashMap<String, List<AccountVO>> detailsOfAsset(AccountVO accountVO) {
		List<AccountVO> list = aDao.detailsOfAsset(accountVO);
		HashMap<String, List<AccountVO>> map = toMapSvc.accountToMap(list);
		System.out.println(map);
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
	
	/*
	// 해당 연도의 월별 수입/지출 합계
	@ResponseBody
	@RequestMapping("account/detailsOfYear")
	public List<AccountVO> detailsOfYear(AccountVO accountVO) {
		List<AccountVO> list = aDao.detailsOfYear(accountVO);
		return list;
	}
	
	// 수입/지출 검색
	@ResponseBody
	@RequestMapping("account/searchAccount")
	public HashMap<String, List<AccountVO>> searchAccount(AccountVO accountVO) {
		List<AccountVO> list = aDao.searchAccount(accountVO);
		HashMap<String, List<AccountVO>> map = toMapSvc.accountToMap(list);
		return map;
	}

	// 수입/지출 검색 단어 자동완성
	@ResponseBody
	@RequestMapping("account/autoSearch")
	public List<String> autoSearch(AccountVO accountVO) {
		List<String> list = aDao.autoSearch(accountVO);
		return list;
	}*/

	// 반복 내역 가져오기
	@ResponseBody
	@RequestMapping("account/repeatList")
	public List<AccountRepeatVO> repeatList(String userid) {
		List<AccountRepeatVO> repeatList = rDao.repeatList(userid);
		return repeatList;
	}
	
	// 반복 삭제
	@ResponseBody
	@RequestMapping("account/deleteRepeat")
	public int deleteRepeat(RepeatVO repeatVO) {
		int result = rDao.deleteRepeat(repeatVO);
		return result;
	}
	/*
	// 반복 수정
	@ResponseBody
	@RequestMapping("account/updateRepeat")
	public String updateRepeat(RepeatVO repeatVO) {
		int result = rDao.updateRepeat(repeatVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	*/
	/*// 월별 카테고리별 수입/지출 내역
	@ResponseBody
	@RequestMapping("account/cateAccount")
	public List<AccountVO> cateAccount(AccountVO accountVO) {
		List<AccountVO> list = aDao.cateAccount(accountVO);
		System.out.println(list);
		return list;
	}*/
}
