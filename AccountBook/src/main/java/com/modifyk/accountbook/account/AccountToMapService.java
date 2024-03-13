package com.modifyk.accountbook.account;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;

@Service
public class AccountToMapService {
	
	// 수입/지출 내역 월별 그룹화
	public LinkedHashMap<String, List<AccountVO>> accountToMap(List<AccountVO> accountList) {
		LinkedHashMap<String, List<AccountVO>> map = new LinkedHashMap<>();

		String tmpKey; // map의 key값이 될 날짜
		for(int i = 0; i < accountList.size(); i++) {
			tmpKey = accountList.get(i).getDate();
			if(map.get(tmpKey) != null) { // 해당 날짜가 이미 있다면
				map.get(tmpKey).add(accountList.get(i)); // 해당 날짜값의 list에 accountVO 추가
			} else { // 날짜가 없다면
				List<AccountVO> list = new ArrayList<AccountVO>(); // 새로운 list를 만들어서
				list.add(accountList.get(i));
				map.put(tmpKey, list); // list를 value 값에 추가
			}
		}
		return map;
	}
	
	// 수입/지출 내역 대분류별 그룹화(구글 차트 형식 변환)
	public String makeBigcateData(List<AccountVO> list) {
		// 카테고리별 사용 금액 합계
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		String tmpKey; // map의 key값이 될 날짜
		for(int i = 0; i < list.size(); i++) {
			tmpKey = list.get(i).getBigcate();
			map.put(tmpKey, list.get(i).getTotal());
		}
		
		return transformMap(map);
	}
	
	// 수입/지출 내역 소분류별 그룹화(구글 차트 형식 변환)
	public String makeSmallcateData(List<AccountVO> list) {
		// 카테고리별 사용 금액 합계
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		String tmpKey; // map의 key값이 될 날짜
		for(int i = 0; i < list.size(); i++) {
			tmpKey = list.get(i).getSmallcate();
			map.put(tmpKey, list.get(i).getTotal());
		}
		
		return transformMap(map);
	}
	
	// 구글 차트 형식 변환
	public String transformMap(Map<String, Integer> map) {
		String data = "";
		Set<String> keys = map.keySet(); // 키 값 보관
		
		for(String key : keys) { // map을 ['키', 값], ['키', 값], ... 형태로 변환
			if(data != "")
				data += ",";
			data += "['" + key + "', " + map.get(key) + "]";
		}
		return data;
	}
	
	public HashMap<String, Object> assetToMap(List<AccountVO> accountList) {
		
		// 자산별 사용 금액 합계
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String tmpKey; // map의 key값이 될 날짜
		for(int i = 0; i < accountList.size(); i++) {
			tmpKey = accountList.get(i).getAssetname();
			if(map.get(tmpKey) != null) { // 해당 자산이 이미 있다면
				// 해당 자산의 value값(금액)에다가 금액 더하기
				int value = (int) map.get(tmpKey) + accountList.get(i).getTotal();
				map.put(tmpKey, value);
			} else { 
				// 자산을 key값으로 하고, 금액 저장 
				map.put(tmpKey, accountList.get(i).getTotal());
			}
		}
		return map;
	}
	/*
	public HashMap<String, Object> repeatToMap(List<RepeatVO> repeatList) {
		
		// repeatList를 주기별로 모아줌 (key값은 주기, value는 주기 일자, 반복id, 수입/지출, 자산, 카테고리, 내용, 금액)
		// 해당 주기에 내역이 여러개 있으면 콤마(,)로 내역을 구별
		// value들은 샵(#)으로 구별하여 map에 저장
		HashMap<String, Object> map = new LinkedHashMap<String, Object>();
		
		for(int i = 0; i < repeatList.size(); i++) {
			if(map.get(repeatList.get(i).getRepeatcycle().substring(0, 2)) != null) { // 해당 주기가 이미 있다면
				// 해당 주기의 value값에다가
				// 콤마(,)로 구분하여 문자열 추가
				String value = map.get(repeatList.get(i).getRepeatcycle().substring(0, 2)) + "," + repeatList.get(i).getRepeatcycle().substring(3) + "#" + repeatList.get(i).getRepeatid() + "#" + repeatList.get(i).getMoneytype() + "#" + repeatList.get(i).getAstname() + "#" + repeatList.get(i).getCatename() + "#" + repeatList.get(i).getContent() + "#" + repeatList.get(i).getTotal();
				map.put(repeatList.get(i).getRepeatcycle().substring(0, 2), value);
			} else {
				// 주기를 key값으로 하고, 주기 일자, 반복id, 수입/지출, 자산, 카테고리, 내용, 금액을 샵(#)으로 구분한 문자열을 value 값으로 하여 저장 
				map.put(repeatList.get(i).getRepeatcycle().substring(0, 2), repeatList.get(i).getRepeatcycle().substring(3) + "#" + repeatList.get(i).getRepeatid() + "#" + repeatList.get(i).getMoneytype() + "#" + repeatList.get(i).getAstname() + "#" + repeatList.get(i).getCatename() + "#" + repeatList.get(i).getContent() + "#" + repeatList.get(i).getTotal());
			}
		}
		return map;
	}*/
}
