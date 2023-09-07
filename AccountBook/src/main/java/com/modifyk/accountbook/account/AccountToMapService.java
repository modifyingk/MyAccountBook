package com.modifyk.accountbook.account;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class AccountToMapService {
	public HashMap<String, Object> toMap(List<AccountVO> accountList) {
		
		// accountList를 날짜별로 모아줌 (key값은 날짜, value는 수입/지출, 카테고리, 내용, 돈)
		// 해당 날짜에 내역이 여러개 있으면 콤마(,)로 내역을 구별
		// 수입/지출, 카테고리, 내용 돈은 샵(#)으로 구별하여 map에 저장
		HashMap<String, Object> map = new LinkedHashMap<String, Object>();
		
		for(int i = 0; i < accountList.size(); i++) {
			if(map.get(accountList.get(i).getDate()) != null) { // 해당 날짜가 이미 있다면
				// 해당 날짜의 value값(자산과 자산메모 문자열)에다가
				// 콤마(,)로 구분하여 수입/지출, 카테고리, 내용, 돈 문자열 추가
				String value = map.get(accountList.get(i).getDate()) + "," + accountList.get(i).getAccountid() + "#" + accountList.get(i).getMoneytype() + "#" + accountList.get(i).getAstname() + "#" + accountList.get(i).getCatename() + "#" + accountList.get(i).getContent() + "#" + accountList.get(i).getTotal() + "#" + accountList.get(i).getMemo();
				map.put(accountList.get(i).getDate(), value);
			} else { 
				// 날짜를 key값으로 하고, 수입/지출, 카테고리, 내용, 돈을 샵(#)으로 구분한 문자열을 value 값으로 하여 저장 
				map.put(accountList.get(i).getDate(), accountList.get(i).getAccountid() + "#" + accountList.get(i).getMoneytype() + "#" + accountList.get(i).getAstname() + "#" + accountList.get(i).getCatename() + "#" + accountList.get(i).getContent() + "#" + accountList.get(i).getTotal() + "#" + accountList.get(i).getMemo());
			}
		}
		return map;
	}
}
