document.write('<script src="../resources/js/reg_exp.js"></script>'); // 유효성 검사 함수가 저장된 js 파일 가져오기

$(function () {
	var nameChk = true;
	var birthChk = true;
	
	$(document).ready(function() {
		// 숫자만 입력
		$.onlyNum("#year"); // 연도
		$.onlyNum("#date"); // 날짜
		
		// 영어, 한글만 입력
		$.onlyLetter("#username"); // 이름
	})
	
	// 아이디 확인
	$(document).on("blur", "#userid", function() {
		idChk = $.checkID("#userid", "#idCheck"); // 아이디 유효성 검사
		
		if(idChk) {
			$(document).on("click", "#overlapBtn", function() { // 아이디 중복 확인
				$.checkOverlapID("#userid", "#idCheck", "#overlapBtn")
			})
		}
	})
	
	// 비밀번호 확인
	$(document).on("blur", "#pw, #pw2", function () {
		pwChk = $.checkPw("#pw", "#pwRegCheck");
		pwChk2 = $.checkPw2("#pw", "#pw2", "#pwCheck");
	})
	
	// 이름 확인
	$(document).on("blur", "#username", function() {
		if(!$.checkNameReg("#username")) { // 정규식에 맞지 않을 때
			$("#nameCheck").html("<p class='msg warning'>이름이 정확한지 확인해주세요</p>");
			nameChk = false;
		} else {
			$("#nameCheck").html("");
			nameChk = true;
		}
	})
	
	// 생년월일 잘못된 값 입력 방지
	$(document).on("blur", "#year, #month, #date", function() {
		birthChk = $.checkBirth("#year", "#month", "#date", "#birthCheck");
	})
	$(document).on("blur", "#date", function() {
		birthChk = $.checkDate("#date", "#birthCheck");
	})

	// 현재 세션의 정보 가져오기
	$.ajax({
		type : "post",
		url : "userInfo",
		data : {
			userid : userid
		},
		success : function(info) {
			var username = info.username;
			var gender = info.gender;
			var birth = info.birth.split("-");
			
			$("#username").attr("value", username);
			
			if(gender == "남") {
				$("input[type=radio][value='남']").prop("checked", true);
			} else {
				$("input[type=radio][value='여']").prop("checked", true);
			}
			
			$("#year").attr("value", birth[0]);
			$("#month").val(birth[1]).prop("selected", true);
			$("#date").attr("value", birth[2]);
		}
	})
	
	// 비밀번호 변경 클릭 시 비밀번호 변경 페이지로
	$(document).on("click", "#chgPwBtn", function() {
		location.href = "check_pw.jsp";
	})
	
	// 개인정보 변경 클릭 시
	$(document).on("click", "#updateMemBtn", function() {
		if(nameChk && birthChk) {
			$.ajax({
				type : "post",
				url : "updateMember",
				data : {
					userid : userid,
					username : $("#username").val(),
					gender : $("input[name=gender]:checked").val(),
					birth : $("#year").val() + $("#month").val() + $("#date").val()
				},
				success : function(x) {
					if(x == "success") {
						alert("회원정보가 수정되었습니다.");
					} else {
						alert("다시 시도해주세요.");
					}
				}
			})
		} else {
			alert("입력 값을 다시 확인해주세요");				
		}
	})
	
	// 회원탈퇴 클릭 시
	$(document).on("click", "#deleteMemBtn", function() {
		var op = confirm("정말로 탈퇴하시겠습니까?");
		if(op) {
			var chkID = prompt("탈퇴하실 아이디를 입력하시면 성공적으로 탈퇴가 완료됩니다.");
			if(chkID == userid) {
				$.ajax({
					type : "post",
					url : "deleteMember",
					data : {
						userid : userid
					},
					success : function(x) {
						if(x == "success") {
							alert("탈퇴가 성공적으로 완료되었습니다.");
							location.href = "logout";
						} else {
							alert("다시 시도해주세요.");
						}
					}
				})
			} else if(chkID == null){
					
			} else {
				alert("입력하신 값과 아이디가 일치하지않습니다.")
			}
		}
	})
})