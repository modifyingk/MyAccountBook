package com.modifyk.accountbook.asset;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modifyk.accountbook.account.AccountDAO;
import com.modifyk.accountbook.account.AccountVO;

@Service
public class AccountService {
	
	@Autowired
	AccountDAO aDao;
	
	public int insertAccount(AssetVO assetVO) {
		// 가계부 탭에 기록
		AccountVO account = new AccountVO();
		
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		String now = fmt.format(date);
		
		if(assetVO.getTotal() > 0) {
			account.setMoneytype("수입");
		} else if(assetVO.getTotal() < 0) {
			account.setMoneytype("지출");
		}
		
		account.setDate(now);
		account.setAssetname(assetVO.getAssetname());
		account.setTotal(assetVO.getTotal());
		account.setBigcate("차액");
		account.setContent("");
		account.setUserid(assetVO.getUserid());
		
		return aDao.insertAccount2(account);
	}
	
}
