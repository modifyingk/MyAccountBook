package com.modifyk.accountbook.transfer;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modifyk.accountbook.asset.AssetDAO;
import com.modifyk.accountbook.asset.AssetVO;

@Controller
public class TransferController {
	
	@Autowired
	TransferDAO tDao;
	
	@Autowired
	AssetDAO astDao;
	
	@Autowired
	TransferToMapService toMapSvc;
	
	// 이체 추가
	@ResponseBody
	@RequestMapping("transfer/insertTransfer")
	public String insertTransfer(TransferVO transferVO) {
		int result = tDao.insertTransfer(transferVO);
		if(result == 1) {
			AssetVO assetVO = new AssetVO();
			
			// 출금 자산
			assetVO.setAstname(transferVO.getWithdraw());
			assetVO.setTotal(transferVO.getTotal());
			assetVO.setUserid(transferVO.getUserid());
			astDao.minusTotal(assetVO);
			// 입금 자산
			assetVO.setAstname(transferVO.getDeposit());
			astDao.plusTotal(assetVO);
			
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 월별 이체 내역
	@ResponseBody
	@RequestMapping("transfer/transferInfo")
	public HashMap<String, Object> transferInfo(TransferVO transferVO) {
		List<TransferVO> transferList = tDao.transferInfo(transferVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(transferList.size() < 1) {
			map.put("no", "no");
		} else {
			map = toMapSvc.toMap(transferList);
		}
		return map;
	}
	
	// 이체 수정
	@ResponseBody
	@RequestMapping("transfer/updateTransfer")
	public String updateTransfer(TransferVO transferVO) {
		// 해당 transferid의 값들 조회
		TransferVO idResult = tDao.transferidInfo(transferVO);
		// 수정
		int result = tDao.updateTransfer(transferVO);
		if(result == 1) {
			int beforeMoney = idResult.getTotal(); // 수정하기 전 금액
			String beforeWithdraw = idResult.getWithdraw(); // 수정하기 전 출금
			String beforeDeposit = idResult.getDeposit(); // 수정하기 전 입금

			// 원래대로 돌리기
			// 출금지에 beforeMoney 더하고
			AssetVO assetVO = new AssetVO();
			assetVO.setAstname(beforeWithdraw);
			assetVO.setTotal(beforeMoney);
			assetVO.setUserid(idResult.getUserid());
			
			astDao.plusTotal(assetVO);
			
			// 입금지에서 beforeMoney 빼기
			assetVO.setAstname(beforeDeposit);
			astDao.minusTotal(assetVO);
			
			// 수정한 후 처리
			assetVO.setAstname(transferVO.getWithdraw());
			assetVO.setTotal(transferVO.getTotal());
			astDao.minusTotal(assetVO);

			assetVO.setAstname(transferVO.getDeposit());
			astDao.plusTotal(assetVO);
			
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 이체 삭제
	@ResponseBody
	@RequestMapping("transfer/deleteTransfer")
	public String deleteTransfer(TransferVO transferVO) {
		// 해당 transferid의 값들 조회
		TransferVO idResult = tDao.transferidInfo(transferVO);
				
		int result = tDao.deleteTransfer(transferVO);
		if(result == 1) {
			int beforeMoney = idResult.getTotal(); // 수정하기 전 금액
			String beforeWithdraw = idResult.getWithdraw(); // 수정하기 전 출금
			String beforeDeposit = idResult.getDeposit(); // 수정하기 전 입금
			
			// 원래대로 돌리기
			// 출금지에 beforeMoney 더하고
			AssetVO assetVO = new AssetVO();
			assetVO.setAstname(beforeWithdraw);
			assetVO.setTotal(beforeMoney);
			assetVO.setUserid(idResult.getUserid());
						
			astDao.plusTotal(assetVO);
						
			// 입금지에서 beforeMoney 빼기
			assetVO.setAstname(beforeDeposit);
			astDao.minusTotal(assetVO);
			
			return "success";
		} else {
			return "fail";
		}
	}
}
