package com.modifyk.accountbook.category;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class CategoryToMapService {
	// 카테고리 대분류별 그룹화
	public HashMap<String, List<CategoryVO>> categoryToMap(List<CategoryVO> categoryList) {
		HashMap<String, List<CategoryVO>> map = new HashMap<String, List<CategoryVO>>();

		String tmpKey; // map의 key값이 될 대분류
		for(int i = 0; i < categoryList.size(); i++) {
			tmpKey = categoryList.get(i).getBigcate();
			if(map.get(tmpKey) != null) { // 해당 대분류가 이미 있다면
				map.get(tmpKey).add(categoryList.get(i)); // 해당 대분류 값의 list에 categoryVO 추가
			} else { // 날짜가 없다면
				List<CategoryVO> list = new ArrayList<CategoryVO>(); // 새로운 list를 만들어서
				list.add(categoryList.get(i));
				map.put(tmpKey, list); // list를 value 값에 추가
			}
		}
		return map;
	}
}
