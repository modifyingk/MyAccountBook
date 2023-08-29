package com.modifyk.accountbook.aim;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AimController {
	
	@Autowired
	AimDAO aDao;
	
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
	public List<AimJoinVO> aimInfo(AimVO aimVO) {
		List<AimJoinVO> aimList = aDao.aimInfo(aimVO);
		return aimList;
	}
}
