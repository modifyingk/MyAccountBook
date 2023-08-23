package com.modifyk.accountbook.account;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.stereotype.Service;

@Service
public class MakeAccountIDService {
	
	public String makeAccountID(String moneytype) {
		// 아이디 생성
		String accountid = "";
		if(moneytype.equals("수입")) {
			accountid += "P";
		} else {
			accountid += "M";
		}
				
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		Date date = new Date();
		String now = sdf.format(date);
		accountid += now;
		
		return accountid;
	}
}
