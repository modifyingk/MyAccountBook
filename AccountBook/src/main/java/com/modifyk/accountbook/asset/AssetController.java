package com.modifyk.accountbook.asset;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
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
	
	@Autowired
	InsOrShowAssetService insAssetSvc;
	
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
	public String updateAsset(String originAsset, String updateAsset, String updateGroup, String updateTotal, String updateMemo, String userid) {
		System.out.println(originAsset + " " + updateAsset + " " + updateGroup + " " + updateTotal);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("originAsset", originAsset);
		map.put("updateAsset", updateAsset);
		map.put("updateGroup", updateGroup);
		map.put("updateTotal", updateTotal);
		map.put("updateMemo", updateMemo);
		map.put("userid", userid);
		
		System.out.println(map);
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
		// 카테고리명이 중복되면서 show가 x인 경우
		String overlapResult = aDao.isOverlapHideAsset(assetVO);
		if(overlapResult != null) {
			// 해당 카테고리의 show를 o로 변경
			int showResult = aDao.showAsset(assetVO);
			if(showResult == 1) {
				return "success";
			} else {
				return "fail";
			}
		} else {
			int inResult = aDao.insertAsset(assetVO);
			if(inResult == 1) {
				return "success";
			} else {
				return "fail";
			}
		}
	}
	
	// 자산 삭제
	@ResponseBody
	@RequestMapping("asset/deleteAsset")
	public String deleteAsset(AssetVO assetVO) {
		try {
			int result = aDao.deleteAsset(assetVO);
			if(result == 1) {
				return "success";
			} else {
				return "fail";
			}
		} catch (DataIntegrityViolationException e) { // 외래키 연관되어 있는 경우, 숨김으로 처리
			int result = aDao.hideAsset(assetVO);
			if(result == 1) {
				return "success";
			} else {
				return "fail";
			}
		}
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
	
	// 자산 초기화
	@ResponseBody
	@RequestMapping("asset/resetAsset")
	public void resetCategory(AssetVO assetVO) {
		try {
			int result = aDao.deleteAllAsset(assetVO);
			if(result > 0) {
				insAssetSvc.insertAsset(assetVO);
			}
		} catch (DataIntegrityViolationException e) { // 외래키 연관되어 있는 경우, 숨김으로 처리
			int result = aDao.hideAllAsset(assetVO);
			if(result > 0) {
				insAssetSvc.insertAsset(assetVO);
			}
		}
	}
}
