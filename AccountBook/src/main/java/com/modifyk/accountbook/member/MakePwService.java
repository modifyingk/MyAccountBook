package com.modifyk.accountbook.member;

import java.util.Random;

import org.springframework.stereotype.Service;

@Service
public class MakePwService {
	public String makePw() {
		char[] ch = {'a', 'b', 'c', 'd', 'e', 'e', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
					'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
		char[] ch2 = {'~', '!', '@', '#', '$', '%', '^', '&', '*', '?'};
		
		Random rand = new Random();
		
		String code = "";
		for(int i = 0; i < 9; i++) {
			code += ch[rand.nextInt(ch.length)];
		}
		code += ch2[rand.nextInt(ch2.length)];
		
		System.out.println("생성된 코드 : " + code);
		return code;
	}
}
