<%@page import="java.time.DayOfWeek"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<div id="mini-date-div">
		<fmt:parseDate var="dateValue" value="${today}01" pattern="yyyyMMdd"></fmt:parseDate>
		<fmt:formatDate value="${dateValue}" pattern="M월"/>
	</div>
	
	<%
		int[] ilArr = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
		String today = (String)request.getAttribute("today");
		int year = Integer.parseInt(today.substring(0, 4)); // 년
		int month = Integer.parseInt(today.substring(4, 6)); // 월
		
		if(year % 4 == 0 && year % 100 != 0 || year % 400 == 0) { // 평년 윤년에 따른 2월 마지막 날 구하기
			ilArr[1] = 29;
		} else {
			ilArr[1] = 28;
		}
		
		LocalDate date = LocalDate.of(year, month, 1);
		DayOfWeek dayOfWeek = date.getDayOfWeek(); // 1-7 = 월-일
		int yoil = dayOfWeek.getValue(); // 시작 요일 값
	%>
	
	<div>
		<table id="mini-calendar">
			<tr class="yoil">
				<td>일</td> <td>월</td> <td>화</td> <td>수</td> <td>목</td> <td>금</td> <td>토</td>
			</tr>
			<%
			int i = 1;
			while(i <= ilArr[month - 1]) { %>
				<tr> 
				<% for(int j = 0; j < yoil; j++) { %>
						<td></td>
				<% }
				   for(int j = yoil; j < 7; j++) { 
				   		if(i <= ilArr[month-1]) { %>
				   		<td class="il">
					   		<div class="flex-column">
					   			<div class="dot">
						   			<c:forEach items="${list}" var="list">
						   				<fmt:parseNumber var="date" type="number" value="${fn:substring(list.date, 6, 8)}"></fmt:parseNumber>
						   				<c:set var="i" value="<%= i %>"></c:set>
						   				<c:if test="${date == i}">
						   					<c:if test="${list.moneytype == '수입'}">
							   					<p class="income">●</p>
						   					</c:if>
						   					<c:if test="${list.moneytype == '지출'}">
							   					<p class="spend">●</p>
						   					</c:if>
						   				</c:if>
						   			</c:forEach>
							  	</div>
							  	<div><%= i++ %></div>
							</div>
						</td>
					 <% }
				   }
				   yoil = 0;
				%>
				</tr>
			<% } %>
		</table>
	</div>
</body>
</html>