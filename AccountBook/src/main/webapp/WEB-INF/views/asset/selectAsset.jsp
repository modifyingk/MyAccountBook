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
	<c:set var="total" value="0"></c:set>
	
	<c:if test="${map.size() > 0}">
		<div id="total-div">
			<p>합계 <i></i></p>
		</div>
	
		<div id="asset1-div">
			<c:forEach items="${map}" var="map">
				<c:if test="${map.key == '계좌·현금' || map.key == '카드' || map.key == '신용카드' || map.key == '선불카드'}">
					<table>
						<tr><td><div class="key-div">${map.key}</div></td></tr>
						<c:forEach items="${map.value}" var="value">
							<tr class="tr-asset"><td class="hide">${value.assetid}</td> <!-- 자산 id -->
							<td class="hide">${map.key}</td> <!-- 자산 그룹 -->
							<td class="td-select td-asset">
								<div class="col-5">${value.assetname}</div> <!-- 자산명 -->
								<c:if test="${value.total < 0}"> <!-- 금액 음수 -->
									<div class="col-5 text-right red"><money><fmt:formatNumber value="${value.total}"></fmt:formatNumber></money>원</div>
									<c:set var="total" value="${total + value.total}"></c:set>
								</c:if>
								<c:if test="${value.total >= 0}"> <!-- 금액 양수 -->
									<div class="col-5 text-right blue"><money><fmt:formatNumber value="${value.total}"></fmt:formatNumber></money>원</div>
									<c:set var="total" value="${total + value.total}"></c:set>
								</c:if>
							</td>
							<td class="hide">${value.memo}</td> <!-- 메모 -->
							<td id="open-update-asset"><button class="transfer-icon">이체</button></td></tr>
						</c:forEach>
					</table>
				</c:if>
			</c:forEach>
		</div>
		
		<div id="asset2-div">
			<c:forEach items="${map}" var="map">
				<c:if test="${map.key != '계좌·현금' && map.key != '카드' && map.key != '신용카드' && map.key != '선불카드'}">
					<table>
						<tr><td><div class="key-div">${map.key}</div></td></tr>
						<c:forEach items="${map.value}" var="value">
							<tr class="tr-asset"><td class="hide">${value.assetid}</td> <!-- 자산 id -->
							<td class="hide">${map.key}</td> <!-- 자산 그룹 -->
							<td class="td-asset">
								<div class="col-5">${value.assetname}</div> <!-- 자산명 -->
								<c:if test="${value.total < 0}"> <!-- 금액 음수 -->
									<div class="col-5 text-right red"><money><fmt:formatNumber value="${value.total}"></fmt:formatNumber></money>원</div>
									<c:set var="total" value="${total + value.total}"></c:set>
								</c:if>
								<c:if test="${value.total >= 0}"> <!-- 금액 양수 -->
									<div class="col-5 text-right blue"><money><fmt:formatNumber value="${value.total}"></fmt:formatNumber></money>원</div>
									<c:set var="total" value="${total + value.total}"></c:set>
								</c:if>
							</td>
							<td class="hide">${value.memo}</td> <!-- 메모 -->
							<td><button class="transfer-icon">이체</button></td></tr>
						</c:forEach>
					</table>
				</c:if>
			</c:forEach>
		</div>
	</c:if>
	<c:if test="${map.size() <= 0}">
		<div class="no-data-div"><i class='fi fi-rr-cloud-question fs35'></i><br>데이터가 없습니다.</div>
	</c:if>
	
	<script>
		$(function () {
			$("#total-div i").html((${total}).toLocaleString() + "원");
		})
	</script>
</body>
</html>