package com.modifyk.accountbook.account;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CategoryController {
	
	@Autowired
	CategoryDAO cDao;
	
	@Autowired
	InsertCategoryService insertCateSvc;
	
	// 카테고리 추가
	@ResponseBody
	@RequestMapping("account/insertCategory")
	public String insertCategory(CategoryVO categoryVO) {
		// 카테고리명이 중복되면서 show가 x인 경우
		String overlapResult = cDao.isOverlapHideCate(categoryVO);
		if(overlapResult != null) {
			// 해당 카테고리의 show를 o로 변경
			int showResult = cDao.showCategory(categoryVO);
			if(showResult == 1) {
				return "success";
			} else {
				return "fail";
			}
		} else {
			int inResult = cDao.insertCategory(categoryVO);
			if(inResult == 1) {
				return "success";
			} else {
				return "fail";
			}
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
		try {
			int result = cDao.deleteCategory(categoryVO);
			if(result == 1) {
				return "success";
			} else {
				return "fail";
			}
		} catch (DataIntegrityViolationException e) { // 외래키 연관되어 있는 경우, 숨김으로 처리
			int result = cDao.hideCategory(categoryVO);
			if(result == 1) {
				return "success";
			} else {
				return "fail";
			}
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
	
	// 카테고리 초기화
	@ResponseBody
	@RequestMapping("account/resetCate")
	public void resetCategory(CategoryVO categoryVO) {
		try {
			int result = cDao.deleteAllCategory(categoryVO);
			if(result > 0) {
				if(categoryVO.getMoneytype().equals("수입")) {
					insertCateSvc.insertInCategory(categoryVO);
				} else {
					insertCateSvc.insertOutCategory(categoryVO);
				}
			}
		} catch (DataIntegrityViolationException e) { // 외래키 연관되어 있는 경우, 숨김으로 처리
			int result = cDao.hideAllCategory(categoryVO);
			if(result > 0) {
				if(categoryVO.getMoneytype().equals("수입")) {
					insertCateSvc.insertInCategory(categoryVO);
				} else {
					insertCateSvc.insertOutCategory(categoryVO);
				}
			}
		}
	}
}
