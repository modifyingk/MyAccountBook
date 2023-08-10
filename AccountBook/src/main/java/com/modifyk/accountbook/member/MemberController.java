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
	MakeCodeService makeCodeSvc;
	
	@Autowired
	SendMailService sendMailSvc;
	
	@Autowired
	MakePwService makePwSvc;
	
	// 아이디 중복 확인
	@ResponseBody
	@RequestMapping("member/isOverlapId")
	public String isOverlapId(String userid) {
		String idExist = mDao.isOverlapId(userid);
		if(idExist != null) { // 아이디가 존재하는 경우
			return "impossible";
		} else {
			return "possible";
		}
	}
	
	// 이메일 인증번호 전송
	@ResponseBody
	@RequestMapping("member/sendCode")
	public String sendCode(String email) {
		String code = makeCodeSvc.makeCode(); // 6자리 인증번호 생성 service
		
		String from = "구글 계정";
		String subject = "[MoneyPlant] 이메일 인증번호";
		String text = "[MoneyPlant] 이메일 인증을 위한 인증번호입니다.\n 인증번호 : " + code;
		
		String result = sendMailSvc.sendMail(email, from, subject, text);
		
		if(result.equals("success")) {
			return code;
		} else {
			return "fail";
		}
	}
	
	// 회원 가입
	@ResponseBody
	@RequestMapping("member/insertMember")
	public String insertMember(MemberVO memberVO) {
		int result = mDao.insertMember(memberVO);
		if(result == 1) {
			return "success";
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
	
	// 아이디 찾기
	@ResponseBody
	@RequestMapping("member/findId")
	public String findId(MemberVO memberVO) {
		String result = mDao.findId(memberVO);
		if(result != null) { // 이름과 이메일이 일치하는 아이디가 존재
			return result;
		} else {
			return "fail";
		}
	}
	// 찾은 아이디 보여주기
	@RequestMapping("member/showId")
	public void showId(MemberVO memberVO, Model model) {
		List<MemberVO> idList = mDao.showId(memberVO);
		model.addAttribute("idList", idList);
	}
	
	// 비밀번호 찾기
	@ResponseBody
	@RequestMapping("member/findPw")
	public String findPw(MemberVO memberVO) {
		String result = mDao.findPw(memberVO);
		if(result != null) {
			return result;
		} else {
			return "fail";
		}
	}
	
	// 임시 비밀번호 발급
	@ResponseBody
	@RequestMapping("member/tempPw")
	public String updatePw(MemberVO memberVO) {
		String tmpPw = makePwSvc.makePw(); // 임시 비밀번호 생성
		memberVO.setPw(tmpPw); // 임시 비밀번호 셋팅
		
		// 비밀번호 임시비밀번호로 업데이트
		int result = mDao.updatePw(memberVO);
		if(result == 1) {
			// 임시비밀번호 메일로 전송
			String from = "구글 계정";
			String subject = "[MoneyPlant] 임시 비밀번호 발급";
			String text = "[MoneyPlant] 임시 비밀번호입니다. 로그인 후 변경해주세요!\n 임시 비밀번호 : " + tmpPw;
			
			String mailResult = sendMailSvc.sendMail(memberVO.getEmail(), from, subject, text);
			if(mailResult.equals("success")) {
				return "success";
			} else {
				return "fail";
			}
		} else {
			return "fail";
		}
	}
}
