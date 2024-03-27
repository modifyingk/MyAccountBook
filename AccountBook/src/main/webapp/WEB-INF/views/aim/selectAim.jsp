<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="total-aim">
		목표 금액<i></i>
		<p></p>
		<div id="total-gage-div"><div id="total-gage"></div></div>
	</div>
	<div id="aim-list">
		<c:set var="totalAim" value="0"></c:set>
		<c:set var="totalSpend" value="0"></c:set>
		
		<c:forEach items="${list}" var="list">
			<c:set var="totalAim" value="${totalAim + list.aim}"></c:set>
			<c:set var="totalSpend" value="${totalSpend + list.spend}"></c:set>
			<c:set var="division" value="${list.spend / list.aim}"></c:set>
			<script type="text/javascript">
				console.log(${division} * 100);
			</script>
			<fmt:formatNumber var="percent" value="${division}" type="percent"></fmt:formatNumber>
			<c:choose>
				<c:when test="${division * 100 <= 50}">
					<div class="gage-div">
					<div class="gage-chart" style="background: conic-gradient(var(--light-green-color) 0% ${percent}, var(--light-gray-color) ${percent} 100%)">
						<span>${percent}</span>
					</div>
					<p>${list.bigcate}</p>
					<p><fmt:formatNumber value="${list.spend}" type="number"></fmt:formatNumber> / <fmt:formatNumber value="${list.aim}" type="number"></fmt:formatNumber></p>
				</div>
				</c:when>
				<c:when test="${division * 100 > 50 && division * 100 <= 80}">
					<div class="gage-div">
						<div class="gage-chart" style="background: conic-gradient(#fac05e 0% ${percent}, var(--light-gray-color) ${percent} 100%)">
							<span>${percent}</span>
						</div>
						<p>${list.bigcate}</p>
						<p class="orange"><fmt:formatNumber value="${list.spend}" type="number"></fmt:formatNumber> / <fmt:formatNumber value="${list.aim}" type="number"></fmt:formatNumber></p>
					</div>
				</c:when>
				<c:when test="${division * 100 > 80 && division * 100 <= 100}">
					<div class="gage-div">	
					<div class="gage-chart" style="background: conic-gradient(var(--red-color) 0% ${percent}, var(--light-gray-color) ${percent} 100%)">
						<span>${percent}</span>
					</div>
					<p>${list.bigcate}</p>
					<p class="red"><fmt:formatNumber value="${list.spend}" type="number"></fmt:formatNumber> / <fmt:formatNumber value="${list.aim}" type="number"></fmt:formatNumber></p>
				</div>
				</c:when>
				<c:otherwise>
					<div class="gage-div">	
					<div class="gage-chart" style="background: conic-gradient(var(--red-color) 0% 100%, var(--light-gray-color) 100% 100%)">
						<span>${percent}</span>
					</div>
					<p>${list.bigcate}</p>
					<p class="red"><fmt:formatNumber value="${list.spend}" type="number"></fmt:formatNumber> / <fmt:formatNumber value="${list.aim}" type="number"></fmt:formatNumber></p>
				</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</div>
</body>
<script>
	$("#total-aim i").html(parseInt(${totalSpend}).toLocaleString() + "원 / " + parseInt(${totalAim}).toLocaleString() + "원");
	let percent = Math.round(${totalSpend / totalAim * 100});
	
	$("#total-gage").css("width", percent + "%");
	if(percent > 50 && percent <= 80) {
		$("#total-gage").css("background", "#FFA500");
	} else if(percent > 80) {
		$("#total-gage").css("background", "var(--red-color)");
	}
	
	if(${totalAim - totalSpend} > 0) {
		$("#total-aim p").html("아직 <b>" + parseInt(${totalAim - totalSpend}).toLocaleString() + "</b>원 더 사용할 수 있습니다.");
	} else {
		$("#total-aim p").html(parseInt(${(totalAim - totalSpend) * -1}).toLocaleString() + "원 초과했습니다. 소비를 멈춰주세요 !");
		$("#total-aim p").css("color", "var(--red-color)");
	}
</script>
</html>