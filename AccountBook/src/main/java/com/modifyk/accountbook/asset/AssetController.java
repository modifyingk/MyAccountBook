package com.modifyk.accountbook.asset;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modifyk.accountbook.account.AccountToMapService;
import com.modifyk.accountbook.account.AccountVO;

@Controller
public class AssetController {
	
	@Autowired
	AssetDAO aDao;
	
	@Autowired
	AssetToMapService toMapSvc;
	
	@Autowired
	AccountToMapService actMapSvc;
	
	// 자산 리스트
	@ResponseBody
	@RequestMapping("asset/assetInfo")
	public HashMap<String, Object> assetInfo(String userid) {
		List<AssetVO> assetList = aDao.assetInfo(userid);
		HashMap<String, Object> map = toMapSvc.toMap(assetList); // List 타입의 자산 리스트 결과를 HashMap으로 변환
		return map;
	}
	
	// 자산 수정
	@ResponseBody
	@RequestMapping("asset/updateAsset")
	public String updateAsset(String originAsset, String updateAsset, String updateGroup, String updateMemo, String userid) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("originAsset", originAsset);
		map.put("updateAsset", updateAsset);
		map.put("updateGroup", updateGroup);
		map.put("updateMemo", updateMemo);
		map.put("userid", userid);
			
		int result = aDao.updateAsset(map);
		
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 자산 중복 확인
	@ResponseBody
	@RequestMapping("asset/isOverlapAsset")
	public String isOverlapAsset(AssetVO assetVO) {
		String result = aDao.isOverlapAsset(assetVO);
		if(result != null) {
			return "impossible";
		} else {
			return "possible";
		}
	}
	
	// 자산 추가
	@ResponseBody
	@RequestMapping("asset/insertAsset")
	public String insertAsset(AssetVO assetVO) {
		int result = aDao.insertAsset(assetVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 자산 삭제
	@ResponseBody
	@RequestMapping("asset/deleteAsset")
	public String deleteAsset(AssetVO assetVO) {
		int result = aDao.deleteAsset(assetVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 자산별 합계
	@ResponseBody
	@RequestMapping("asset/assetTotal")
	public List<AccountVO> assetTotal(String userid) {
		List<AccountVO> assetTotal = aDao.assetTotal(userid);
		return assetTotal;
	}
	
	// 자산별 내역
	@ResponseBody
	@RequestMapping("asset/assetAccount")
	public HashMap<String, Object> assetAccount(AccountVO accountVO) {
		List<AccountVO> accountList = aDao.assetAccount(accountVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(accountList.size() < 1) {
			map.put("no", "no");
		} else {
			map = actMapSvc.toMap(accountList);
		}
		return map;
	}
}
