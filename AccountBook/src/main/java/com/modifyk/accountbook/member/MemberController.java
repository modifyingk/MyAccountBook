package com.modifyk.accountbook.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {
	@Autowired
	MemberDAO mDao;
	
	@Autowired
	MakeCodeService makeCodeSvc;
	
	// 아이디 중복 확인
	@RequestMapping("member/isOverlapId")
	public String isOverlapId(String userid) {
		String idExist = mDao.isOverlapId(userid);
		if(idExist != null) { // 아이디가 존재하는 경우
			return "member/impossible_id";
		} else {
			return "member/possible_id";
		}
	}
	
	// 이메일 인증번호 전송
	@RequestMapping("member/sendCode")
	public void sendCode(String email) {
		String code = makeCodeSvc.makeCode(); // 6자리 인증번호 생성 service
		System.out.println(code);
		// code 전송
		
	}
}
