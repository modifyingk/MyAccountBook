package com.modifyk.accountbook.account;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InsOrShowInCateService {
	
	@Autowired
	CategoryDAO cDao;
	
	public void insertCategory(CategoryVO categoryVO) {
		String[] inVal = {"월급", "부수입", "용돈", "기타"};
		
		for(int i = 0; i < inVal.length; i++) {
			categoryVO.setMoneytype("수입");
			categoryVO.setCatename(inVal[i]);
			
			String overlapResult = cDao.isOverlapHideCate(categoryVO);
			if(overlapResult != null) {
				cDao.showCategory(categoryVO);
			} else {
				cDao.insertCategory(categoryVO);
			}
		}
	}
}
