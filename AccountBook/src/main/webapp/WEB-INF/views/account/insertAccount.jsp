<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<tr class="tr-content">
		<td class="hide" id="td-key">${vo.date}</td>
		<td class="hide">${vo.accountid}</td>
		<td class="hide">${vo.moneytype}</td>
		<td class="td-category">
			<c:if test="${vo.moneytype == '수입'}">
				<div class="key-div income">${vo.bigcate}</div>
				<div class="td-smallcate income">${vo.smallcate}</div>
			</c:if>
			<c:if test="${vo.moneytype == '지출'}">
				<div class="key-div spend">${vo.bigcate}</div>
				<div class="td-smallcate spend">${vo.smallcate}</div>
			</c:if>
		</td>
		<td class="td-asset gray">${vo.assetname}</td>
		<td class="td-content">${vo.content}</td>
		<c:if test="${vo.moneytype == '수입'}">
			<td class="td-income text-right blue">
				<fmt:formatNumber value="${vo.total}"></fmt:formatNumber>원
			</td>
		</c:if>
		<c:if test="${vo.moneytype == '지출'}">
			<td class="td-spend text-right red">
				<fmt:formatNumber value="${vo.total}"></fmt:formatNumber>원
			</td>
		</c:if>
	</tr>
