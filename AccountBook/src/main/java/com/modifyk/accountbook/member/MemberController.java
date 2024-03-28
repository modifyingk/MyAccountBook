package com.modifyk.accountbook.member;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modifyk.accountbook.account.AccountDAO;
import com.modifyk.accountbook.account.AccountVO;

@Controller
public class MemberController {
	@Autowired
	MemberDAO mDao;
	
	@Autowired
	AccountDAO aDao;
	
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
	
	LocalDate now = LocalDate.now();
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMM");
	String date = now.format(formatter);
	
	// 이번 달 수입/지출 합계
	@RequestMapping("member/monthAccount")
	public void monthAccount(AccountVO accountVO, Model model) {
		accountVO.setDate(date); // 오늘 날짜
		List<AccountVO> list = aDao.monthAccount(accountVO);
		model.addAttribute("list", list);
	}
	
	// 최근 수입/지출 합계
	@RequestMapping("member/recentAccount")
	public void recentAccount(AccountVO accountVO, Model model) {
		// 오늘 날짜
		LocalDate nextNow = now.plusMonths(1);
		String nextMonth = nextNow.format(formatter);
		accountVO.setDate(nextMonth); // 내일 날짜로 세팅
		
		accountVO.setMoneytype("수입");
		List<AccountVO> incomeList = aDao.recentAccount(accountVO);
		model.addAttribute("incomeList", incomeList);
		
		accountVO.setMoneytype("지출");
		List<AccountVO> spendList = aDao.recentAccount(accountVO);
		model.addAttribute("spendList", spendList);
	}
	
}
