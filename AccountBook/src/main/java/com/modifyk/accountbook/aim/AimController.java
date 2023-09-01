package com.modifyk.accountbook.aim;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AimController {
	
	@Autowired
	AimDAO aDao;
	
	@Autowired
	AimToMapService toMapSvc;
	// 목표 추가
	@ResponseBody
	@RequestMapping("aim/insertAim")
	public String insertAim(AimVO aimVO) {
		int result = aDao.insertAim(aimVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 목표 가져오기
	@ResponseBody
	@RequestMapping("aim/aimInfo")
	public HashMap<String, Object> aimInfo(AimVO aimVO) {
		List<AimJoinVO> aimList = aDao.aimInfo(aimVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(aimList.size() < 1) {
			map.put("no", "no");
		} else {
			map = toMapSvc.toMap(aimList);
		}
		return map;
	}
	
	// 목표 수정
	@ResponseBody
	@RequestMapping("aim/updateAim")
	public String updateAim(AimVO aimVO) {
		int result = aDao.updateAim(aimVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 목표 삭제
	@ResponseBody
	@RequestMapping("aim/deleteAim")
	public String deleteAim(AimVO aimVO) {
		int result = aDao.deleteAim(aimVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 목표 카테고리 중복 확인
	@ResponseBody
	@RequestMapping("aim/isOverlapAim")
	public String isOverlapAim(AimVO aimVO) {
		String result = aDao.isOverlapAim(aimVO);
		if(result != null) {
			return "impossible";
		} else {
			return "possible";
		}
	}
}
