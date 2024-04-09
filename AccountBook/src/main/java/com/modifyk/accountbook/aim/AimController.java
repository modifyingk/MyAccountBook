package com.modifyk.accountbook.aim;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modifyk.accountbook.account.AccountDAO;
import com.modifyk.accountbook.account.AccountVO;
import com.modifyk.accountbook.member.MemberDAO;

@Controller
public class AimController {
	
	@Autowired
	AimDAO aDao;
	
	@Autowired
	MemberDAO mDao;
	
	@Autowired
	AimTotalDAO atDao;
	
	@Autowired
	AccountDAO actDao;
	
	// 목표 카테고리 중복 확인
	@ResponseBody
	@RequestMapping("aim/overlapAim")
	public boolean overlapAim(AimVO aimVO) {
		String result = aDao.overlapAim(aimVO);
		if(result != null) {
			return false;
		} else {
			return true;
		}
	}

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
	@RequestMapping("aim/selectAim")
	public void selectAim(AimVO aimVO, Model model) {
		List<AimJoinVO> list = aDao.selectAim(aimVO);
		model.addAttribute("list", list);
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
	
	// 전체 목표 값(예산) 가져오기
	@ResponseBody
	@RequestMapping("aim/selectTotal")
	public String selectTotal(AimTotalVO aimtotalVO) {
		String aimtotal = atDao.selectTotal(aimtotalVO);
		if(aimtotal == null)
			aimtotal = "0";
		return aimtotal;
	}
		
	// 전체 목표 값(예산) 추가
	@ResponseBody
	@RequestMapping("aim/insertTotal")
	public boolean insertTotal(AimTotalVO aimTotalVO) {
		int result = atDao.insertTotal(aimTotalVO);
		if(result > 0)
			return true;
		else
			return false;
	}
	
	// 전체 목표 값(예산) 수정
	@ResponseBody
	@RequestMapping("aim/updateTotal")
	public boolean updateTotal(AimTotalVO aimTotalVO) {
		int result = atDao.updateTotal(aimTotalVO);
		if(result > 0)
			return true;
		else
			return false;
	}
	
	// 전체 목표 값(예산)과 총 지출 값 가져오기
	@RequestMapping("aim/selectAimTotal")
	public void selectAimTotal(AimTotalVO aimtotalVO, Model model) {
		AccountVO accountVO = new AccountVO();
		accountVO.setMoneytype(aimtotalVO.getMoneytype());
		accountVO.setUserid(aimtotalVO.getUserid());
		accountVO.setDate(aimtotalVO.getDate());
		
		String spend = actDao.monthTotal(accountVO); // 이번 달 총 지출
		String aim = atDao.selectTotal(aimtotalVO); // 예산
		if(spend == null)
			spend = "0";
		
		model.addAttribute("spend", spend);
		model.addAttribute("aim", aim);
	}
	
	// 분배 가능한 금액
	@RequestMapping("aim/selectBalance")
	public void selectBalance(String userid, Model model) {
		String balance = atDao.selectBalance(userid);
		if(balance == null)
			balance = "null";
		model.addAttribute("balance", balance);
	}
}
