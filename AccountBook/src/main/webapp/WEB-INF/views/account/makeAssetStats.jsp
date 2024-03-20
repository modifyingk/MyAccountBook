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
	<div class="stats-div" id="out-stats-div">
		<h2>지출 통계</h2>
		<div class="piechart" id="piechart1"></div>
		<div class="stats-list">
			<table>
				<c:forEach items="${spendList}" var="spendList">
					<tr>
						<td>${spendList.assetname}</td>		
						<td class="red">-<fmt:formatNumber value="${spendList.total}"></fmt:formatNumber>원</td>			
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	
	<div class="angle-icon scroll-x" id="scroll-instats"><i class="fi fi-rr-angle-right"></i></div>
	
	<div class="stats-div" id="in-stats-div">
		<h2>수입 통계</h2>
		<div class="piechart" id="piechart2"></div>
		<div class="stats-list">
			<table>
				<c:forEach items="${incomeList}" var="incomeList">
					<tr>
						<td>${incomeList.assetname}</td>		
						<td class="blue"><fmt:formatNumber value="${incomeList.total}"></fmt:formatNumber>원</td>			
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	
	<div class="angle-icon scroll-x" id="scroll-outstats"><i class="fi fi-rr-angle-right"></i></div>
</body>
<script>
	google.charts.load("current", {packages:["corechart"]});
	google.charts.setOnLoadCallback(drawChart1);
	google.charts.setOnLoadCallback(drawChart2);

	function drawChart1() {
		let data = google.visualization.arrayToDataTable([
	    	['분류', '합계'],
	    	${spendData}
	    ]);
	
		let options = {
	            legend: {position: 'labeled', textStyle: {color: 'black', fontSize: 17}},
	            pieSliceText: 'label',
	            pieSliceTextStyle: {fontSize: 17},
	            pieStartAngle: 0,
	            chartArea:{width:'100%',height:'75%'}
	          };
	
		let chart = new google.visualization.PieChart(document.getElementById('piechart1'));
	
	    chart.draw(data, options);
	}
	
	function drawChart2() {
	    let data = google.visualization.arrayToDataTable([
	    	['분류', '합계'],
	    	${incomeData}
	    ]);
	
	    let options = {
	            legend: {position: 'labeled', textStyle: {color: 'black', fontSize: 17}},
	            pieSliceText: 'label',
	            pieSliceTextStyle: {fontSize: 17},
	            pieStartAngle: 0,
	            chartArea:{width:'100%',height:'75%'}
	          };
	
	    let chart = new google.visualization.PieChart(document.getElementById('piechart2'));
	
	    chart.draw(data, options);
	}
</script>
</html>