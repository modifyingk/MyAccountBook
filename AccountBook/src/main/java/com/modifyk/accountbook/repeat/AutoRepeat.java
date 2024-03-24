package com.modifyk.accountbook.repeat;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.modifyk.accountbook.account.AccountDAO;
import com.modifyk.accountbook.account.AccountVO;

@Component
public class AutoRepeat {
	@Autowired
	RepeatDAO rDao;
	
	@Autowired
	AccountDAO aDao;
	
	public void repeatAccount() {
		// 현재 날짜 구하기
        LocalDate now = LocalDate.now();
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyyMMdd");
        String date = now.format(fmt);
        
        // 내역 자동 추가 (매년)
        RepeatVO repeatVO = new RepeatVO();
        repeatVO.setRepeatcycle("매년");
        repeatVO.setDate(date.substring(4));
        List<AccountVO> list = rDao.todayRepeat(repeatVO);
        for(int i = 0; i < list.size(); i++) {
        	list.get(i).setDate(date); // 현재 연월일로 날짜 세팅
        	aDao.insertAccount(list.get(i));
        }
        
        // 내역 자동 추가 (매월)
        repeatVO.setRepeatcycle("매월");
        repeatVO.setDate(date.substring(6));
        list = rDao.todayRepeat(repeatVO);
        for(int i = 0; i < list.size(); i++) {
        	list.get(i).setDate(date);
        	aDao.insertAccount(list.get(i));
        }
	}
	
}
