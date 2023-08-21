package com.modifyk.accountbook.account;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AccountController {
	
	@Autowired
	AccountDAO aDao;
	
	// 수입/지출 추가
	@ResponseBody
	@RequestMapping("account/insertAccount")
	public String insertAccount(AccountVO accountVO) {
		// 아이디 생성
		String accountid = "";
		String mt = accountVO.getMoneytype();
		if(mt.equals("수입")) {
			accountid += "P";
		} else {
			accountid += "M";
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
        Date date = new Date();
        String now = sdf.format(date);
        accountid += now;
        
		System.out.println(accountid);
		accountVO.setAccountid(accountid);
		
		System.out.println(accountVO);
		
		int result = aDao.insertAccount(accountVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 수입/지출 목록
	@ResponseBody
	@RequestMapping("account/accountInfo")
	public List<AccountVO> accountInfo(String userid) {
		List<AccountVO> accountList = aDao.accountInfo(userid);
		return accountList;
	}
}
