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
	
	// 자산 리스트
	@ResponseBody
	@RequestMapping("asset/assetInfo")
	public List<AssetVO> assetInfo(String userid, Model model) {
		List<AssetVO> assetList = aDao.assetInfo(userid);
		for(int i = 0; i < assetList.size(); i++) { // 값이 들어있지 않으면 공백으로 채워서 전달
			if(assetList.get(i).getAstmemo() == null) {
				assetList.get(i).setAstmemo("");
			}
		}
		return assetList;
	}
	
	// 자산 수정
	@ResponseBody
	@RequestMapping("asset/updateAsset")
	public String updateGroup(String originAsset, String originGroup, String updateAsset, String updateGroup, String updateMemo, String userid) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("originAsset", originAsset);
		map.put("originGroup", originGroup);
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
}
