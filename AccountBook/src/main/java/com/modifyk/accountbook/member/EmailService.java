package com.modifyk.accountbook.member;

import java.util.HashMap;
import java.util.Random;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
	@Autowired
	private MailSender mailSender;
	
	@Autowired
	MemberDAO mDao;

	/* 이메일 -- 인증번호 map */
	private final HashMap<String, Integer> codeMap = new HashMap<String, Integer>();
	private final String from = "구글 계정";
	
	// 인증번호 생성
	public int makeCode() {
		Random rand = new Random();
		int code = rand.nextInt(900000) + 100000;
		return code;
	}

	// 메일 전송
	public void sendMail(String email, String subject, String text) {
		try {
			SimpleMailMessage msg = new SimpleMailMessage();
			msg.setTo(email);
			msg.setFrom(from);
			msg.setSubject(subject);
			msg.setText(text);
			
			mailSender.send(msg);
			
		} catch (Exception e) {
			System.out.println(e);
		}
		
	}
	
	// 인증번호 전송
	@Async
	public void sendCode(String email) {
		if(checkEmail(email)) {
			int code = makeCode(); // 6자리 인증번호 생성
			String subject = "[가계부] 이메일 인증번호";
			String text = "[가계부] 이메일 인증을 위한 인증번호입니다.\n 인증번호 : " + code;
			sendMail(email, subject, text);
			
			codeMap.put(email, code);
		}
	}
	
	// 임시비밀번호 전송
	@Async
	public void sendPw(MemberVO memberVO) {
		String email = memberVO.getEmail();
		if(checkEmail(email)) {
			String tmpPw = makePw();
			memberVO.setPw(tmpPw);
			int result = mDao.updatePw(memberVO); // 비밀번호 업데이트
			if(result > 0) {
				String subject = "[가계부] 임시 비밀번호 발급";
				String text = "[가계부] 임시 비밀번호입니다. 로그인 후 변경해주세요!\n 임시 비밀번호 : " + tmpPw;
				sendMail(email, subject, text);
			}
		}
	}
	
	// 이메일 형식 확인
	public boolean checkEmail(String email) {
		String emailReg = "^[a-zA-Z0-9]+@[0-9a-zA-Z]+\\.[a-z]+$";
		if(Pattern.matches(emailReg, email)) {
		    return true;
		} else {            
			return false;
		}
	}

	// 이메일 인증번호 get
	public int getCode(String email) {
		return codeMap.getOrDefault(email, -1);
	}
	
	// 인증번호 확인
	public boolean verifyCode(String email, int code) {
		int savedCode = getCode(email);
		if(savedCode == code)
			return true;
		else
			return false;
	}
	
	// 이메일 인증번호 삭제
	public void removeCode(String email) {
		codeMap.remove(email);
	}

	// 임시 비밀번호
	public String makePw() {
		char[] ch = {'a', 'b', 'c', 'd', 'e', 'e', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
					'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '~', '!', '@', '#', '$', '%', '^', '&', '*', '?'};
		
		Random rand = new Random();
		
		String code = "";
		for(int i = 0; i < 8; i++) {
			code += ch[rand.nextInt(ch.length)];
		}
		
		return code;
	}
}
