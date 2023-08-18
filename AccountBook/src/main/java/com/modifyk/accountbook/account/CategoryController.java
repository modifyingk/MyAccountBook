package com.modifyk.accountbook.account;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CategoryController {
	
	@Autowired
	CategoryDAO cDao;
	
	// 카테고리 추가
	@ResponseBody
	@RequestMapping("account/insertCategory")
	public String insertCategory(CategoryVO categoryVO) {
		int result = cDao.insertCategory(categoryVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
		
	// 카테고리 수정
	@ResponseBody
	@RequestMapping("account/updateCategory")
	public String updateCategory(String originType, String originName, String updateType, String updateName, String userid) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("originType", originType);
		map.put("originName", originName);
		map.put("updateType", updateType);
		map.put("updateName", updateName);
		map.put("userid", userid);

		int result = cDao.updateCategory(map);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
		
	// 카테고리 삭제
	@ResponseBody
	@RequestMapping("account/deleteCategory")
	public String deleteCategory(CategoryVO categoryVO) {
		int result = cDao.deleteCategory(categoryVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}

	// 카테고리 list
	@ResponseBody
	@RequestMapping("account/categoryInfo")
	public List<CategoryVO> CategoryInfo(CategoryVO categoryVO) {
		List<CategoryVO> cateList = cDao.CategoryInfo(categoryVO);
		return cateList;
	}
	
	// 카테고리 중복 검사
	@ResponseBody
	@RequestMapping("account/isOverlapCate")
	public String isOverlapCate(CategoryVO categoryVO) {
		String result = cDao.isOverlapCate(categoryVO);
		if(result != null) {
			return "impossible";
		} else {
			return "possible";
		}
	}
}
