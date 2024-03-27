package com.modifyk.accountbook.asset;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AssetDAO {
	@Autowired
	SqlSessionTemplate my;
	
	// 자산 중복 확인
	public String overlapAsset(AssetVO assetVO) {
		return my.selectOne("assetMapper.overlapAsset", assetVO);
	}
	
	// 자산 추가
	public int insertAsset(AssetVO assetVO) {
		return my.insert("assetMapper.insertAsset", assetVO);
	}

	// 업데이트 전 자산 금액
	public int beforeAsset(AssetVO assetVO) {
		return my.selectOne("assetMapper.beforeAsset", assetVO);
	}
	
	// 자산 수정
	public int updateAsset(AssetVO assetVO) {
		return my.update("assetMapper.updateAsset", assetVO);
	}
	
	// 자산 삭제
	public int deleteAsset(AssetVO assetVO) {
		return my.delete("assetMapper.deleteAsset", assetVO);
	}
	
	// 자산 목록
	public List<AssetVO> selectAsset(String userid) {
		return my.selectList("assetMapper.selectAsset", userid);
	}
	
	// 자산 목록
	public List<String> selectAssetName(String userid) {
		return my.selectList("assetMapper.selectAssetName", userid);
	}
	/*
	// 자산 활성화/비활성화
	public int activeAsset(AssetVO assetVO) {
		return my.update("assetMapper.activeAsset", assetVO);
	}
	*/
	// 자산 금액 업데이트
	public int updateTotal(AssetVO assetVO) {
		return my.update("assetMapper.updateTotal", assetVO);
	}
	
}
