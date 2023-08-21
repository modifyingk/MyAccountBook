package com.modifyk.accountbook.account;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AccountDAO {

	@Autowired
	SqlSessionTemplate my;
	
	// 수입/지출 추가
	public int insertAccount(AccountVO accountVO) {
		return my.insert("accountMapper.insertAccount", accountVO);
	}
	
	// 수입/지출 목록
	public List<AccountVO> accountInfo(String userid) {
		return my.selectList("accountMapper.accountInfo", userid);
	}
}
