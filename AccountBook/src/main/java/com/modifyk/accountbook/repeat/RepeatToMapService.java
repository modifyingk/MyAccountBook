package com.modifyk.accountbook.repeat;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class RepeatToMapService {
	
	// 수입/지출 내역 월별 그룹화
	public LinkedHashMap<String, List<RepeatVO>> repeatToMap(List<RepeatVO> repeatList) {
		LinkedHashMap<String, List<RepeatVO>> map = new LinkedHashMap<>();

		String tmpKey; // map의 key값이 될 날짜
		for(int i = 0; i < repeatList.size(); i++) {
			tmpKey = repeatList.get(i).getDate();
			if(map.get(tmpKey) != null) { // 해당 날짜가 이미 있다면
				map.get(tmpKey).add(repeatList.get(i)); // 해당 날짜값의 list에 accountVO 추가
			} else { // 날짜가 없다면
				List<RepeatVO> list = new ArrayList<RepeatVO>(); // 새로운 list를 만들어서
				list.add(repeatList.get(i));
				map.put(tmpKey, list); // list를 value 값에 추가
			}
		}
		return map;
	}
	
}
