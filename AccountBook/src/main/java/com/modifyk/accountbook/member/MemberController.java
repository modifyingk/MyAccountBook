package com.modifyk.accountbook.member;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MemberController {
	@Autowired
	MemberDAO mDao;
	
	@Autowired
	EmailService emailSvc;
	
	@Autowired
	AutoInsertService insertSvc;
	
	@Autowired
	RandomCashService rCashSvc;
	
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
		List<MemberVO> idList = mDao.findId(memberVO);
		model.addAttribute("idList", idList);
	}
	
	// 비밀번호 찾기
	@ResponseBody
	@RequestMapping("member/findPw")
	public String findPw(MemberVO memberVO) {
		String result = mDao.findPw(memberVO);
		if(result != null) {
			emailSvc.sendPw(memberVO);
			return "ok";
		} else {
			return "fail";
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
	
	// 회원 포인트 정보
	@ResponseBody
	@RequestMapping("member/userMoneyInfo")
	public MoneyVO userMoneyInfo(String userid) {
		MoneyVO money = mDao.userMoneyInfo(userid);
		return money;
	}
	
	// 물 주기
	@ResponseBody
	@RequestMapping("member/usePoint")
	public int usePoint(String userid) {
		MoneyVO moneyVO = mDao.userMoneyInfo(userid);
		if(moneyVO.getUserpoint() < 10) { // 포인트 부족
			return -1;
		} else {
			mDao.usePoint(userid);
			return 0;
		}
	}
	
	// 캐시 적립 및 단계 리셋
	@ResponseBody
	@RequestMapping("member/randomCash")
	public int randomCash(MoneyVO moneyVO) {
		// 랜덤 cash 뽑기 및 값 setting
		int cash = rCashSvc.makeCash();
		moneyVO.setUsercash(cash);
		
		// 캐시 적립 및 단계 리셋
		int result = mDao.updatePlant(moneyVO);
		if(result > 0) {
			return cash;
		} else {
			return 0;
		}
	}
}
