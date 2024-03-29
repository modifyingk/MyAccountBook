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
		나의 예산 <i><fmt:formatNumber value="${vo.total}" type="number"></fmt:formatNumber></i> /<i id="aim"><fmt:formatNumber value="${vo.aim}" type="number"></fmt:formatNumber>원</i>
		<c:set var="division" value="${vo.total / vo.aim}"></c:set>
		<fmt:formatNumber var="percent" value="${division}" type="percent"></fmt:formatNumber>
		<c:choose>
			<c:when test="${division * 100 <= 50}">
				<p>아직 <b><fmt:formatNumber value="${vo.aim - vo.total}" type="number"></fmt:formatNumber></b>원 더 사용할 수 있습니다.</p>
				<div id="total-gage-div">
					<div class="" id="total-gage" style="width:${percent}">${percent}</div>
				</div>
			</c:when>
			<c:when test="${division * 100 <= 80}">
				<p>아직 <b><fmt:formatNumber value="${vo.aim - vo.total}" type="number"></fmt:formatNumber></b>원 더 사용할 수 있습니다.</p>
				<div id="total-gage-div">
					<div class="orange" id="total-gage" style="width:${percent}">${percent}</div>
				</div>
			</c:when>
			<c:when test="${division * 100 < 100}">
				<p>아직 <b><fmt:formatNumber value="${vo.aim - vo.total}" type="number"></fmt:formatNumber></b>원 더 사용할 수 있습니다.</p>
				<div id="total-gage-div">
					<div class="red" id="total-gage" style="width:${percent}">${percent}</div>
				</div>
			</c:when>
			<c:when test="${division * 100 == 100}">
				<p>예산을 꽉 채웠습니다. 소비를 멈춰주세요!</p>
				<div id="total-gage-div">
					<div class="red" id="total-gage" style="width:${percent}">${percent}</div>
				</div>
			</c:when>
			<c:otherwise>
				<p><b><fmt:formatNumber value="${vo.total - vo.aim}" type="number"></fmt:formatNumber></b>원 초과했습니다. 소비를 멈춰주세요!</p>
				<div id="total-gage-div">
					<div class="red" id="total-gage" style="width:100%">${percent}</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>