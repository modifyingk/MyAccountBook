package com.modifyk.accountbook.member;

import java.util.Random;

import org.springframework.stereotype.Service;

@Service
public class MakeCodeService {
	public String makeCode() {
		Random rand = new Random();
		String code = String.valueOf(rand.nextInt(900000) + 100000);
		return code;
	}
}
