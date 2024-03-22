package com.modifyk.accountbook.repeat;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.modifyk.accountbook.account.AccountDAO;

@Component
public class AutoRepeat {
	@Autowired
	RepeatDAO rDao;
	
	@Autowired
	AccountDAO aDao;
	
	public void repeatAccount() {
		// 현재 날짜 구하기
        LocalDate now = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        //DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("E");
        String today = now.format(formatter);
       // String todayDay = now.format(formatter2);
        
	}
	
}
