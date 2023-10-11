package com.modifyk.accountbook.account;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CronTest {
	@Autowired
	RepeatDAO rDao;
	
	@Autowired
	AccountDAO aDao;
	
	public void test() {
		// 현재 날짜 구하기
        LocalDate now = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String today = now.format(formatter);
        
		List<RepeatVO> list = rDao.repeatAll();
		
		AccountVO accountVO = new AccountVO();
		for(int i = 0; i < list.size(); i++) {
			if(list.get(i).getRepeatcycle().contains("매일")) {
				accountVO.setAstname(list.get(i).getAstname());
				accountVO.setCatename(list.get(i).getCatename());
				accountVO.setContent(list.get(i).getContent());
				accountVO.setDate(today);
				accountVO.setMoneytype(list.get(i).getMoneytype());
				accountVO.setTotal(list.get(i).getTotal());
				accountVO.setUserid(list.get(i).getUserid());
				aDao.insertAccount(accountVO);
				
				System.out.println(accountVO);
			}
		}
	}
	
}
