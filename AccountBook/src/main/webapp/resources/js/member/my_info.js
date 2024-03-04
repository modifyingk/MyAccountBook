document.write('<script src="../resources/js/function/regFunc.js"></script>'); // 유효성 검사 함수
document.write('<script src="../resources/js/function/idFunc.js"></script>'); // 아이디 확인 함수
document.write('<script src="../resources/js/function/pwFunc.js"></script>'); // 비밀번호 확인 함수
document.write('<script src="../resources/js/function/birthFunc.js"></script>'); // 생년월일 함수

$(function () {
	$(document).ready(function() {
		$.onlyLetter("#username"); // 영어, 한글만 입력
		$.onlyNum("#date"); // 숫자만 입력
	})

	// 현재 세션의 정보 가져오기
	$.ajax({
		type : "post",
		url : "userInfo",
		data : {
			userid : userid
		},
		success : function(info) {
			let username = info.username;
			let gender = info.gender;
			let birth = info.birth.replaceAll("-", "");
			
			$("#username").attr("value", username);
			if(gender == "M") {
				$("input[type=radio][value='M']").prop("checked", true);
			} else {
				$("input[type=radio][value='F']").prop("checked", true);
			}
			$("#birth").attr("value", birth);
		}
	})
	
	// 개인정보 변경 클릭 시
	$(document).on("click", "#update-btn", function() {
		let name = $("#username").val();
		let gender = $("input[name=gender]:checked").val();
		let birth = $("#birth").val();
		alert(birth)
		if(checkName() && checkGender() && checkBirth()) {
			$.ajax({
				type : "post",
				url : "updateMember",
				data : {
					userid: userid,
					username: name,
					gender: gender,
					birth: birth
				},
				success : function(res) {
					if(res == true) {
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
	$(document).on("click", "#drop-btn", function() {
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
					success : function(res) {
						if(res == true) {
							alert("탈퇴가 성공적으로 완료되었습니다.");
							location.href = "logout";
						} else {
							alert("다시 시도해주세요.");
						}
					}
				})
			} else {
				alert("입력하신 값과 아이디가 일치하지않습니다.")
			}
		}
	})
	
	// 비밀번호 변경 클릭 시 비밀번호 변경 페이지로
	$(document).on("click", "#change-pw", function() {
		location.href = "check_pw.jsp";
	})
})

function checkName() {
	let name = $("#username").val();
	let nameChk = $.checkNameReg(name);
	if(nameChk) {
		return true;
	} else {
		return false;
	}
}

function checkBirth() {
	let birth = $("#birth").val();
	let birthChk = $.checkBirthReg(birth);
	if(birthChk) {
		return true;
	} else {
		return false;
	}
}

function checkGender() {
	let gender = $("input[name=gender]:checked").val(); // 선택 성별
	if(gender == "M" || gender == "F") {
		return true;
	} else {
		return false;
	}
}