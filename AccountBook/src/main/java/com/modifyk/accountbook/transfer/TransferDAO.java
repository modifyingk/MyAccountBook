package com.modifyk.accountbook.transfer;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TransferDAO {
	
	@Autowired
	SqlSessionTemplate my;
	
	// 이체 추가
	public int insertTransfer(TransferVO transferVO) {
		return my.insert("transferMapper.insertTransfer", transferVO);
	}
	
	// 월별 이체 내역
	public List<TransferVO> transferInfo(TransferVO transferVO) {
		return my.selectList("transferMapper.transferInfo", transferVO);
	}
	
	// 이체 수정
	public int updateTransfer(TransferVO transferVO) {
		return my.update("transferMapper.updateTransfer", transferVO);
	}
	
	// transferid 값으로 검색
	public TransferVO transferidInfo(TransferVO transferVO) {
		return my.selectOne("transferMapper.transferidInfo", transferVO);
	}
	
	// 이체 삭제
	public int deleteTransfer(TransferVO transferVO) {
		return my.delete("transferMapper.deleteTransfer", transferVO);
	}
}
