package com.modifyk.accountbook.transfer;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class TransferToMapService {
	public HashMap<String, Object> toMap(List<TransferVO> transferList) {
		
		// transferList를 날짜별로 모아줌 (key값은 날짜, value는 이체 아이디, 출금, 입금, 금액, 메모)
		// 해당 날짜에 내역이 여러개 있으면 콤마(,)로 내역을 구별
		// 이체 아이디, 출금, 입금, 금액, 메모는 샵(#)으로 구별하여 map에 저장
		HashMap<String, Object> map = new LinkedHashMap<String, Object>();
		
		for(int i = 0; i < transferList.size(); i++) {
			if(map.get(transferList.get(i).getDate()) != null) { // 해당 날짜가 이미 있다면
				// 해당 날짜의 value값(이체 아이디, 출금, 입금, 금액, 메모 문자열)에다가
				// 콤마(,)로 구분하여 이체 아이디, 출금, 입금, 금액, 메모 문자열 추가
				String value = map.get(transferList.get(i).getDate()) + "," + transferList.get(i).getTransferid() + "#" + transferList.get(i).getWithdraw() + "#" + transferList.get(i).getDeposit() + "#" + transferList.get(i).getTotal() + "#" + transferList.get(i).getMemo();
				map.put(transferList.get(i).getDate(), value);
			} else { 
				// 날짜를 key값으로 하고, 이체 아이디, 출금, 입금, 금액, 메모를 샵(#)으로 구분한 문자열을 value 값으로 하여 저장 
				map.put(transferList.get(i).getDate(), transferList.get(i).getTransferid() + "#" + transferList.get(i).getWithdraw() + "#" + transferList.get(i).getDeposit() + "#" + transferList.get(i).getTotal() + "#" + transferList.get(i).getMemo());
			}
		}
		return map;
	}
}
