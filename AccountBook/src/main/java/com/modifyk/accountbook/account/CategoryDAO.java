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
	
	// 카테고리 list
	public List<CategoryVO> CategoryInfo(CategoryVO categoryVO) {
		return my.selectList("categoryMapper.CategoryInfo", categoryVO);
	}
}
