package com.modifyk.accountbook.party;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PartyController {

	@Autowired
	PartyDAO pDao;
	
	// 그룹 생성
	@ResponseBody
	@RequestMapping("party/insertParty")
	public String insertParty(PartyVO partyVO) {
		int result = pDao.insertParty(partyVO);
		if(result > 0) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 그룹 목록
	@ResponseBody
	@RequestMapping("party/selectParty")
	public List<PartyVO> selectParty() {
		return pDao.selectParty();
	}
	
	// 그룹명 중복확인
	@ResponseBody
	@RequestMapping("party/isOverlapParty")
	public String isOverlapParty(String partyname) {
		String result = pDao.isOverlapParty(partyname);
		if(result != null) {
			return "impossible";
		} else {
			return "possible";
		}
	}
	
	// 그룹 정보
	@ResponseBody
	@RequestMapping("party/partyInfo")
	public PartyVO partyInfo(String partyname) {
		return pDao.partyInfo(partyname);
	}
	
	// 그룹 검색
	@ResponseBody
	@RequestMapping("party/searchParty")
	public List<PartyVO> searchParty(String partyname) {
		return pDao.searchParty(partyname);
	}
}
