package com.modifyk.accountbook.asset;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AssetController {
	
	@Autowired
	AssetDAO aDao;
	
	@Autowired
	AssetToMapService toMapSvc;
	
	@Autowired
	AccountService accountSvc;
	
	// 자산 중복 확인
	@ResponseBody
	@RequestMapping("asset/overlapAsset")
	public boolean overlapAsset(AssetVO assetVO) {
		String result = aDao.overlapAsset(assetVO);
		if(result != null) {
			return false;
		} else {
			return true;
		}
	}
	
	// 자산 추가
	@ResponseBody
	@RequestMapping("asset/insertAsset")
	public boolean insertAsset(AssetVO assetVO) {
		if(assetVO.getMemo() == null) assetVO.setMemo(""); // 메모 null이면 공백 채우기
		int assetRes = aDao.insertAsset(assetVO);
		if(assetRes > 0) {
			if(assetVO.getTotal() != 0) { // 입력된 자산의 금액이 0이 아니라면 증가/감소된 금액만큼 수입/지출에 기록
				accountSvc.insertAccount(assetVO);
			}
			return true;
		} else {
			return false;
		}
	}

	// 자산 수정
	@ResponseBody
	@RequestMapping("asset/updateAsset")
	public boolean updateAsset(AssetVO assetVO) {
		System.out.println(assetVO);
		int beforeTotal = aDao.beforeAsset(assetVO); // 업데이트 전 금액
		int afterTotal = assetVO.getTotal(); // 업데이트 후 금액
		int updateVal = afterTotal - beforeTotal; // 차이
		System.out.println(beforeTotal);
		System.out.println(afterTotal);
		
		int assetRes = aDao.updateAsset(assetVO);
		if(assetRes > 0) { // 자산 수정 성공 시
			// 자산 금액 변경되었다면 증가/감소된 금액만큼 수입/지출에 기록
			if(updateVal != 0) {
				assetVO.setTotal(updateVal);
				accountSvc.insertAccount(assetVO);
			}
			return true;
		} else {
			return false;
		}
	}
	
	// 자산 삭제
	@ResponseBody
	@RequestMapping("asset/deleteAsset")
	public int deleteAsset(AssetVO assetVO) {
		int result = aDao.deleteAsset(assetVO);
		return result;
	
	}
	
	// 자산 목록
	@RequestMapping("asset/selectAsset")
	public void selectAsset(String userid, Model model) {
		List<AssetVO> list = aDao.selectAsset(userid);
		HashMap<String, List<AssetVO>> map = toMapSvc.toMap(list);
		model.addAttribute("map", map);
	}
	
	// 자산 이름 목록
	@RequestMapping("asset/selectAssetName")
	public void selectAssetName(String userid, Model model) {
		List<String> list = aDao.selectAssetName(userid);
		model.addAttribute("list", list);
	}
}
