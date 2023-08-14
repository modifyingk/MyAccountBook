package com.modifyk.accountbook.asset;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AssetGroupController {
	
	@Autowired
	AssetGroupDAO agDao;
	
	// 자산 그룹 리스트
	@ResponseBody
	@RequestMapping("asset/astGroupInfo")
	public List<String> astGroupInfo(String userid) {
		List<String> groupList = agDao.astGroupInfo(userid);
		return groupList;
	}
	
	// 자산 그룹 수정
	@ResponseBody
	@RequestMapping("asset/updateGroup")
	public String updateGroup(String originName, String updateName, String userid) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("originName", originName);
		map.put("updateName", updateName);
		map.put("userid", userid);
		int result = agDao.updateGroup(map);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 자산 그룹 삭제
	@ResponseBody
	@RequestMapping("asset/deleteGroup")
	public String deleteGroup(AssetGroupVO astgroupVO) {
		try {
			int result = agDao.deleteGroup(astgroupVO);
			if(result == 1) {
				return "success";
			} else {
				return "fail";
			}
		} catch (Exception e) {
			return "constraint";
		}
	}
	
	// 자산 그룹 추가
	@ResponseBody
	@RequestMapping("asset/insertGroup")
	public String insertGroup(AssetGroupVO astgroupVO) {
		int result = agDao.insertGroup(astgroupVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 자산 그룹 중복 확인
	@ResponseBody
	@RequestMapping("asset/isOverlapGroup")
	public String isOverlapGroup(AssetGroupVO astgroupVO) {
		String result = agDao.isOverlapGroup(astgroupVO);
		if(result != null) {
			return "impossible";
		} else {
			return "possible";
		}
	}
}
