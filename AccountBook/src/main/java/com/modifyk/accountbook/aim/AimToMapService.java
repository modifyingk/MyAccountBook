package com.modifyk.accountbook.aim;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class AimToMapService {
	public HashMap<String, Object> toMap(List<AimJoinVO> aimList) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		for(int i = 0; i < aimList.size(); i++) {
			if(map.get(aimList.get(i).getCatename()) == null) {
				map.put(aimList.get(i).getCatename(), aimList.get(i).getAimid() + "#" + aimList.get(i).getAim_money() + "#" + aimList.get(i).getTotal());
			}
		}
		
		return map;
	}
	
	public HashMap<String, String> toMapAll(List<AimJoinVO> aimList) {
		HashMap<String, String> map = new HashMap<String, String>();
		
		for(int i = 0; i < aimList.size(); i++) {
			if(map.get(aimList.get(i).getCatename()) == null) {
				map.put(aimList.get(i).getCatename(), aimList.get(i).getAim_money() + "#" + aimList.get(i).getTotal() + "#" + aimList.get(i).getUserid());
			}
		}
		
		return map;
	}
}
