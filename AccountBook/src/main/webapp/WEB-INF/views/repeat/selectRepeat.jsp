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
	<table>
		<c:forEach items="${map}" var="map">
			<tr class="tr-date">
				<c:set var="length" value="${fn:length(map.key)}"></c:set>
				<td><div>${fn:substring(map.key, length-2, length)}일</div></td>
			</tr>
			<c:forEach items="${map.value}" var="value">
			<tr class="tr-content">
				<td class="hide">${value.repeatid}</td>
				<td class="hide">${value.repeatcycle}</td>
				<td class="hide">${value.moneytype}</td>
				<td class="hide">${value.date}</td>
				<td class="hide">${value.assetname}</td>
				<td>${value.bigcate}</td>
				<td class="hide">${value.smallcate}</td>
				<td  class="hide">${value.content}</td>
				<c:if test="${value.moneytype == '수입'}">
					<td class="blue"><fmt:formatNumber value="${value.total}"></fmt:formatNumber>원</td>
				</c:if>
				<c:if test="${value.moneytype == '지출'}">
					<td class="red"><fmt:formatNumber value="${value.total}"></fmt:formatNumber>원</td>
				</c:if>
			</tr>
			</c:forEach>
		</c:forEach>
	</table>
</body>
<script>
	$(document).on("click", "#schedule-list .tr-content", function() {
		let repeatid = $(this).children().eq(0).text();
		let repeatcycle = $(this).children().eq(1).text();
		let moneytype = $(this).children().eq(2).text();
		let date = $(this).children().eq(3).text();
		let assetname = $(this).children().eq(4).text();
		let bigcate = $(this).children().eq(5).text();
		let smallcate = $(this).children().eq(6).text();
		let content = $(this).children().eq(7).text();
		let total = $(this).children().eq(8).text().split("원")[0];
		
		console.log(repeatid + " " + repeatcycle + " " + moneytype + " " + date + " " + assetname + " " + bigcate + " " + smallcate + " " + content + " " + total);
		
		$("#repeat-id").attr("value", repeatid);
		$("#repeat-mtype").attr("value", moneytype);
		if(repeatcycle == "매년") {
			$("#repeat-cycle").html(repeatcycle + " " + date.substring(0, 2) + "월 " + date.substring(2, 4) + "일");
		} else if(repeatcycle == "매월") {
			$("#repeat-cycle").html(repeatcycle + " " + date + "일");
		}
		$("#repeat-asset").attr("value", assetname);
		$("#repeat-bigcate").attr("value", bigcate);
		$("#repeat-smallcate").attr("value", smallcate);
		$("#repeat-content").attr("value", content);
		$("#repeat-total").attr("value", total);
		
		$("#update-repeat-modal").show();
	})
</script>
</html>