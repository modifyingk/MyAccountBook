package com.modifyk.accountbook.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modifyk.accountbook.asset.AssetDAO;
import com.modifyk.accountbook.asset.AssetGroupDAO;
import com.modifyk.accountbook.asset.AssetGroupVO;
import com.modifyk.accountbook.asset.AssetVO;

@Service
public class InsertAssetService {
	
	@Autowired
	AssetGroupDAO agDao;
	
	@Autowired
	AssetDAO aDao;
	
	// asset 기본값 삽입
	public void insertAsset(AssetVO assetVO) {
		assetVO.setAstname("현금");
		assetVO.setAstgroup("현금");
		aDao.insertAsset(assetVO);
	}
}
