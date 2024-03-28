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
	<div id="left-div1">
		<c:forEach items="${list}" var="list">
			<c:if test="${list.moneytype == '수입'}">
				<h2>이번 달 수입</h2>
				<p class="blue"><fmt:formatNumber value="${list.total}"></fmt:formatNumber>원</p>
			</c:if>
		</c:forEach>
	</div>
	<div id="left-div2">
		<c:forEach items="${list}" var="list">
			<c:if test="${list.moneytype == '지출'}">
				<h2>이번 달 지출</h2>
				<p class="red"><fmt:formatNumber value="${list.total}"></fmt:formatNumber>원</p>
			</c:if>
		</c:forEach>
	</div>
</body>
</html>