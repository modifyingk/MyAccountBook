package com.modifyk.accountbook.account;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class StatsMapService {
	public HashMap<String, Object> toMap(List<AccountVO> accountList) {
		
		// accountList를 날짜별로 모아줌 (key값은 날짜, value는 수입/지출, 카테고리, 내용, 돈)
		// 해당 날짜에 내역이 여러개 있으면 콤마(,)로 내역을 구별
		// 수입/지출, 카테고리, 내용 돈은 슬래시(/)로 구별하여 map에 저장
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		for(int i = 0; i < accountList.size(); i++) {
			if(map.get(accountList.get(i).getCatename()) != null) { // 해당 카테고리가 이미 있다면
				// 해당 카테고리의 value값(금액)에다가 금액 더하기
				int value = (int) map.get(accountList.get(i).getCatename()) + accountList.get(i).getTotal();
				map.put(accountList.get(i).getCatename(), value);
			} else { 
				// 카테고리를 key값으로 하고, 금액 저장 
				map.put(accountList.get(i).getCatename(), accountList.get(i).getTotal());
			}
		}
		return map;
	}
}
