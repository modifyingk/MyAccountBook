package com.modifyk.accountbook.asset;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modifyk.accountbook.account.AccountDAO;
import com.modifyk.accountbook.account.AccountVO;

@Service
public class AutoInsertActAstService {
	
	@Autowired
	AccountDAO actDao;

	@Autowired
	AssetDAO aDao;
	
	public void insertAccount(AssetVO assetVO) {
		// 가계부 탭에 기록
		AccountVO account = new AccountVO();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String now = sdf.format(date);
		
		if(assetVO.getTotal() > 0) {
			account.setMoneytype("수입");
		} else {
			account.setMoneytype("지출");
		}
		
		account.setAstname(assetVO.getAstname());
		account.setCatename("기타");
		account.setDate(now);
		account.setTotal(Math.abs(assetVO.getTotal()));
		account.setUserid(assetVO.getUserid());
		account.setContent("차액");
		account.setMemo("");
		
		actDao.insertAccount(account);
	}
	
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
