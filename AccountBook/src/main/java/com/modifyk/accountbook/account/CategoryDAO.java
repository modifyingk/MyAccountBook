package com.modifyk.accountbook.account;

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
	public int updateCategory(CategoryVO categoryVO) {
		return my.update("categoryMapper.updateCategory", categoryVO);
	}
	
	// 카테고리 삭제
	public int deleteCategory(CategoryVO categoryVO) {
		return my.delete("categoryMapper.deleteCategory", categoryVO);
	}

	// 카테고리 목록
	public List<CategoryVO> categoryList(CategoryVO categoryVO) {
		return my.selectList("categoryMapper.categoryList", categoryVO);
	}
	
	// 카테고리 중복 검사
	public String overlapCategory(CategoryVO categoryVO) {
		return my.selectOne("categoryMapper.overlapCategory", categoryVO);
	}
}
