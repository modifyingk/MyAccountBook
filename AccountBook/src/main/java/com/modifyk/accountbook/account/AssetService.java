package com.modifyk.accountbook.account;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modifyk.accountbook.asset.AssetDAO;
import com.modifyk.accountbook.asset.AssetVO;

@Service
public class AssetService {
	@Autowired
	AssetDAO aDao;
	
	// 수입/지출 추가 또는 삭제 시 자산 금액 업데이트
	public void updateAsset(AccountVO accountVO) {
		AssetVO assetVO = new AssetVO();
		assetVO.setAssetname(accountVO.getAssetname()); // 업데이트 할 자산명
		assetVO.setTotal(accountVO.getTotal()); // 업데이트 할 값
		assetVO.setUserid(accountVO.getUserid()); // 업데이트 할 유저
		
		aDao.updateTotal(assetVO); // 자산 금액 업데이트
	}
	
	// 수입/지출 수정 시 자산 금액 업데이트
	public void updateAsset(AccountVO before, AccountVO after) {
		int beforeMoney = before.getTotal(); // 수정 전
		String beforeAsset = before.getAssetname();
		
		int afterMoney = after.getTotal(); // 수정 후
		String afterAsset = after.getAssetname();
		
		AssetVO assetVO = new AssetVO();
		assetVO.setUserid(after.getUserid());
		
		if(beforeAsset != afterAsset) { // 자산이 변경된 경우
			assetVO.setAssetname(beforeAsset); // 원래 자산의 금액 복구
			assetVO.setTotal(beforeMoney * -1);
			aDao.updateTotal(assetVO);
				
			assetVO.setAssetname(afterAsset); // 변경한 자산의 값 업데이트
			assetVO.setTotal(afterMoney);
			aDao.updateTotal(assetVO);
			
		} else { // 자산이 변경되지 않은 경우
			int updateValue = afterMoney - beforeMoney; // 변경된 금액만 자산 금액에 업데이트
			assetVO.setAssetname(afterAsset);
			assetVO.setTotal(updateValue);
			aDao.updateTotal(assetVO);
		}
		
	}
}
