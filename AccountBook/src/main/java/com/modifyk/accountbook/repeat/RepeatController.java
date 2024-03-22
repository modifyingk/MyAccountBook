package com.modifyk.accountbook.repeat;

import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class RepeatController {
	@Autowired
	RepeatDAO rDao;
	
	@Autowired
	RepeatToMapService toMapSvc;
	
	// 반복 중복 확인
	@ResponseBody
	@RequestMapping("repeat/overlapRepeat")
	public boolean overlapRepeat(RepeatVO repeatVO) {
		RepeatVO result = rDao.overlapRepeat(repeatVO);
		if(result != null) // 중복되는 내용이 존재
			return false;
		else
			return true;
	}
	
	// 반복 추가
	@ResponseBody
	@RequestMapping("repeat/insertRepeat")
	public boolean insertRepeat(RepeatVO repeatVO) {
		if(repeatVO.getRepeatcycle().equals("매월")) {
			repeatVO.setDate(repeatVO.getDate().substring(6, 8));
		} else if(repeatVO.getRepeatcycle().equals("매년")) {
			repeatVO.setDate(repeatVO.getDate().substring(4, 8));
		}
		int result = rDao.insertRepeat(repeatVO);
		if(result > 0)
			return true;
		else
			return false;
	}
	
	// 반복 내역 가져오기
	@RequestMapping("repeat/selectRepeat")
	public void selectRepeat(RepeatVO repeatVO, Model model) {
		List<RepeatVO> list = rDao.selectRepeat(repeatVO);
		LinkedHashMap<String, List<RepeatVO>> map = toMapSvc.repeatToMap(list);
		model.addAttribute("map", map);
	}
	
	// 반복 삭제
	@ResponseBody
	@RequestMapping("repeat/deleteRepeat")
	public boolean deleteRepeat(RepeatVO repeatVO) {
		int result = rDao.deleteRepeat(repeatVO);
		if(result > 0)
			return true;
		else
			return false;
	}
}
