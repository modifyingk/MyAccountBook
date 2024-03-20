package com.modifyk.accountbook.category;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CategoryDAO {

	@Autowired
	SqlSessionTemplate my;

	// 수입 소분류 목록
	public List<CategoryVO> incategoryList(String userid) {
		return my.selectList("categoryMapper.incategoryList", userid);
	}
	
	// 지출 소분류 목록
	public List<CategoryVO> outcategoryList(String userid) {
		return my.selectList("categoryMapper.outcategoryList", userid);
	}
	
	// 수입 소분류 중복 확인
	public String overlapIncate(CategoryVO categoryVO) {
		return my.selectOne("categoryMapper.overlapIncate", categoryVO);
	}
	
	// 지출 소분류 중복 확인
	public String overlapOutcate(CategoryVO categoryVO) {
		return my.selectOne("categoryMapper.overlapOutcate", categoryVO);
	}
	
	// 수입 소분류 추가
	public int insertIncate(CategoryVO categoryVO) {
		return my.insert("categoryMapper.insertIncate", categoryVO);
	}
	
	// 지출 소분류 추가
	public int insertOutcate(CategoryVO categoryVO) {
		return my.insert("categoryMapper.insertOutcate", categoryVO);
	}
	
	// 수입 소분류 수정
	public int updateIncate(CategoryVO categoryVO) {
		return my.update("categoryMapper.updateIncate", categoryVO);
	}
	
	// 지출 소분류 수정
	public int updateOutcate(CategoryVO categoryVO) {
		return my.update("categoryMapper.updateOutcate", categoryVO);
	}
	
	// 수입 소분류 삭제
	public int deleteIncate(CategoryVO categoryVO) {
		return my.delete("categoryMapper.deleteIncate", categoryVO);
	}

	// 지출 소분류 삭제
	public int deleteOutcate(CategoryVO categoryVO) {
		return my.delete("categoryMapper.deleteOutcate", categoryVO);
	}
	
	// 특정 수입 대분류의 소분류 목록
	public List<String> inSmallcateList(CategoryVO categoryVO) {
		return my.selectList("categoryMapper.inSmallcateList", categoryVO);
	}
	
	// 특정 지출 대분류의 소분류 목록
	public List<String> outSmallcateList(CategoryVO categoryVO) {
		return my.selectList("categoryMapper.outSmallcateList", categoryVO);
	}
}
