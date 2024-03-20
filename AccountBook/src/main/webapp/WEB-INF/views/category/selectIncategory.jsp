<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="float: left;">
		<div class="incategory-div">
			<table id="income-t1">
				<tr>
					<td>
						<div class="key-div">소득</div>
						<button class="manage-btn">···</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="is-border">
							<div class="add-div" id="add-btn">+</div>
							<div>
								<input class="input-inner" id="add-incate">
							</div>
						</div>
					</td>
				</tr>
				<c:forEach items="${map}" var="map">
					<c:if test="${map.key == '소득'}">
						<c:forEach items="${map.value}" var="value">
							<tr>
								<td class="hide">${value.categoryid}</td>
								<td>
									<div class="is-border">
										<input class="input-inner update" value="${value.smallcate}">
										<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
										<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
									</div>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</c:forEach>
			</table>
		</div>
	</div>
	<div style="float: left;">
		<div class="incategory-div">
			<table id="income-t1">
				<tr>
					<td>
						<div class="key-div">저축</div>
						<button class="manage-btn">···</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="is-border">
							<div class="add-div" id="add-btn">+</div>
							<div>
								<input class="input-inner" id="add-incate">
							</div>
						</div>
					</td>
				</tr>
				<c:forEach items="${map}" var="map">
					<c:if test="${map.key == '저축'}">
						<c:forEach items="${map.value}" var="value">
							<tr>
								<td class="hide">${value.categoryid}</td>
								<td>
									<div class="is-border">
										<input class="input-inner update" value="${value.smallcate}">
										<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
										<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
									</div>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</c:forEach>
			</table>
		</div>
	</div>
	<div style="float: left;">
		<div class="incategory-div">
			<table id="income-t1">
				<tr>
					<td>
						<div class="key-div">기타</div>
						<button class="manage-btn">···</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="is-border">
							<div class="add-div" id="add-btn">+</div>
							<div>
								<input class="input-inner" id="add-incate">
							</div>
						</div>
					</td>
				</tr>
				<c:forEach items="${map}" var="map">
					<c:if test="${map.key == '기타'}">
						<c:forEach items="${map.value}" var="value">
							<tr>
								<td class="hide">${value.categoryid}</td>
								<td>
									<div class="is-border">
										<input class="input-inner update" value="${value.smallcate}">
										<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
										<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
									</div>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>