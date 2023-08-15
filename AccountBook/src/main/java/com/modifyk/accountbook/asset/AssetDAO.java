package com.modifyk.accountbook.asset;

import java.util.HashMap;
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
	
	// 자산 수정
	public int updateAsset(HashMap<String, Object> map) {
		return my.update("assetMapper.updateAsset", map);
	}
	
	// 자산 중복 확인
	public String isOverlapAsset(AssetVO assetVO) {
		return my.selectOne("assetMapper.isOverlapAsset", assetVO);
	}
}
