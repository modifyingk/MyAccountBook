package com.modifyk.accountbook.asset;

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
		return assetList;
	}
}
