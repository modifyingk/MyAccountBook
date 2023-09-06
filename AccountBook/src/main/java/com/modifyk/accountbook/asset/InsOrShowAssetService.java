package com.modifyk.accountbook.asset;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InsOrShowAssetService {
	
	@Autowired
	AssetDAO aDao;
	
	public void insertAsset(AssetVO assetVO) {
		assetVO.setAstname("현금");
		assetVO.setAstgroup("현금");
			
		String overlapResult = aDao.isOverlapHideAsset(assetVO);
		if(overlapResult != null) {
			aDao.showAsset(assetVO);
		} else {
			aDao.insertAsset(assetVO);
		}
	}
}
