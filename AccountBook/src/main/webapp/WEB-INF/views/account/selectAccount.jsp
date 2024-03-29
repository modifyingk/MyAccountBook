<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="income_total" value="0"></c:set>
	<c:set var="spend_total" value="0"></c:set>
	<c:if test="${map.size() > 0}">
		<c:forEach items="${map}" var="map">
			<!-- 부분합 구하기 -->
			<c:set var="income" value="0"></c:set>
			<c:set var="spend" value="0"></c:set>
			<c:forEach items="${map.value}" var="value">
				<c:if test="${value.moneytype == '수입'}">
					<c:set var="income" value="${income + value.total}"></c:set>
				</c:if>
				<c:if test="${value.moneytype == '지출'}">
					<c:set var="spend" value="${spend + value.total}"></c:set>
				</c:if>
			</c:forEach>
			
			<!-- 수입/지출 내역 -->
			<fmt:parseDate value="${map.key}" var="dateValue" pattern="yyyyMMdd"></fmt:parseDate>
			<fmt:formatDate var="yoil" value="${dateValue}" pattern="E"/>
			
			<table class="account-table ${map.key} ${yoil}">
				<tr class="tr-date">
					<td class="td-date">
						<fmt:formatDate value="${dateValue}" pattern="M월 d일 E"/>
					</td>
					<td colspan="3">
						<div class="part-spend"><fmt:formatNumber value="${spend}"></fmt:formatNumber>원</div>
						<div class="part-income"><fmt:formatNumber value="${income}"></fmt:formatNumber>원</div>
					</td>
				</tr>
				<c:forEach items="${map.value}" var="value">
				<tr class="tr-content">
					<td class="hide" id="td-key">${map.key}</td>
					<td class="hide">${value.accountid}</td> <!-- 수입/지출 id -->
					<td class="hide">${value.moneytype}</td> <!-- 수입/지출 -->
					<td class="td-category">
						<c:if test="${value.moneytype == '수입'}">
							<div class="key-div income">${value.bigcate}</div> <!-- 대분류 -->
							<div class="td-smallcate income">${value.smallcate}</div> <!-- 소분류 -->
						</c:if>
						<c:if test="${value.moneytype == '지출'}">
							<div class="key-div spend">${value.bigcate}</div> <!-- 대분류 -->
							<div class="td-smallcate spend">${value.smallcate}</div> <!-- 소분류 -->
						</c:if>
						<c:if test="${value.moneytype == '이체'}">
							<div class="key-div transfer">${value.bigcate}</div> <!-- 대분류 -->
							<div class="td-smallcate transfer">${value.smallcate}</div> <!-- 소분류 -->
						</c:if>
					</td>
					<td class="td-asset gray">${value.assetname}</td> <!-- 자산 -->
					<td class="td-content">${value.content}</td> <!-- 내용 -->
					<c:if test="${value.moneytype == '수입'}">
						<td class='td-income text-right blue'><fmt:formatNumber value="${value.total}"></fmt:formatNumber>원</td>
						<c:set var="income_total" value="${income_total + value.total}"></c:set>
					</c:if>
					<c:if test="${value.moneytype == '지출'}">
						<td class='td-spend text-right red'><fmt:formatNumber value="${value.total}"></fmt:formatNumber>원</td>
						<c:set var="spend_total" value="${spend_total + value.total}"></c:set>
					</c:if>
					<c:if test="${value.moneytype == '이체'}">
						<td class='td-transfer text-right gray'><fmt:formatNumber value="${value.total}"></fmt:formatNumber>원</td>
					</c:if>
				</tr>
				</c:forEach>
			</table>
		</c:forEach>
	</c:if>
	<c:if test="${map.size() <= 0}">
		<div class="no-data-div"><i class='fi fi-rr-cloud-question fs35'></i><br>데이터가 없습니다.</div>
	</c:if>
	<script>
	$(function () {
		$("#total-div i").html((${income_total} + ${spend_total}).toLocaleString());
		$("#income-div i").html((${income_total}).toLocaleString());
		$("#spend-div i").html((${spend_total}).toLocaleString());
		
		// 수입/지출 내역 테이블에서 날짜 tr 클릭 시
		$(document).on("click", "#account-list-div .tr-date", function() {
			let obj = $(this).parent().children().eq(1).children().eq(0).text();
			let y = obj.substring(0, 4);
			let m = obj.substring(4, 6);
			let d = obj.substring(6, 8);
			var dateVal = y + "-" + twoDigits(m) + "-" + twoDigits(d);
			$("#add-date").attr("value", dateVal);
		})
	})
	</script>
</body>
</html>