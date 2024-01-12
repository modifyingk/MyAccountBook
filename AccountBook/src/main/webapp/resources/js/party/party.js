document.write('<script src="../resources/js/main.js"></script>'); // 모달 및 카테고리 설정 js

$(function() {
	// 가입한 그룹 유무 확인
	$.checkJoinParty = function(userid) {
		var result;
		$.ajax({
			type : "post",
			url : "../member/joinedParty",
			async : false,
			data : {
				userid : userid
			},
			success : function(x) {
				if(x != null) {
					result = true;
				} else {
					result = false;
				}
			}
		})
		return result;
	}
	
	// 그룹명 중복확인
	$.isOverlapParty = function(partyname) {
		var result;
		$.ajax({
			type: "post",
			url : "isOverlapParty",
			async : false,
			data : {
				partyname : partyname
			},
			success : function(x) {
				if(x == "possible") {
					result = true;
				} else {
					result = false;
				}
			}
		})
		return result;
	}
	
	// 가입 그룹 업데이트
	$.joinParty = function(partyname, userid) {
		var result;
		$.ajax({
			type : "post",
			url : "../member/updateParty",
			async : false,
			data : {
				partyname : partyname,
				userid : userid
			},
			success : function(x) {
				if(x == "success") {
					result = true;
				} else {
					result = false;
				}
			}
		})
		return result;
	}
	
	$(document).ready(function() {
		$.closeModal("#close-add-group", "#add-group-modal"); // 그룹 생성 모달 닫기
		$.closeModal("#close-group-info", "#group-info-modal"); // 그룹 정보 모달 닫기
		
		$.ajax({
			url : "selectParty",
			success : function(list) {
				var html = "<table class='list-table'>";
				for(var i = 0; i < list.length; i++) {
					html += "<tr class='tr-grouplist'><td><div class='fs-20'>" + list[i].partyname + "</div><div><span class='fs-18 info'><i class='fi fi-rr-user-crown'></i> " + list[i].owner + "</span></div></td></tr>";
				}
				html += "</table>";
				$("#group-list-div").html(html);
			}
		
		})
		
		// 그룹 멤버 목록
		$.ajax({
			type : "post",
			url : "../member/partyMember",
			data : {
				partyname : partyname
			},
			success : function(member) {
				$.ajax({
					type : "post",
					url : "partyInfo",
					data : {
						partyname : partyname
					},
					success : function(party) {
						var html = "<table class='list-table' style='width: 350px;'>";
						html += "<tr><td><div class='fs-20'><i class='fi fi-rr-user-crown'></i><span> " + party.owner + "</span></div></td></tr>";
						for(var i = 0; i < member.length; i++) {
							html += "<tr><td><div class='fs-20'><i class='fi fi-rr-user'></i><span> " + member[i] + "</span></div></td></tr>";
						}
						html += "</table>";
						$("#member-list-div").html(html);
					}
				})
			}
		})
	})

	// 그룹 생성 모달 열기 전 확인
	$(document).on("click", "#add-group-page", function() {
		if(!$.checkJoinParty(userid)) {
			alert("이미 가입한 그룹이 존재합니다. 탈퇴 후 진행해주세요.")
		} else {
			$("#add-group-modal").show();
		}
	})
	
	// 가입 신청
	$(document).on("click", "#join-group-btn", function() {
		if(!$.checkJoinParty(userid)) {
			alert("이미 가입한 그룹이 존재합니다. 탈퇴 후 진행해주세요.")
		} else {
			// $("#request-partyname").text()
			alert("가입신청이 완료되었습니다. 그룹장의 승인을 기다려주세요!")
		}
	})
	
	// 그룹 생성
	$(document).on("click", "#add-group-btn", function() {
		if($.isOverlapParty($("#partyname").val())) { // 그룹명이 중복되지 않으면
			$.ajax({ // 그룹 생성
				type : "post",
				url : "insertParty",
				data : {
					partyname : $("#partyname").val(),
					owner : userid,
					introduction : $("#introduction").val()
				},
				success : function(x) {
					if(x == "success") { // 그룹 생성 성공 시
						// 회원 정보 가입한 그룹 업데이트
						if($.joinParty($("#partyname").val(), userid)) {
							window.location.reload();
						} else {
							alert("다시 시도해주세요.");
						}
					} else {
						alert("다시 시도해주세요.");
					}
				}
			})
		} else {
			alert("중복되는 이름입니다.")
		}
	})
	
	// 그룹 클릭 시 해당 그룹 정보 보여주기
	$(document).on("click", ".tr-grouplist", function() {
		$.ajax({
			type : "post",
			url : "partyInfo",
			data : {
				partyname : $(this).children().children().eq(0).text()
			},
			success : function(party) {
				var html = "<div class='is-center'><i class='fi fi-rs-badge' style='font-size: 100px;'></i></div>";
				html += "<div class='is-center' id='request-partyname'><i class='h-bold text-center fs-28'>" + party.partyname + "</i><br></div>";
				html += "<div class='is-center'><i class='h-normal text-center fs-20'><i class='fi fi-rr-user-crown'></i>" + party.owner;
				html += " | " + party.introduction + "</i></div>";
				$("#group-info-div").html(html);
				
				$("#group-info-modal").show();
			}
		})
	})
	
	// 그룹 검색
	$(document).on("click", "#search-party-btn", function() {
		$.ajax({
			type : "post",
			url :"searchParty",
			data : {
				partyname : $("#search-party").val()
			},
			success : function(list) {
				var html = "<table class='list-table'>";
				for(var i = 0; i < list.length; i++) {
					html += "<tr class='tr-grouplist'><td><div class='fs-20'>" + list[i].partyname + "</div><div><span class='fs-18 info'><i class='fi fi-rr-user-crown'></i> " + list[i].owner + "</span></div></td></tr>";
				}
				html += "</table>";
				$("#group-list-div").html(html);
			}
		})
	})
})