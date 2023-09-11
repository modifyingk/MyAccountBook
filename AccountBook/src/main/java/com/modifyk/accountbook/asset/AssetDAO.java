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
	
	// 자산 숨김
	public int hideAsset(AssetVO assetVO) {
		return my.delete("assetMapper.hideAsset", assetVO);
	}
	
	// 카테고리 전체 삭제
	public int deleteAllAsset(AssetVO assetVO) {
		return my.delete("assetMapper.deleteAllAsset", assetVO);
	}
		
	// 카테고리 전체 숨김
	public int hideAllAsset(AssetVO assetVO) {
		return my.update("assetMapper.hideAllAsset", assetVO);
	}
	
	// 자산별 지출 합계
	public List<AccountVO> assetAccount(AccountVO accountVO) {
		return my.selectList("accountMapper.assetAccount", accountVO);
	}
	
	// 숨겨진 자산 중복 검사
	public String isOverlapHideAsset(AssetVO assetVO) {
		return my.selectOne("assetMapper.isOverlapHideAsset", assetVO);
	}
		
	// 자산 숨김 취소
	public int showAsset(AssetVO assetVO) {
		return my.update("assetMapper.showAsset", assetVO);
	}
	
	// 자산 금액 업데이트(지출)
	public int minusTotal(AssetVO assetVO) {
		return my.update("assetMapper.minusTotal", assetVO);
	}
	
	// 자산 금액 업데이트(수입)
	public int plusTotal(AssetVO assetVO) {
		return my.update("assetMapper.plusTotal", assetVO);
	}
}
