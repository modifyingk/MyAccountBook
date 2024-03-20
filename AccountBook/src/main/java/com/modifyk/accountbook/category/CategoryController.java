package com.modifyk.accountbook.category;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CategoryController {
	
	@Autowired
	CategoryDAO cDao;

	@Autowired
	CategoryToMapService toMapSvc;
	
	// 수입 소분류 목록
	@RequestMapping("category/selectIncategory")
	public void incategoryList(String userid, Model model) {
		List<CategoryVO> list = cDao.incategoryList(userid);
		HashMap<String, List<CategoryVO>> map = toMapSvc.categoryToMap(list);
		model.addAttribute("map", map);
	}
	
	// 지출 소분류 목록
	@RequestMapping("category/selectOutcategory")
	public void outcategoryList(String userid, Model model) {
		List<CategoryVO> list = cDao.outcategoryList(userid);
		HashMap<String, List<CategoryVO>> map = toMapSvc.categoryToMap(list);
		model.addAttribute("map", map);
	}
	
	// 카테고리 중복 확인
	@ResponseBody
	@RequestMapping("category/overlapCategory")
	public boolean overlapCategory(CategoryVO categoryVO, String mtype) {
		String result;
		if(mtype.equals("수입")) {
			result = cDao.overlapIncate(categoryVO);
		} else {
			result = cDao.overlapOutcate(categoryVO);
		}
		if(result != null)
			return false;
		else
			return true;
	}
	
	// 카테고리 추가
	@ResponseBody
	@RequestMapping("category/insertCategory")
	public int insertCategory(CategoryVO categoryVO, String mtype) {
		int result;
		if(mtype.equals("수입")) {
			result = cDao.insertIncate(categoryVO);
		} else {
			result = cDao.insertOutcate(categoryVO);
		}
		if(result > 0)
			return categoryVO.getCategoryid();
		else
			return -1;
	}

	// 카테고리 수정
	@ResponseBody
	@RequestMapping("category/updateCategory")
	public boolean updateCategory(CategoryVO categoryVO, String mtype) {
		int result;
		if(mtype.equals("수입")) {
			result = cDao.updateIncate(categoryVO);
		} else {
			result = cDao.updateOutcate(categoryVO);
		}
		if(result > 0)
			return true;
		else
			return false;
	}
	
	// 카테고리삭제
	@ResponseBody
	@RequestMapping("category/deleteCategory")
	public boolean deleteCategory(CategoryVO categoryVO, String mtype) {
		int result;
		if(mtype.equals("수입")) {
			result = cDao.deleteIncate(categoryVO);
		} else {
			result = cDao.deleteOutcate(categoryVO);
		}
		if(result > 0)
			return true;
		else
			return false;
	}
	
	// 특정 수입 대분류의 소분류 목록
	@ResponseBody
	@RequestMapping("category/smallcateList")
	public List<String> smallcateList(CategoryVO categoryVO, String mtype) {
		List<String> list = new ArrayList<String>();
		if(mtype.equals("수입")) {
			list = cDao.inSmallcateList(categoryVO);
		} else {
			list = cDao.outSmallcateList(categoryVO);
		}
		return list;
	}
}
