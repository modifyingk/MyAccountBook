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
	<div id="aim-list">
	<c:if test="${list.size() > 0}">
		<c:forEach items="${list}" var="list">
			<c:set var="division" value="${list.total / list.aim}"></c:set>
			<fmt:formatNumber var="percent" value="${division}" type="percent"></fmt:formatNumber>
			<c:choose>
				<c:when test="${division * 100 <= 50}">
					<div class="gage-div">
					<div class="gage-chart" style="background: conic-gradient(var(--light-green-color) 0% ${percent}, var(--light-gray-color) ${percent} 100%)">
						<span>${percent}</span>
					</div>
					<p>${list.bigcate}</p>
					<p><fmt:formatNumber value="${list.total}" type="number"></fmt:formatNumber> / <fmt:formatNumber value="${list.aim}" type="number"></fmt:formatNumber></p>
				</div>
				</c:when>
				<c:when test="${division * 100 <= 80}">
					<div class="gage-div">
						<div class="gage-chart" style="background: conic-gradient(#fac05e 0% ${percent}, var(--light-gray-color) ${percent} 100%)">
							<span>${percent}</span>
						</div>
						<p>${list.bigcate}</p>
						<p class="orange"><fmt:formatNumber value="${list.total}" type="number"></fmt:formatNumber> / <fmt:formatNumber value="${list.aim}" type="number"></fmt:formatNumber></p>
					</div>
				</c:when>
				<c:when test="${division * 100 <= 100}">
					<div class="gage-div">	
					<div class="gage-chart" style="background: conic-gradient(var(--red-color) 0% ${percent}, var(--light-gray-color) ${percent} 100%)">
						<span>${percent}</span>
					</div>
					<p>${list.bigcate}</p>
					<p class="red"><fmt:formatNumber value="${list.total}" type="number"></fmt:formatNumber> / <fmt:formatNumber value="${list.aim}" type="number"></fmt:formatNumber></p>
				</div>
				</c:when>
				<c:otherwise>
					<div class="gage-div">	
					<div class="gage-chart" style="background: conic-gradient(var(--red-color) 0% 100%, var(--light-gray-color) 100% 100%)">
						<span>${percent}</span>
					</div>
					<p>${list.bigcate}</p>
					<p class="red"><fmt:formatNumber value="${list.total}" type="number"></fmt:formatNumber> / <fmt:formatNumber value="${list.aim}" type="number"></fmt:formatNumber></p>
				</div>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</c:if>
	<c:if test="${list.size() <= 0}">
		<div class="no-data-div"><i class='fi fi-rr-cloud-question fs35'></i><br>카테고리별로 목표 금액을 추가해보세요!</div>
	</c:if>
	</div>
</body>
</html>