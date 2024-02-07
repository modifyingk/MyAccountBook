package com.modifyk.accountbook.account;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modifyk.accountbook.asset.AssetDAO;
import com.modifyk.accountbook.asset.AssetVO;

@Service
public class AssetService {
	@Autowired
	AssetDAO aDao;
	
	public void updateAsset(AccountVO account) {
		AssetVO assetVO = new AssetVO();
		
		assetVO.setAssetid(account.getAssetid()); // 업데이트 할 자산 id
		assetVO.setUserid(account.getUserid()); // 업데이트 할 user
		
		// 업데이트 할 금액
		if(account.getMoneytype().equals("지출")) { // 지출이면 음수로 설정
			assetVO.setTotal(account.getTotal() * (-1));
		} else if(account.getMoneytype().equals("수입")) {
			assetVO.setTotal(account.getTotal());
		}
		
		aDao.updateTotal(assetVO);
	}
	
	public void updateAsset(AccountVO before, AccountVO after) {
		int beforeMoney = before.getTotal();
		int beforeAsset = before.getAssetid();
		int afterMoney = after.getTotal();
		int afterAsset = after.getAssetid();
		
		AssetVO assetVO = new AssetVO();
		assetVO.setUserid(after.getUserid());
		
		if(beforeAsset != afterAsset) {
			if(after.getMoneytype().equals("지출")) {
				assetVO.setAssetid(beforeAsset);
				assetVO.setTotal(beforeMoney);
				aDao.updateTotal(assetVO);
				
				assetVO.setAssetid(afterAsset);
				assetVO.setTotal(afterMoney * (-1));
				aDao.updateTotal(assetVO);
			} else if(after.getMoneytype().equals("수입")) {
				assetVO.setAssetid(beforeAsset);
				assetVO.setTotal(beforeMoney * (-1));
				aDao.updateTotal(assetVO);
				
				assetVO.setAssetid(afterAsset);
				assetVO.setTotal(afterMoney);
				aDao.updateTotal(assetVO);
			}
		} else {
			int updateValue = afterMoney - beforeMoney;
			assetVO.setAssetid(afterAsset);
			if(after.getMoneytype().equals("지출")) {
				assetVO.setTotal(updateValue * (-1));
			} else if(after.getMoneytype().equals("수입")) {
				assetVO.setTotal(updateValue);
			}
			aDao.updateTotal(assetVO);
		}
		
	}
}
