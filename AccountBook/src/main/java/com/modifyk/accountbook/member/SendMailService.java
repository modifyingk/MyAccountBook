package com.modifyk.accountbook.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;

@Service
public class SendMailService {
	@Autowired
	private MailSender mailSender;
	
	public String sendMail(String to, String from, String subject, String text) {
		try {
			SimpleMailMessage msg = new SimpleMailMessage();
			
			msg.setTo(to);
			msg.setFrom(from);
			msg.setSubject(subject);
			msg.setText(text);
			
			mailSender.send(msg);
			
			return "success";
			
		} catch (Exception e) {
			System.out.println(e);
			return "fail";
		}
		
	}
}
