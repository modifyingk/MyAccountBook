package com.modifyk.accountbook.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modifyk.accountbook.asset.AssetDAO;
import com.modifyk.accountbook.asset.AssetGroupDAO;
import com.modifyk.accountbook.asset.AssetGroupVO;

@Service
public class InsertAstGroupService {
	
	@Autowired
	AssetGroupDAO agDao;
	
	// assetgroup 기본값 삽입
	public void insertGroup(AssetGroupVO astgroupVO) {
		String[] val = {"대출", "마이너스 통장", "보험", "선불식카드", "은행", "저축", "체크카드", "카드", "투자", "현금", "기타"};
		for(int i = 0; i < val.length; i++) {
			astgroupVO.setAstgroup(val[i]);
			agDao.insertGroup(astgroupVO);
		}
	}
}
