package com.modifyk.accountbook.asset;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modifyk.accountbook.account.AccountDAO;
import com.modifyk.accountbook.account.AccountVO;
import com.modifyk.accountbook.account.MakeAccountIDService;

@Service
public class AutoInsertAccountService {
	
	@Autowired
	MakeAccountIDService makeIdSvc;

	@Autowired
	AccountDAO actDao;
	
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
		
		String accountid = makeIdSvc.makeAccountID(account.getMoneytype());
		
		account.setAccountid(accountid);
		account.setAstname(assetVO.getAstname());
		account.setCatename("기타");
		account.setDate(now);
		account.setTotal(Math.abs(assetVO.getTotal()));
		account.setUserid(assetVO.getUserid());
		account.setContent("차액");
		account.setMemo("");
		
		actDao.insertAccount(account);
	}
}
