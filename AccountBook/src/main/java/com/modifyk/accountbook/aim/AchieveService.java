package com.modifyk.accountbook.aim;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.modifyk.accountbook.member.MemberDAO;
import com.modifyk.accountbook.member.MoneyVO;

@Component
public class AchieveService {
	
	@Autowired
	AimDAO aDao;
	
	@Autowired
	MemberDAO mDao;
	
	@Autowired
	AimToMapService toMapSvc;
	
	public void isachieve() {
		// 현재 날짜 구하기
        LocalDate now = LocalDate.now();
        String today = "";
        
        // 이전 달
        if((now.getMonthValue() - 1) < 10) {
        	today = now.getYear() + "-0" + (now.getMonthValue() - 1);
        } else {
        	today = now.getYear() + "-" + (now.getMonthValue() - 1);
        }
        
        // 가져올 날짜 setting
		AimVO aimVO = new AimVO();
		aimVO.setAimdate(today);
		aimVO.setMoneytype("지출");

		// 목표, 총 지출 금액 가져오기
		List<AimJoinVO> aimList = aDao.aimAll(aimVO);
		HashMap<String, AimJoinVO> map = toMapSvc.toMap(aimList);
		
		// 목표 달성
		for(String key : map.keySet()) {
			if(map.get(key).getTotal() < map.get(key).getAim_money()) {
				aimVO.setAimid(map.get(key).getAimid());
				aimVO.setUserid(map.get(key).getUserid());
				aimVO.setAchieveaim('o'); // 목표 달성 o 로 setting
				
				aDao.achieveAim(aimVO);
			}
		}
		
		// 목표 달성 포인트 적립
		int point = 0;
		MoneyVO moneyVO = new MoneyVO();
		
		List<AimRateVO> rateList = aDao.achieveRate(today);
		for(int i = 0; i < rateList.size(); i++) {
			double rate = rateList.get(i).getAchieve_num() / rateList.get(i).getAim_num() * 100;
			System.out.println(rate);
			
			// 달성률이 0인 것은 select 되지 않으므로
			if(rate < 50) { // 목표 달성률이 50보다 적을 때
				point = 50;
			} else if(rate < 100){ // 목표 달성률이 50 이상 100 이하일 때
				point = 70;
			} else { // 목표 달성률이 100일 때
				point = 100;
			}
			
			moneyVO.setUserid(rateList.get(i).getUserid());
			moneyVO.setUserpoint(point);
			System.out.println(rateList.get(i).getUserid() + "님 " + point + "포인트 적립");
			mDao.updatePoint(moneyVO);
		}
	}
	
}
