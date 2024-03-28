package com.modifyk.accountbook.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modifyk.accountbook.asset.AssetDAO;
import com.modifyk.accountbook.asset.AssetVO;

@Service
public class AutoInsertService {
	@Autowired
	AssetDAO aDao;

	public void autoInsert(String userid) {
		insertAsset(userid);
	}
	
	// asset 기본값 삽입
	public void insertAsset(String userid) {
		AssetVO assetVO = new AssetVO();
		assetVO.setUserid(userid);
		assetVO.setAssetgroup("현금");
		assetVO.setAssetname("현금");
		assetVO.setTotal(0);
		aDao.insertAsset(assetVO);
	}
}
