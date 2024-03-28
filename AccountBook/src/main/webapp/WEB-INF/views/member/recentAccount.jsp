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
	<c:set var="incomeMax" value="0"></c:set>
	<c:set var="spendMax" value="0"></c:set>
	
	<!-- 제일 큰 값 구하기 (제일 큰 값을 기준으로 그래프 생성) -->
	<c:forEach items="${incomeList}" var="incomeList">
		<c:if test="${incomeMax < incomeList.total}">
			<c:set var="incomeMax" value="${incomeList.total}"></c:set>
		</c:if>
	</c:forEach>
	<c:forEach items="${spendList}" var="spendList">
		<c:if test="${spendMax < spendList.total}">
			<c:set var="spendMax" value="${spendList.total}"></c:set>
		</c:if>
	</c:forEach>
			
	<div id="left-div1"> <!-- 수입 -->
		<h2>최근 수입 비교</h2>
		<!-- 그래프 -->
		<div id="top-div1">
			<c:forEach items="${incomeList}" var="incomeList">
				<div class="graph-group">
					<c:set var="percent" value="${incomeList.total / incomeMax * 100}"></c:set>
					<div>
						<div class="graph">
							<div class="back-paint" style="height: ${100-percent}%"></div>
							<div class="paint" style="height: ${percent}%"></div>
						</div>
					</div>
					<div class="label">${fn:substring(incomeList.date, 4, 6)}월</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<div id="left-div2"> <!-- 지출 -->
		<h2>최근 지출 비교</h2>
		<!-- 그래프 -->
		<div id="top-div1">
			<c:forEach items="${spendList}" var="spendList">
				<div class="graph-group">
					<c:set var="percent" value="${spendList.total / spendMax * 100}"></c:set>
					<div>
						<div class="graph">
							<div class="back-paint" style="height: ${100-percent}%"></div>
							<div class="paint" style="height: ${percent}%"></div>
						</div>
					</div>
					<div class="label">${fn:substring(spendList.date, 4, 6)}월</div>
				</div>
			</c:forEach>
		</div>
	</div>
	
</body>
</html>