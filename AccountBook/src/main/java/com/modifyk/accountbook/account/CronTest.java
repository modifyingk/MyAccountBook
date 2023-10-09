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
        DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("E");
        String today = now.format(formatter);
        String todayDay = now.format(formatter2);
        
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
				
			} else if(list.get(i).getRepeatcycle().contains("매월")) {
				// 현재 일자와 반복 일자가 같으면
				if(today.split("-")[2].equals(list.get(i).getRepeatcycle().split(" ")[1])) {
					accountVO.setAstname(list.get(i).getAstname());
					accountVO.setCatename(list.get(i).getCatename());
					accountVO.setContent(list.get(i).getContent());
					accountVO.setDate(today);
					accountVO.setMoneytype(list.get(i).getMoneytype());
					accountVO.setTotal(list.get(i).getTotal());
					accountVO.setUserid(list.get(i).getUserid());
					aDao.insertAccount(accountVO);
				}
			} else if(list.get(i).getRepeatcycle().contains("매년")) {
				// 현재 연월과 반복 연월이 같으면
				if((today.split("-")[1] + "/" + today.split("-")[2]).equals(list.get(i).getRepeatcycle().split(" ")[1])) {
					accountVO.setAstname(list.get(i).getAstname());
					accountVO.setCatename(list.get(i).getCatename());
					accountVO.setContent(list.get(i).getContent());
					accountVO.setDate(today);
					accountVO.setMoneytype(list.get(i).getMoneytype());
					accountVO.setTotal(list.get(i).getTotal());
					accountVO.setUserid(list.get(i).getUserid());
					aDao.insertAccount(accountVO);
				}
			} else if(list.get(i).getRepeatcycle().contains("매주")) {
				if(todayDay.equals(list.get(i).getRepeatcycle().split(" ")[1])) {
					accountVO.setAstname(list.get(i).getAstname());
					accountVO.setCatename(list.get(i).getCatename());
					accountVO.setContent(list.get(i).getContent());
					accountVO.setDate(today);
					accountVO.setMoneytype(list.get(i).getMoneytype());
					accountVO.setTotal(list.get(i).getTotal());
					accountVO.setUserid(list.get(i).getUserid());
					aDao.insertAccount(accountVO);
				}
			}
		}
	}
	
}
