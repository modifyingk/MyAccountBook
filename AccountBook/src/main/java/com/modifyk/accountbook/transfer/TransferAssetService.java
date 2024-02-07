package com.modifyk.accountbook.transfer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modifyk.accountbook.asset.AssetDAO;
import com.modifyk.accountbook.asset.AssetVO;

@Service
public class TransferAssetService {
	@Autowired
	AssetDAO aDao;
	
	public void updateAsset(TransferVO transfer) {
		AssetVO assetVO = new AssetVO();
		
		// 입금 자산
		assetVO.setAssetid(transfer.getDepositid());
		assetVO.setTotal(transfer.getTotal());
		assetVO.setUserid(transfer.getUserid());
		aDao.updateTotal(assetVO);
		
		// 출금 자산
		assetVO.setAssetid(transfer.getWithdrawid());
		assetVO.setTotal(transfer.getTotal() * (-1));
		aDao.updateTotal(assetVO);
	}
	
	public void updateAsset(TransferVO before, TransferVO after) {
		int beforeMoney = before.getTotal();
		int withdrawid = before.getWithdrawid();
		int depositid = before.getDepositid();
		
		int afterMoney = after.getTotal();
		
		AssetVO assetVO = new AssetVO();
		assetVO.setUserid(after.getUserid());
		
		int updateValue = afterMoney - beforeMoney;
		if(updateValue < 0) {
			// 출금 자산
			assetVO.setAssetid(withdrawid);
			assetVO.setTotal(updateValue);
			aDao.updateTotal(assetVO);
			
			// 입금 자산
			assetVO.setAssetid(depositid);
			assetVO.setTotal(updateValue * (-1));
			aDao.updateTotal(assetVO);
		} else if(updateValue > 0) {
			// 입금 자산
			assetVO.setAssetid(depositid);
			assetVO.setTotal(updateValue);
			aDao.updateTotal(assetVO);
						
			// 출금 자산
			assetVO.setAssetid(withdrawid);
			assetVO.setTotal(updateValue * (-1));
			aDao.updateTotal(assetVO);
		}
	}
}
