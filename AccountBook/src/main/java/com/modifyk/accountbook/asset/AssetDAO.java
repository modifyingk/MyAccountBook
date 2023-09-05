package com.modifyk.accountbook.asset;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.modifyk.accountbook.account.AccountVO;

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
	
	// 자산 추가
	public int insertAsset(AssetVO assetVO) {
		return my.insert("assetMapper.insertAsset", assetVO);
	}
	
	// 자산 삭제
	public int deleteAsset(AssetVO assetVO) {
		return my.delete("assetMapper.deleteAsset", assetVO);
	}
	
	// 자산별 지출 합계
	public List<AccountVO> assetTotal(String userid) {
		return my.selectList("accountMapper.assetTotal", userid);
	}
}
