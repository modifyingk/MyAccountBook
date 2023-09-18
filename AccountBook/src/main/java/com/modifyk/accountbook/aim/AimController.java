package com.modifyk.accountbook.aim;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modifyk.accountbook.member.MemberDAO;
import com.modifyk.accountbook.member.MemberVO;

@Controller
public class AimController {
	
	@Autowired
	AimDAO aDao;
	
	@Autowired
	MemberDAO mDao;
	
	@Autowired
	AimToMapService toMapSvc;
	
	// 목표 추가
	@ResponseBody
	@RequestMapping("aim/insertAim")
	public String insertAim(AimVO aimVO) {
		int result = aDao.insertAim(aimVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 목표 가져오기
	@ResponseBody
	@RequestMapping("aim/aimInfo")
	public HashMap<String, Object> aimInfo(AimVO aimVO) {
		List<AimJoinVO> aimList = aDao.aimInfo(aimVO);
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(aimList.size() < 1) {
			map.put("no", "no");
		} else {
			map = toMapSvc.toMap(aimList);
		}
		return map;
	}
	
	// 목표 수정
	@ResponseBody
	@RequestMapping("aim/updateAim")
	public String updateAim(AimVO aimVO) {
		int result = aDao.updateAim(aimVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 목표 삭제
	@ResponseBody
	@RequestMapping("aim/deleteAim")
	public String deleteAim(AimVO aimVO) {
		int result = aDao.deleteAim(aimVO);
		if(result == 1) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	// 목표 카테고리 중복 확인
	@ResponseBody
	@RequestMapping("aim/isOverlapAim")
	public String isOverlapAim(AimVO aimVO) {
		String result = aDao.isOverlapAim(aimVO);
		if(result != null) {
			return "impossible";
		} else {
			return "possible";
		}
	}
	
	// 목표 달성 확인
	@ResponseBody
	@RequestMapping("aim/isAchieve")
	public int isAchieve(String userid) {
		int result = 0;
		int point = 0;
		
		/*
		 * Date today = new Date(); SimpleDateFormat sdfTime = new
		 * SimpleDateFormat("dd HH:mm:ss"); String nowTime = sdfTime.format(today);
		 * System.out.println(nowTime);
		 */
		
		//if(nowTime.equals("01 00:00:00")) {
			// 이전 달
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
			Date date = new Date();
			String now = sdf.format(date);
			
			System.out.println("원래 날짜" + now);
			
			String year = "";
			String month = "";
			
			if(now.split("-")[1] == "12") {
				year = String.valueOf(Integer.parseInt(now.split("-")[0]) - 1);
				month = "01";
			} else {
				year = now.split("-")[0];
				month = String.valueOf(Integer.parseInt(now.split("-")[1]) - 1);
				if(month.length() == 1) {
					month = "0" + month;
				}
			}
			
			now = year + "-" + month;
			System.out.println("이전 달" + now);
			
			// 목표 가져오기 위한 값 셋팅
			AimVO aimVO = new AimVO();
			aimVO.setAimdate(now);
			aimVO.setMoneytype("지출");
			aimVO.setUserid(userid);
			
			// 목표 가져오기
			List<AimJoinVO> aimList = aDao.aimInfo(aimVO);
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			if(aimList.size() >= 1) {
				map = toMapSvc.toMap(aimList);
				// 목표 비교
				for(String keys : map.keySet()) {
					String[] value = map.get(keys).toString().split("#"); // value[1]은 목표 값, value[2]는 지출 합계
					if(Integer.parseInt(value[1]) >= Integer.parseInt(value[2])) { // 지출 합계가 목표값보다 작거나 같다면
						// 포인트 적립
						point += 10;
					}
				}
				if(point == 10 * map.size()) { // 만약 목표를 모두 달성했다면 50P 추가
					point += 50;
				}
				
				MemberVO memberVO = new MemberVO();
				memberVO.setUserid(userid);
				memberVO.setPoint(point);
				
				result = mDao.updatePoint(memberVO);
			}
		//}
		
		if(result == 1) {
			return point;
		} else {
			return 0;
		}
	}
}
