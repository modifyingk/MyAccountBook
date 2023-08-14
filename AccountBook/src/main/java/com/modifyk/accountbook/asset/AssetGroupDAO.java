package com.modifyk.accountbook.asset;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AssetGroupDAO {
	@Autowired
	SqlSessionTemplate my;
	
	// 자산 그룹 삽입
	public int insertGroup(AssetGroupVO astgroupVO) {
		return my.insert("assetgroupMapper.insertGroup", astgroupVO);
	}
	
	// 자산 그룹 list
	public List<String> astGroupInfo(String userid) {
		return my.selectList("assetgroupMapper.astGroupInfo", userid);
	}
	
	// 자산 그룹 수정
	public int updateGroup(HashMap<String, Object> map) {
		return my.update("assetgroupMapper.updateGroup", map);
	}
	
	// 자산 그룹 삭제
	public int deleteGroup(AssetGroupVO astgroupVO) {
		return my.delete("assetgroupMapper.deleteGroup", astgroupVO);
	}
	
	// 자산 그룹 중복 확인
	public String isOverlapGroup(AssetGroupVO astgroupVO) {
		return my.selectOne("assetgroupMapper.isOverlapGroup", astgroupVO);
	}
}
