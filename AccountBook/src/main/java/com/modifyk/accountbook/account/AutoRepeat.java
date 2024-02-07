package com.modifyk.accountbook.account;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

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
        
		List<AccountRepeatVO> list = rDao.repeatAll();
		AccountVO accountVO = new AccountVO();
		for(int i = 0; i < list.size(); i++) {
			if(list.get(i).getRepeatcycle().equals("매월")) {
				if(today.split("-")[2].equals(list.get(i).getDate().split("-")[2])) {
					accountVO.setAssetid(list.get(i).getAssetid());
					accountVO.setAssetname(list.get(i).getAssetname());
					accountVO.setCatename(list.get(i).getCatename());
					accountVO.setContent(list.get(i).getContent());
					accountVO.setDate(today);
					accountVO.setMoneytype(list.get(i).getMoneytype());
					accountVO.setTotal(list.get(i).getTotal());
					accountVO.setUserid(list.get(i).getUserid());
					accountVO.setMemo("");
					
					aDao.insertAccount(accountVO);
				}
				
			}  else if(list.get(i).getRepeatcycle().equals("매년")) {
				// 현재 연월과 반복 연월이 같으면
				if((today.substring(4)).equals(list.get(i).getDate().substring(4))){
					accountVO.setAssetid(list.get(i).getAssetid());
					accountVO.setAssetname(list.get(i).getAssetname());
					accountVO.setCatename(list.get(i).getCatename());
					accountVO.setContent(list.get(i).getContent());
					accountVO.setDate(today);
					accountVO.setMoneytype(list.get(i).getMoneytype());
					accountVO.setTotal(list.get(i).getTotal());
					accountVO.setUserid(list.get(i).getUserid());
					accountVO.setMemo("");
					
					aDao.insertAccount(accountVO);
				}
			}
		}
	}
	
}
