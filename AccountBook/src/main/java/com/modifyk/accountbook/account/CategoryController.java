package com.modifyk.accountbook.account;

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
	public boolean insertCategory(CategoryVO categoryVO) {
		int result =  cDao.insertCategory(categoryVO);
		if(result > 0)
			return true;
		else
			return false;
	}
		
	// 카테고리 수정
	@ResponseBody
	@RequestMapping("account/updateCategory")
	public boolean updateCategory(CategoryVO categoryVO) {
		int result = cDao.updateCategory(categoryVO);
		if(result > 0) {
			return true;
		} else {
			return false;
		}
	}
		
	// 카테고리 삭제
	@ResponseBody
	@RequestMapping("account/deleteCategory")
	public boolean deleteCategory(CategoryVO categoryVO) {
		int result = cDao.deleteCategory(categoryVO);
		if(result > 0)
			return true;
		else
			return false;
	}

	// 카테고리 목록
	@ResponseBody
	@RequestMapping("account/categoryList")
	public List<CategoryVO> categoryList(CategoryVO categoryVO) {
		List<CategoryVO> list = cDao.categoryList(categoryVO);
		return list;
	}
	
	// 카테고리 중복 검사
	@ResponseBody
	@RequestMapping("account/overlapCategory")
	public boolean isOverlapCate(CategoryVO categoryVO) {
		String result = cDao.overlapCategory(categoryVO);
		if(result != null) {
			return false;
		} else {
			return true;
		}
	}
}
