package com.modifyk.accountbook.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modifyk.accountbook.asset.AssetDAO;
import com.modifyk.accountbook.asset.AssetVO;

@Service
public class AutoInsertService {
	@Autowired
	AssetDAO aDao;
	
	@Autowired
	MemberDAO mDao;
	
	public void autoInsert(String userid) {
		insertAsset(userid);
		insertPoint(userid);
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
	
	// 포인트 기본값 삽입
	public void insertPoint(String userid) {
		MoneyVO moneyVO = new MoneyVO();
		moneyVO.setUserid(userid);
		moneyVO.setUserpoint(0);
		moneyVO.setPlantstep(0);
		moneyVO.setUsercash(0);
		mDao.insertMoney(moneyVO);
				
	}
}
