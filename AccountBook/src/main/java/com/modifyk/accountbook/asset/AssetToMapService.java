package com.modifyk.accountbook.asset;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class AssetToMapService {
	public HashMap<String, Object> toMap(List<AssetVO> assetList) {
		// 자산메모에 값이 들어있지 않으면 공백으로 채움
		for(int i = 0; i < assetList.size(); i++) {
			if(assetList.get(i).getAstmemo() == null) {
				assetList.get(i).setAstmemo("");
			}
		}
		
		// assetList를 자산그룹별로 모아줌 (key값은 자산그룹, value는 자산과 자산메모)
		// 해당 자산그룹에 자산이 여러개 있으면 콤마(,)로 자산을 구별
		// 자산과 자산메모는 샵(#)으로 구별하여 map에 저장
		// ex) 카드=농협카드/농협카드메모,우리카드/우리카드메모, 현금=현금/현금메모
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		for(int i = 0; i < assetList.size(); i++) {
			if(map.get(assetList.get(i).getAstgroup()) != null) { // 해당 자산그룹이 이미 있다면
				// 해당 자산그룹의 value값(자산과 자산메모 문자열)에다가
				// 콤마(,)로 구분하여 자산과 자산메모 문자열 추가
				String value = map.get(assetList.get(i).getAstgroup()) + "," + assetList.get(i).getAstname() + "#" + assetList.get(i).getAstmemo();
				map.put(assetList.get(i).getAstgroup(), value);
			} else { 
				// 자산그룹을 key값으로 하고, 자산과 자산메모를 샵(#)으로 구분한 문자열을 value 값으로 하여 저장 
				map.put(assetList.get(i).getAstgroup(), assetList.get(i).getAstname() + "#" + assetList.get(i).getAstmemo());
			}
		}
		return map;
	}
}
