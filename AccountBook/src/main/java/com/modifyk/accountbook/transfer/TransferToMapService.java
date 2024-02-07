package com.modifyk.accountbook.transfer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class TransferToMapService {
	public HashMap<String, List<TransferVO>> toMap(List<TransferVO> transferList) {
		
		HashMap<String, List<TransferVO>> map = new LinkedHashMap<String, List<TransferVO>>();
		String tmpKey;
		for(int i = 0; i < transferList.size(); i++) {
			tmpKey = transferList.get(i).getDate();
			if(map.get(tmpKey) != null) { // 해당 날짜가 이미 있다면
				map.get(tmpKey).add(transferList.get(i));
			} else { 
				List<TransferVO> list = new ArrayList<TransferVO>();
				list.add(transferList.get(i));
				map.put(tmpKey, list);
			}
		}
		return map;
	}
}
