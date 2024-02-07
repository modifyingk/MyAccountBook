package com.modifyk.accountbook.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modifyk.accountbook.account.CategoryDAO;
import com.modifyk.accountbook.account.CategoryVO;
import com.modifyk.accountbook.asset.AssetDAO;
import com.modifyk.accountbook.asset.AssetVO;

@Service
public class AutoInsertService {
	@Autowired
	AssetDAO aDao;
	
	@Autowired
	CategoryDAO cDao;
	
	// asset 기본값 삽입
	public void insertAsset(AssetVO assetVO) {
		assetVO.setAssetgroup("현금");
		assetVO.setAssetname("현금");
		assetVO.setTotal(0);
		aDao.insertAsset(assetVO);
	}
	
	// 수입 category 기본값 삽입
	public void insertInCategory(CategoryVO categoryVO) {
		String[] inVal = {"월급", "부수입", "용돈", "기타"};
		
		for(int i = 0; i < inVal.length; i++) {
			categoryVO.setMoneytype("수입");
			categoryVO.setCatename(inVal[i]);
			cDao.insertCategory(categoryVO);
		}
	}
	
	// 지출 category 기본값 삽입
	public void insertOutCategory(CategoryVO categoryVO) {
		String[] outVal = {"식비", "생활용품", "교통", "문화생활", "주거/통신", "마트/편의점", "패션/미용", "교육", "선물", "건강", "기타"};
		
		for(int i = 0; i < outVal.length; i++) {
			categoryVO.setMoneytype("지출");
			categoryVO.setCatename(outVal[i]);
			cDao.insertCategory(categoryVO);
		}
	}
}
