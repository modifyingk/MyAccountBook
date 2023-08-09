package com.modifyk.accountbook.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
		System.out.println(code);
		
		System.out.println(email);
		
		String from = "구글 계정";
		String subject = "[Accountbook] 이메일 인증번호";
		String text = "[Accountbook] 이메일 인증을 위한 인증번호입니다.\n 인증번호 : " + code;
		
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
}
