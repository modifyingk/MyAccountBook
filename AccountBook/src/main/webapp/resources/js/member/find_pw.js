document.write('<script src="../resources/js/function/emailFunc.js"></script>'); // 이메일 함수

$(function () {
	$(document).ready(function() {
		// 이메일 주소 선택
		$.selectAddress("#selectEmail", "#email2");
	})
	
	$(document).on("click", "#findpwBtn", function() {
		var email = $("#email1").val() + "@" + $("#email2").val();
		// DB에 저장된 아이디와 이름, 이메일 정보가 일치하는지 확인
		$.ajax({
			type : "post",
			url : "findPw",
			data : {
				userid : $("#userid").val(),
				username : $("#username").val(),
				email : email
			},
			success : function(x) {
				if(x != "fail") {
					$.ajax({
						type : "post",
						url : "tempPw",
						data : {
							userid : x,
							email : email
						},
						success : function(res) {
							if(res == true) {
								alert("입력하신 이메일로 임시 비밀번호가 전송되었습니다.")
								location.href = "../member/login.jsp";
							} else {
								alert("다시 시도해주세요.");
							}
						}
					})
				} else {
					alert("입력한 정보를 다시 확인해주세요");
				}
			}
		})
	})
})