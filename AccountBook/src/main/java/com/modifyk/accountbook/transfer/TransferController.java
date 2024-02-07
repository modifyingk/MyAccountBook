package com.modifyk.accountbook.transfer;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modifyk.accountbook.asset.AssetDAO;

@Controller
public class TransferController {
	
	@Autowired
	TransferDAO tDao;
	
	@Autowired
	AssetDAO aDao;
	
	@Autowired
	TransferAssetService assetSvc;
	
	@Autowired
	TransferToMapService toMapSvc;
	
	// 이체 추가
	@ResponseBody
	@RequestMapping("transfer/insertTransfer")
	public boolean insertTransfer(TransferVO transferVO) {
		System.out.println(transferVO);
		int result = tDao.insertTransfer(transferVO);
		System.out.println(result);
		if(result > 0) {
			assetSvc.updateAsset(transferVO);
			return true;
		} else {
			return false;
		}
	}
	
	// 월별 이체 내역
	@ResponseBody
	@RequestMapping("transfer/transferList")
	public HashMap<String, List<TransferVO>> transferList(TransferVO transferVO) {
		List<TransferVO> transferList = tDao.transferList(transferVO);
		HashMap<String, List<TransferVO>> map = toMapSvc.toMap(transferList);
		return map;
	}
	
	// 이체 수정
	@ResponseBody
	@RequestMapping("transfer/updateTransfer")
	public boolean updateTransfer(TransferVO transferVO) {
		TransferVO beforeRes = tDao.checkTransfer(transferVO); // 수정하기 전 내역
		int result = tDao.updateTransfer(transferVO);
		if(result > 0) {
			assetSvc.updateAsset(beforeRes, transferVO);
			return true;
		} else {
			return false;
		}
	}
	
	// 이체 삭제
	@ResponseBody
	@RequestMapping("transfer/deleteTransfer")
	public boolean deleteTransfer(TransferVO transferVO) {
		TransferVO beforeRes = tDao.checkTransfer(transferVO); // 수정하기 전 내역
		int result = tDao.deleteTransfer(transferVO);
		if(result > 0) {
			transferVO.setWithdrawid(beforeRes.getWithdrawid());
			transferVO.setDepositid(beforeRes.getDepositid());
			transferVO.setTotal(beforeRes.getTotal() * (-1));
			assetSvc.updateAsset(transferVO);
			return true;
		} else {
			return false;
		}
	}
}
