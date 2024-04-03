package com.modifyk.accountbook.account;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AccountController {
	
	@Autowired
	AccountDAO aDao;
	
	@Autowired
	AccountToMapService toMapSvc;
	
	@Autowired
	AssetService assetSvc;
	
	// 수입/지출 추가
	@ResponseBody
	@RequestMapping("account/insertAccount")
	public int insertAccount(AccountVO accountVO) {
		if(accountVO.getMoneytype().equals("지출")) // 지출인 경우 마이너스 붙이기
			accountVO.setTotal(accountVO.getTotal() * -1);
		int insertRes = aDao.insertAccount(accountVO);
		
		if(insertRes > 0) {
			assetSvc.updateAsset(accountVO); // 자산 업데이트
			return accountVO.getAccountid();
		} else {
			return 0;
		}
	}
	
	// 수입/지출 내역
	@RequestMapping("account/selectAccount")
	public void selectAccount(AccountVO accountVO, Model model) {
		List<AccountVO> list = aDao.selectAccount(accountVO);
		LinkedHashMap<String, List<AccountVO>> map = toMapSvc.accountToMap(list); // 날짜별로 그룹한 map
		model.addAttribute("map", map);
	}
	
	// 수입/지출 검색
	@RequestMapping("account/searchAccount")
	public String searchAccount(AccountVO accountVO, Model model) {
		List<AccountVO> list = aDao.searchAccount(accountVO);
		LinkedHashMap<String, List<AccountVO>> map = toMapSvc.accountToMap(list); // 날짜별로 그룹한 map
		model.addAttribute("map", map);
		return "account/selectAccount";
	}

	// 수입/지출 검색 단어 자동완성
	@RequestMapping("account/autoComplete")
	public void autoSearch(AccountVO accountVO, Model model) {
		List<String> list = aDao.autoComplete(accountVO);
		model.addAttribute("list", list);
	}
	
	// 수입/지출 수정
	@ResponseBody
	@RequestMapping("account/updateAccount")
	public boolean updateAccount(AccountVO accountVO) {
		if(accountVO.getMoneytype().equals("지출")) // 지출인 경우 마이너스 붙이기
			accountVO.setTotal(accountVO.getTotal() * -1);
		
		AccountVO before = aDao.beforeAccount(accountVO); // 수정 전 자산 및 금액
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
		AccountVO before = aDao.beforeAccount(accountVO); // 삭제 전 자산 및 금액
		int deleteRes = aDao.deleteAccount(accountVO); // 수입/지출 삭제

		if(deleteRes > 0) {
			accountVO.setAssetname(before.getAssetname());
			accountVO.setTotal(before.getTotal() * -1);
			assetSvc.updateAsset(accountVO);
			return true;
		} else {
			return false;
		}
	}
	
	// 날짜별 합계
	@RequestMapping("account/makeCalendar")
	public String makeCalendar(AccountVO accountVO, String type, Model model) {
		List<AccountVO> list = aDao.groupByDate(accountVO);
		model.addAttribute("list", list);
		model.addAttribute("today", accountVO.getDate());
		if(type.equals("mini")) {
			return "account/miniCalendar";
		} else {
			return "account/makeCalendar";
		}
	}
	
	// 특정 날짜의 수입/지출 내역
	@RequestMapping("account/detailsOfDate")
	public String detailsOfDate(AccountVO accountVO, Model model) {
		List<AccountVO> list = aDao.detailsOfDate(accountVO);
		LinkedHashMap<String, List<AccountVO>> map = toMapSvc.accountToMap(list); // 날짜별로 그룹한 map
		model.addAttribute("map", map);
		return "account/selectAccount";
	}
		
	// 대분류별 합계
	@RequestMapping("account/makeBigcateStats")
	public void groupByBigcate(AccountVO accountVO, Model model) {
		accountVO.setMoneytype("지출");
		List<AccountVO> spendList = aDao.groupByBigcate(accountVO);
		model.addAttribute("spendList", spendList);
		String spendData = toMapSvc.makeBigcateData(spendList);
		model.addAttribute("spendData", spendData);
		
		accountVO.setMoneytype("수입");
		List<AccountVO> incomeList = aDao.groupByBigcate(accountVO);
		model.addAttribute("incomeList", incomeList);
		String incomeData = toMapSvc.makeBigcateData(incomeList);
		model.addAttribute("incomeData", incomeData);
	}
	
	// 특정 대분류의 수입/지출 내역
	@RequestMapping("account/detailsOfBigcate")
	public String detailsOfBigcate(AccountVO accountVO, Model model) {
		List<AccountVO> list = aDao.detailsOfBigcate(accountVO);
		LinkedHashMap<String, List<AccountVO>> map = toMapSvc.accountToMap(list); // 날짜별로 그룹한 map
		model.addAttribute("map", map);
		return "account/selectAccount";
	}
	
	// 소분류별 합계
	@RequestMapping("account/makeSmallcateStats")
	public void groupBySmallcate(AccountVO accountVO, Model model) {
		List<AccountVO> list = aDao.groupBySmallcate(accountVO);
		model.addAttribute("list", list);
		
		String data = toMapSvc.makeSmallcateData(list);
		model.addAttribute("data", data);

		model.addAttribute("moneytype", accountVO.getMoneytype());
		model.addAttribute("bigcate", accountVO.getBigcate());
	}
	
	// 특정 소분류의 수입/지출 내역
	@RequestMapping("account/detailsOfSmallcate")
	public String detailsOfSmallcate(AccountVO accountVO, Model model) {
		List<AccountVO> list = aDao.detailsOfSmallcate(accountVO);
		LinkedHashMap<String, List<AccountVO>> map = toMapSvc.accountToMap(list); // 날짜별로 그룹한 map
		model.addAttribute("map", map);
		return "account/selectAccount";
	}
	
	// 자산별 합계
	@RequestMapping("account/makeAssetStats")
	public void groupByAsset(AccountVO accountVO, Model model) {
		accountVO.setMoneytype("지출");
		List<AccountVO> spendList = aDao.groupByAsset(accountVO);
		model.addAttribute("spendList", spendList);
		String spendData = toMapSvc.makeAssetData(spendList);
		model.addAttribute("spendData", spendData);
		
		accountVO.setMoneytype("수입");
		List<AccountVO> incomeList = aDao.groupByAsset(accountVO);
		model.addAttribute("incomeList", incomeList);
		String incomeData = toMapSvc.makeAssetData(incomeList);
		model.addAttribute("incomeData", incomeData);
	}
	
	// 특정 자산의 수입/지출 내역
	@RequestMapping("account/detailsOfAsset")
	public String detailsOfAsset(AccountVO accountVO, Model model) {
		List<AccountVO> list = aDao.detailsOfAsset(accountVO);
		LinkedHashMap<String, List<AccountVO>> map = toMapSvc.accountToMap(list); // 날짜별로 그룹한 map
		model.addAttribute("map", map);
		return "account/selectAccount";
	}
	
	// 이체 추가
	@ResponseBody
	@RequestMapping("account/insertTransfer")
	public boolean insertTransfer(AccountVO accountVO) {
		int insertRes = aDao.insertAccount2(accountVO);
		String withdraw = accountVO.getAssetname().split("→")[0]; // 출금
		String deposit = accountVO.getAssetname().split("→")[1]; // 입금
		if(insertRes > 0) {
			accountVO.setAssetname(deposit); // 입금 자산
			assetSvc.updateAsset(accountVO);

			accountVO.setAssetname(withdraw); // 출금 자산
			accountVO.setTotal(accountVO.getTotal() * -1);
			assetSvc.updateAsset(accountVO);
				
			return true;
		}
		else
			return false;
	}
	
	// 이체 수정
	@ResponseBody
	@RequestMapping("account/updateTransfer")
	public boolean updateTransfer(AccountVO accountVO) {
		AccountVO before = aDao.beforeAccount(accountVO); // 수정 전 자산 및 금액

		int updateRes = aDao.updateTransfer(accountVO);
		
		String beforeWithdraw = before.getAssetname().split("→")[0]; // 수정 전 출금
		String withdraw = accountVO.getAssetname().split("→")[0]; // 출금

		String beforeDeposit = before.getAssetname().split("→")[1]; // 수정 전 입금
		String deposit = accountVO.getAssetname().split("→")[1]; // 입금
		
		if(updateRes > 0) {
			before.setAssetname(beforeDeposit); // 입금 자산
			accountVO.setAssetname(deposit);
			assetSvc.updateAsset(before, accountVO);
			
			before.setAssetname(beforeWithdraw); // 출금 자산
			before.setTotal(before.getTotal() * -1); // 출금 자산에서는 변경된 금액만큼 빼줘야하므로
			accountVO.setAssetname(withdraw);
			accountVO.setTotal(accountVO.getTotal() * -1);
			assetSvc.updateAsset(before, accountVO);
			
			return true;
		}
		else
			return false;
	}
	
	// 이체 삭제
	@ResponseBody
	@RequestMapping("account/deleteTransfer")
	public boolean deleteTransfer(AccountVO accountVO) {
		AccountVO before = aDao.beforeAccount(accountVO); // 삭제 전 자산 및 금액
		int deleteRes = aDao.deleteAccount(accountVO); // 수입/지출 삭제

		String withdraw = before.getAssetname().split("→")[0]; // 출금
		String deposit = before.getAssetname().split("→")[1]; // 입금

		if(deleteRes > 0) {
			accountVO.setAssetname(withdraw); // 출금 내역은 자산에 다시 더해줘야함
			accountVO.setTotal(before.getTotal());
			assetSvc.updateAsset(accountVO);

			accountVO.setAssetname(deposit); // 입금 내역은 자산에 빼줘야함
			accountVO.setTotal(before.getTotal() * -1);
			assetSvc.updateAsset(accountVO);
			
			return true;
		} else {
			return false;
		}
	}
}
