package com.modifyk.accountbook.asset;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class AssetToMapService {
	public HashMap<String, List<AssetVO>> toMap(List<AssetVO> assetList) {
		HashMap<String, List<AssetVO>> map = new HashMap<String, List<AssetVO>>();
		
		String tmpKey; // map의 key값이 될 날짜
		for(int i = 0; i < assetList.size(); i++) {
			tmpKey = assetList.get(i).getAssetgroup();
			if(map.get(tmpKey) != null) { // 해당 자산그룹이 이미 있다면
				map.get(tmpKey).add(assetList.get(i)); // 해당 자산그룹 값의 list에 assetVO 추가
			} else { // 자산그룹이 없다면
				List<AssetVO> list = new ArrayList<AssetVO>(); // 새로운 list를 만들어서
				list.add(assetList.get(i));
				map.put(tmpKey, list); // list를 value 값에 추가
			}
		}
		return map;
	}
}
