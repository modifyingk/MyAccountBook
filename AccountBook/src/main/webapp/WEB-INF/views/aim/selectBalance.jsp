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
	<c:if test="${balance > 0}">
		<p>카테고리에 분배 가능한 예산은 <b><fmt:formatNumber value="${balance}" type="number"></fmt:formatNumber></b>원입니다.</p>
	</c:if>
	<c:if test="${balance == 0}">
		<p>예산 분배 완료! 더 이상 예산을 분배할 수 없어요.</p>
	</c:if>
	<c:if test="${balance < 0}">
		<p>분배한 예산이 총 예산을 <b><fmt:formatNumber value="${balance * -1}" type="number"></fmt:formatNumber></b>원 초과했어요! 다시 분배해주세요.</p>
	</c:if>
</body>
</html>