$(function () {
	$(document).ready(function() {
		$.ajax({
			type: "post",
			url: "monthAccount",
			data: {
				userid: userid
			},
			success: function(res) {
				$("#left #div1").html(res);
			}
		})
		
		$.ajax({
			type: "post",
			url: "recentAccount",
			data: {
				userid: userid
			},
			success: function(res) {
				$("#left #div2").html(res);
			}
		})
	})
	
})