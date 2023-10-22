$(function () {
	$(document).ready(function() {
		// 현재 세션의 포인트 정보 가져오기
		$.ajax({
			type : "post",
			url : "userMoneyInfo",
			data : {
				userid : userid
			},
			success : function(info) {
				$("#point-div").html(info.userpoint);
				if(info.plantstep < 10) {
					$("#plant-step-div").html("<img src='../resources/img/moneyseed.png' id='plant-step' width='200px;'>");
					$("#water-btn").show();
				} else if(info.plantstep < 25) {
					$("#plant-step-div").html("<img src='../resources/img/moneyleaf.png' id='plant-step' width='200px;'>");
					$("#water-btn").show();
				} else if(info.plantstep < 50) {
					$("#plant-step-div").html("<img src='../resources/img/moneyflower.png' id='plant-step' width='200px;'>");
					$("#water-btn").show();
				} else {
					$("#plant-step-div").html("<img src='../resources/img/moneyfruit.png' id='plant-step' class='money' width='200px;' style='right:35%; cursor:pointer;'>");
					$("#water-btn").hide(); // 물 못 주도록 하기
				}
			}
		})
	})
	
	// 아이디 클릭 시 회원 정보 보기
	$(document).on("click", "#myinfo-btn", function() {
		location.href = "../member/myInfo.jsp";
	})
	
	// 물 주기
	$(document).on("click", "#water-btn", function() {
		$.ajax({
			type : "post",
			url : "usePoint",
			data : {
				userid : userid,
			},
			success : function (x) {
				if(x == -1) {
					alert("포인트가 부족합니다!");
				} else {
					// 물 뿌리개 움직이기
					$("#water-btn").animate({rotate : "-45deg"}, 1000);
					$("#water-btn").animate({rotate : "0deg"}, 1000);
					
					// 물 나왔다 사라지기 
					$("#water-img").show(1200);
					$("#water-img").fadeOut(300);
					
					// 현재 세션의 포인트 정보 가져오기
					$.ajax({
						type : "post",
						url : "userMoneyInfo",
						data : {
							userid : userid
						},
						success : function(info) {
							$("#point-div").html(info.userpoint);
							if(info.plantstep < 10) {
								$("#plant-step-div").html("<img src='../resources/img/moneyseed.png' id='plant-step' width='200px;'>");
								$("#water-btn").show();
							} else if(info.plantstep < 25) {
								$("#plant-step-div").html("<img src='../resources/img/moneyleaf.png' id='plant-step' width='200px;'>");
								$("#water-btn").show();
							} else if(info.plantstep < 50) {
								$("#plant-step-div").html("<img src='../resources/img/moneyflower.png' id='plant-step' width='200px;'>");
								$("#water-btn").show();
							} else {
								$("#plant-step-div").html("<img src='../resources/img/moneyfruit.png' id='plant-step' class='money' width='200px;' style='right:35%; cursor:pointer;'>");
								$("#water-btn").hide();
								$("#water-img").hide();
							}
						}
					})
				}
			}
		})
	})
	
	// 랜덤 포인트 발생
	$(document).on("click", ".money", function() {
		// plant-step이 money일 때
		// 랜덤 cash 뽑기 및 plant-step 0으로 설정
		$.ajax({
			type : "post",
			url : "randomCash",
			data : {
				usercash : 0,
				plantstep : 0,
				userid : userid
			},
			success : function(x) {
				if(x > 0) {
					alert(x + "원 획득!");
					window.location.reload();
				} else {
					alert("다시 시도해주세요.");
				}
			}
		})
	})
})