package com.modifyk.accountbook.aim;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class AimToMapService {
	
	public HashMap<String, AimJoinVO> toMap(List<AimJoinVO> aimList) {
		HashMap<String, AimJoinVO> map = new HashMap<>();
		
		String tmpKey; // map의 key값이 될 카테고리
		for(int i = 0; i < aimList.size(); i++) {
			tmpKey = aimList.get(i).getCatename();
			if(map.get(tmpKey) == null) {
				map.put(tmpKey, aimList.get(i));
			}
		}
		System.out.println(map);
		return map;
	}
}
