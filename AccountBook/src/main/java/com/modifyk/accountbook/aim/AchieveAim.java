package com.modifyk.accountbook.aim;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.modifyk.accountbook.member.MemberDAO;
import com.modifyk.accountbook.member.MemberVO;

@Component
public class AchieveAim {
	
	@Autowired
	AimDAO aDao;
	
	@Autowired
	AimToMapService toMapSvc;
	
	@Autowired
	MemberDAO mDao;
	
	public void achieveAim() {
		// 현재 날짜 구하기
        LocalDate now = LocalDate.now();
        String today = "";

        if((now.getMonthValue() - 1) < 10) {
        	today = now.getYear() + "-0" + (now.getMonthValue() - 1);
        } else {
        	today = now.getYear() + "-" + (now.getMonthValue() - 1);
        }
        
		AimVO aimVO = new AimVO();
		aimVO.setAimdate(today);
		aimVO.setMoneytype("지출");

		List<AimJoinVO> aimList = aDao.aimAll(aimVO);
		HashMap<String, String> map = toMapSvc.toMapAll(aimList);
		
		MemberVO memberVO = new MemberVO();
		for(String key : map.values()) {
			System.out.println(key);
			String[] value = key.split("#");
			if(Integer.parseInt(value[1]) < Integer.parseInt(value[0])) { // 총 지출 금액이 목표 금액보다 적은 경우
				memberVO.setUserid(value[2]); // 해당 user에게
				memberVO.setPoint(20); // 20 포인트
				mDao.updatePoint(memberVO); // 적립
			}
		}
	}
	
}
