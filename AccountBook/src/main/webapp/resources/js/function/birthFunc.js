// 생년월일 확인
function checkBirth(birthVal) {
	if(birthVal.length != 8)
		return false;
	else {
		let year = parseInt(birthVal.substring(0, 4));
		let month = parseInt(birthVal.substring(4, 6));
		let day = parseInt(birthVal.substring(6, 8));
		
		let date = new Date();
		let todayYear = date.getFullYear();
		
		if(year < todayYear && year >= todayYear - 100 && month >= 1 && month <= 12 && day >= 1 && day <= 31)
			return true;
		else
			return false;
	}
}