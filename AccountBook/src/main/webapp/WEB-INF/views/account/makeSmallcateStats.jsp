<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function drawChart(chartName) {
	    var data = google.visualization.arrayToDataTable([
	    	['분류', '합계'],
	    	${data}
	    ]);
	
	    var options = {
	            legend: {position: 'labeled', textStyle: {color: 'black', fontSize: 17}},
	            pieSliceText: 'label',
	            pieSliceTextStyle: {fontSize: 17},
	            pieStartAngle: 0,
	            chartArea:{width:'100%',height:'75%'}
	          };
	
	    var chart = new google.visualization.PieChart(document.getElementById(chartName));
	
	    chart.draw(data, options);
	}
</script>
</head>
<body>
	<div class="stats-div">
		<c:set var="mtype" value="${moneytype}"></c:set>
		<h2>${bigcate} 통계</h2>
		<c:if test="${mtype == '지출'}">
			<div class="piechart" id="smallcate-piechart1"></div>
			<script>google.charts.load("current", {packages:["corechart"]});
					google.charts.setOnLoadCallback(drawChart('smallcate-piechart1'));</script>		
		</c:if>
		<c:if test="${mtype == '수입'}">
			<div class="piechart" id="smallcate-piechart2"></div>	
			<script>google.charts.setOnLoadCallback(drawChart('smallcate-piechart2'));</script>			
		</c:if>
		<div class="stats-list" id="stats-list">
			<table>
				<c:forEach items="${list}" var="list">
					<tr class="hide">
						<td id="typeVal">${moneytype}</td>		
					</tr>
					<tr>
						<td>${list.smallcate}</td>		
						<c:if test="${mtype == '수입'}">
							<td class="blue"><fmt:formatNumber value="${list.total}"></fmt:formatNumber>원</td>			
						</c:if>
						<c:if test="${mtype == '지출'}">
							<td class="red">-<fmt:formatNumber value="${list.total}"></fmt:formatNumber>원</td>			
						</c:if>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>