package com.modifyk.accountbook.asset;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AssetController {
	
	@Autowired
	AssetDAO aDao;
	
	@Autowired
	AssetToMapService toMapSvc;
	
	// 자산 리스트
	@ResponseBody
	@RequestMapping("asset/assetInfo")
	public HashMap<String, Object> assetInfo(String userid, Model model) {
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
}
