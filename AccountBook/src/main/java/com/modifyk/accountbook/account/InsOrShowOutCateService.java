package com.modifyk.accountbook.account;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InsOrShowOutCateService {
	
	@Autowired
	CategoryDAO cDao;
	
	public void insertCategory(CategoryVO categoryVO) {
		String[] outVal = {"식비", "생활용품", "교통", "문화생활", "주거/통신", "마트/편의점", "패션/미용", "교육", "선물", "건강", "기타"};

		for(int i = 0; i < outVal.length; i++) {
			categoryVO.setMoneytype("지출");
			categoryVO.setCatename(outVal[i]);
			
			String overlapResult = cDao.isOverlapHideCate(categoryVO);
			if(overlapResult != null) {
				cDao.showCategory(categoryVO);
				
			} else {
				cDao.insertCategory(categoryVO);
				
			}
		}
	}
}
