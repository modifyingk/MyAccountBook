<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="top-div1"> <!-- 수입 -->
		<h2>나의 목표 자산</h2>
		
		<c:choose>
			<c:when test="${aimtotal == null}"> <!-- 목표가 등록되어 있지 않은 경우 -->
				<div class="no-data-div"><i class='fi fi-rr-cloud-question fs35'></i><br>데이터가 없습니다.</div>
				<button class="btn" id="add-aim-btn">목표 등록</button>
			</c:when>
			
			<c:otherwise> <!-- 목표가 등록되어있는 경우 -->
				<div id="aim"><fmt:formatNumber value="${aimtotal}"></fmt:formatNumber>원</div>
				
				<c:set var="division" value="${vo.total / vo.aim}"></c:set>
				<fmt:formatNumber var="percent" value="${division}" type="percent"></fmt:formatNumber>
								
				<!-- 게이지 -->
				<div class="gage-div">
					<c:choose>
						<c:when test="${division * 100 <= 100}">
							<div class="gage-chart" style="background: conic-gradient(var(--light-green-color) 0% ${percent}, lightgray ${percent} 100%)">
								<span title="<fmt:formatNumber value="${vo.total}"></fmt:formatNumber>원">${percent}</span>
							</div>
						</c:when>
						<c:otherwise>
							<div class="gage-chart" style="background: conic-gradient(var(--light-green-color) 0% 100%, lightgray 100% 100%)">
								<span title="<fmt:formatNumber value="${vo.total}"></fmt:formatNumber>원">${percent}</span>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
					
				<c:choose>
					<c:when test="${division * 100 <=50}">
						<p>작은 저축이 큰 꿈을 이루는 첫 걸음입니다.</p>
					</c:when>
					<c:when test="${division * 100 <= 80}">
						<p>저축은 자신을 투자하는 것입니다.</p>
					</c:when>
					<c:when test="${division * 100 < 100}">
						<p>목표에 가까워졌어요!</p>
					</c:when>
					<c:otherwise>
						<p>자산 모으기 성공! 목표를 높여서 더 모아볼까요?</p>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>