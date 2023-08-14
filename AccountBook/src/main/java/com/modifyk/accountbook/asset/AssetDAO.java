package com.modifyk.accountbook.asset;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AssetDAO {
	@Autowired
	SqlSessionTemplate my;
	
	// 자산 list
	public List<AssetVO> assetInfo(String userid) {
		return my.selectList("assetMapper.assetInfo", userid);
	}
}
