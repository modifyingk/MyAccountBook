package com.modifyk.accountbook.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modifyk.accountbook.account.CategoryDAO;
import com.modifyk.accountbook.account.CategoryVO;

@Service
public class InsertInCategoryService {
	
	@Autowired
	CategoryDAO cDao;
	
	// category 기본값 삽입
	public void insertCategory(CategoryVO categoryVO) {
		String[] inVal = {"월급", "부수입", "용돈", "기타"};
		
		for(int i = 0; i < inVal.length; i++) {
			categoryVO.setMoneytype("수입");
			categoryVO.setCatename(inVal[i]);
			cDao.insertCategory(categoryVO);
		}
	}
}
