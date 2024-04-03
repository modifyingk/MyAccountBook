package com.modifyk.accountbook.member;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modifyk.accountbook.account.AccountDAO;
import com.modifyk.accountbook.account.AccountVO;
import com.modifyk.accountbook.aim.AimJoinVO;
import com.modifyk.accountbook.aim.AimTotalDAO;
import com.modifyk.accountbook.aim.AimTotalVO;

@Controller
public class MemberController {
	@Autowired
	MemberDAO mDao;
	
	@Autowired
	AccountDAO aDao;
	
	@Autowired
	AimTotalDAO atDao;
	
	@Autowired
	EmailService emailSvc;
	
	@Autowired
	AutoInsertService insertSvc;
	
	// 아이디 중복 확인
	@ResponseBody
	@RequestMapping("member/overlapId")
	public boolean overlapId(String userid) {
		String result = mDao.overlapId(userid);
		if(result != null) { // 아이디가 존재하는 경우
			return false;
		} else {
			return true;
		}
	}
	
	// 회원 가입
	@ResponseBody
	@RequestMapping("member/insertMember")
	public String insertMember(MemberVO memberVO, int code) {
		if(!overlapId(memberVO.getUserid())) // 아이디 중복 다시 확인
			return "id_error";
		
		if(!emailSvc.verifyCode(memberVO.getEmail(), code)) { // 인증번호 확인
			return "code_error";
		}
		
		int result = mDao.insertMember(memberVO);
		String userid = memberVO.getUserid();
		insertSvc.autoInsert(userid);
		
		if(result > 0) {
			emailSvc.removeCode(memberVO.getEmail()); // 회원 가입 성공 시 인증번호 map 삭제
			return "ok";
		} else {
			return "fail";
		}
	}
	
	// 이메일 인증번호 전송
	@ResponseBody
	@RequestMapping("member/sendCode")
	public void sendCode(String email) {
		emailSvc.sendCode(email);
	}
	
	// 인증번호 확인
	@ResponseBody
	@RequestMapping("member/verifyCode")
	public boolean verifyCode(String email, int code) {
		if(emailSvc.verifyCode(email, code)) {
			emailSvc.removeCode(email);
			return true;
		} else {
			return false;
		}
	}
	
	// 아이디 찾기
	@RequestMapping("member/showId")
	public void showId(MemberVO memberVO, Model model) {
		System.out.println("아이디 찾기 요청 : " + memberVO);
		List<MemberVO> idList = mDao.findId(memberVO);
		System.out.println("아이디 찾기 결과 : " + idList);
		model.addAttribute("idList", idList);
	}
	
	// 비밀번호 찾기
	@ResponseBody
	@RequestMapping("member/findPw")
	public boolean findPw(MemberVO memberVO) {
		String result = mDao.findPw(memberVO);
		if(result != null) {
			emailSvc.sendPw(memberVO);
			return true;
		} else {
			return false;
		}
	}
	
	// 로그인
	@ResponseBody
	@RequestMapping("member/login")
	public String login(MemberVO memberVO, HttpSession session) {
		String loginid = mDao.login(memberVO);
		
		if(loginid != null) { // 로그인 성공
			session.setAttribute("userid", memberVO.getUserid());
			return loginid;
		} else { // 로그인 실패
			return "fail";
		}
	}
		
	// 로그아웃
	@RequestMapping("member/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:../main/main.jsp";
	}
		
	// 회원정보
	@ResponseBody
	@RequestMapping("member/userInfo")
	public MemberVO userInfo(String userid) {
		MemberVO info = mDao.userInfo(userid);
		return info;
	}
	
	// 회원정보 수정
	@ResponseBody
	@RequestMapping("member/updateMember")
	public boolean updateMember(MemberVO memberVO) {
		int result = mDao.updateMember(memberVO);
		if(result > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	// 비밀번호 확인
	@ResponseBody
	@RequestMapping("member/checkPw")
	public boolean checkPw(MemberVO memberVO) {
		String result = mDao.login(memberVO);
		if(result != null) {
			return true;
		} else {
			return false;
		}
	}
	
	// 비밀번호 변경
	@ResponseBody
	@RequestMapping("member/updatePw")
	public boolean updatePw(MemberVO memberVO) {
		int result = mDao.updatePw(memberVO);
		if(result > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	// 회원 탈퇴
	@ResponseBody
	@RequestMapping("member/deleteMember")
	public boolean deleteMember(String userid) {
		int result = mDao.deleteMember(userid);
		if(result > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	// 최근 수입/지출 합계
	@RequestMapping("member/recentAccount")
	public void recentAccount(AccountVO accountVO, Model model) {
		accountVO.setMoneytype("수입");
		List<AccountVO> incomeList = aDao.recentAccount(accountVO);
		model.addAttribute("incomeList", incomeList);
		System.out.println(incomeList);
		
		accountVO.setMoneytype("지출");
		List<AccountVO> spendList = aDao.recentAccount(accountVO);
		model.addAttribute("spendList", spendList);
		System.out.println(spendList);
		
		int monthIncome = 0;
		int monthSpend = 0;
		
		if(incomeList.size() > 0)
			monthIncome = incomeList.get(incomeList.size() - 1).getTotal();
		if(spendList.size() > 0)
			monthSpend = spendList.get(spendList.size() - 1).getTotal();
			
		model.addAttribute("monthIncome", monthIncome);
		model.addAttribute("monthSpend", monthSpend);
	}
	
	// 나의 목표
	@RequestMapping("member/selectAim")
	public void selectAim(String userid, Model model) {
		AimTotalVO aimtotalVO = new AimTotalVO();
		aimtotalVO.setMoneytype("수입");
		aimtotalVO.setUserid(userid);
		String total = atDao.selectTotal(aimtotalVO);
		
		AimJoinVO aimjoinVO = atDao.incomePerAim(userid);
		
		System.out.println(aimjoinVO);
		model.addAttribute("vo", aimjoinVO);
		model.addAttribute("aimtotal", total);
	}
	
}
