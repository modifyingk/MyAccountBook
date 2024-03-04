package com.modifyk.accountbook.aim;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modifyk.accountbook.member.MemberDAO;

@Controller
public class AimController {
	
	@Autowired
	AimDAO aDao;
	
	@Autowired
	MemberDAO mDao;
	
	@Autowired
	AimToMapService toMapSvc;
	
	// 목표 추가
	@ResponseBody
	@RequestMapping("aim/insertAim")
	public boolean insertAim(AimVO aimVO) {
		int result = aDao.insertAim(aimVO);
		if(result > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	// 목표 가져오기
	@ResponseBody
	@RequestMapping("aim/aimInfo")
	public HashMap<String, AimJoinVO> aimInfo(AimVO aimVO) {
		List<AimJoinVO> aimList = aDao.aimInfo(aimVO);
		HashMap<String, AimJoinVO> map = toMapSvc.toMap(aimList);
		return map;
	}
	
	// 목표 수정
	@ResponseBody
	@RequestMapping("aim/updateAim")
	public boolean updateAim(AimVO aimVO) {
		int result = aDao.updateAim(aimVO);
		if(result > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	// 목표 삭제
	@ResponseBody
	@RequestMapping("aim/deleteAim")
	public boolean deleteAim(AimVO aimVO) {
		int result = aDao.deleteAim(aimVO);
		if(result > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	// 목표 카테고리 중복 확인
	@ResponseBody
	@RequestMapping("aim/isOverlapAim")
	public boolean isOverlapAim(AimVO aimVO) {
		String result = aDao.isOverlapAim(aimVO);
		if(result != null) {
			return false;
		} else {
			return true;
		}
	}
}
