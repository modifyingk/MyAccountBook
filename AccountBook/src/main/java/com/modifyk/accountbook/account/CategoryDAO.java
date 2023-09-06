package com.modifyk.accountbook.account;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CategoryDAO {

	@Autowired
	SqlSessionTemplate my;
	
	// 카테고리 추가
	public int insertCategory(CategoryVO categoryVO) {
		return my.insert("categoryMapper.insertCategory", categoryVO);
	}

	// 카테고리 수정
	public int updateCategory(HashMap<String, Object> map) {
		return my.update("categoryMapper.updateCategory", map);
	}
	
	// 카테고리 삭제
	public int deleteCategory(CategoryVO categoryVO) {
		return my.delete("categoryMapper.deleteCategory", categoryVO);
	}
	
	// 카테고리 숨김
	public int hideCategory(CategoryVO categoryVO) {
		return my.update("categoryMapper.hideCategory", categoryVO);
	}
	
	// 카테고리 전체 삭제
	public int deleteAllCategory(CategoryVO categoryVO) {
		return my.delete("categoryMapper.deleteAllCategory", categoryVO);
	}
	
	// 카테고리 전체 숨김
	public int hideAllCategory(CategoryVO categoryVO) {
		return my.update("categoryMapper.hideAllCategory", categoryVO);
	}
	
	// 카테고리 list
	public List<CategoryVO> CategoryInfo(CategoryVO categoryVO) {
		return my.selectList("categoryMapper.categoryInfo", categoryVO);
	}
	
	// 카테고리 중복 검사
	public String isOverlapCate(CategoryVO categoryVO) {
		return my.selectOne("categoryMapper.isOverlapCate", categoryVO);
	}
	
	// 숨겨진 카테고리 중복 검사
	public String isOverlapHideCate(CategoryVO categoryVO) {
		return my.selectOne("categoryMapper.isOverlapHideCate", categoryVO);
	}
	
	// 카테고리 숨김 취소
	public int showCategory(CategoryVO categoryVO) {
		return my.update("categoryMapper.showCategory", categoryVO);
	}
}
