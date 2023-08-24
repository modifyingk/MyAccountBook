package com.modifyk.accountbook.account;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AccountController {
	
	@Autowired
	AccountDAO aDao;
	
	@Autowired
	MakeAccountIDService actIDSvc;
	
	@Autowired
	AccountToMapService toMapSvc;
	
	// 수입/지출 추가
	@ResponseBody
	@RequestMapping("account/insertAccount")
	public String insertAccount(AccountVO accountVO) {
        
		// 수입/지출 아이디(분류코드) 생성
		String accountid = actIDSvc.makeAccountID(accountVO.getMoneytype());
		accountVO.setAccountid(accountid);
		
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
	public HashMap<String, Object> accountInfo(String userid) {
		List<AccountVO> accountList = aDao.accountInfo(userid);
		HashMap<String, Object> map = toMapSvc.toMap(accountList);
		return map;
	}
	
	// 수입/지출 수정
	@ResponseBody
	@RequestMapping("account/updateAccount")
	public String updateAccount(AccountVO accountVO) {
		System.out.println(accountVO);
		int result = aDao.updateAccount(accountVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
}
