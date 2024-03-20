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
		<div class="outcategory-div">
			<table id="spend-t1">
				<tr>
					<td>
						<div class="key-div">식비</div>
						<button class="manage-btn">···</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="is-border">
							<div class="add-div" id="add-btn">+</div>
							<div>
								<input class="input-inner" id="add-outcate">
							</div>
						</div>
					</td>
				</tr>
				<c:forEach items="${map}" var="map">
					<c:if test="${map.key == '식비'}">
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
		<div class="outcategory-div">
			<table id="spend-t1">
				<tr>
					<td>
						<div class="key-div">문화/여가</div>
						<button class="manage-btn">···</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="is-border">
							<div class="add-div" id="add-btn">+</div>
							<div>
								<input class="input-inner" id="add-outcate">
							</div>
						</div>
					</td>
				</tr>
				<c:forEach items="${map}" var="map">
					<c:if test="${map.key == '문화/여가'}">
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
		<div class="outcategory-div">
			<table id="spend-t1">
				<tr>
					<td>
						<div class="key-div">패션/뷰티</div>
						<button class="manage-btn">···</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="is-border">
							<div class="add-div" id="add-btn">+</div>
							<div>
								<input class="input-inner" id="add-outcate">
							</div>
						</div>
					</td>
				</tr>
				<c:forEach items="${map}" var="map">
					<c:if test="${map.key == '패션/뷰티'}">
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
		<div class="outcategory-div">
			<table id="spend-t1">
				<tr>
					<td>
						<div class="key-div">공과금</div>
						<button class="manage-btn">···</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="is-border">
							<div class="add-div" id="add-btn">+</div>
							<div>
								<input class="input-inner" id="add-outcate">
							</div>
						</div>
					</td>
				</tr>
				<c:forEach items="${map}" var="map">
					<c:if test="${map.key == '공과금'}">
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
		<div class="outcategory-div">
			<table id="spend-t1">
				<tr>
					<td>
						<div class="key-div">마트/편의점</div>
						<button class="manage-btn">···</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="is-border">
							<div class="add-div" id="add-btn">+</div>
							<div>
								<input class="input-inner" id="add-outcate">
							</div>
						</div>
					</td>
				</tr>
				<c:forEach items="${map}" var="map">
					<c:if test="${map.key == '마트/편의점'}">
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
		<div class="outcategory-div">
			<table id="spend-t1">
				<tr>
					<td>
						<div class="key-div">주거/통신</div>
						<button class="manage-btn">···</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="is-border">
							<div class="add-div" id="add-btn">+</div>
							<div>
								<input class="input-inner" id="add-outcate">
							</div>
						</div>
					</td>
				</tr>
				<c:forEach items="${map}" var="map">
					<c:if test="${map.key == '주거/통신'}">
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
		<div class="outcategory-div">
			<table id="spend-t1">
				<tr>
					<td>
						<div class="key-div">의료/건강</div>
						<button class="manage-btn">···</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="is-border">
							<div class="add-div" id="add-btn">+</div>
							<div>
								<input class="input-inner" id="add-outcate">
							</div>
						</div>
					</td>
				</tr>
				<c:forEach items="${map}" var="map">
					<c:if test="${map.key == '의료/건강'}">
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
		<div class="outcategory-div">
			<table id="spend-t1">
				<tr>
					<td>
						<div class="key-div">교육</div>
						<button class="manage-btn">···</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="is-border">
							<div class="add-div" id="add-btn">+</div>
							<div>
								<input class="input-inner" id="add-outcate">
							</div>
						</div>
					</td>
				</tr>
				<c:forEach items="${map}" var="map">
					<c:if test="${map.key == '교육'}">
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
		<div class="outcategory-div">
			<table id="spend-t1">
				<tr>
					<td>
						<div class="key-div">생활용품</div>
						<button class="manage-btn">···</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="is-border">
							<div class="add-div" id="add-btn">+</div>
							<div>
								<input class="input-inner" id="add-outcate">
							</div>
						</div>
					</td>
				</tr>
				<c:forEach items="${map}" var="map">
					<c:if test="${map.key == '생활용품'}">
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
		<div class="outcategory-div">
			<table id="spend-t1">
				<tr>
					<td>
						<div class="key-div">교통/차량</div>
						<button class="manage-btn">···</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="is-border">
							<div class="add-div" id="add-btn">+</div>
							<div>
								<input class="input-inner" id="add-outcate">
							</div>
						</div>
					</td>
				</tr>
				<c:forEach items="${map}" var="map">
					<c:if test="${map.key == '교통/차량'}">
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
		<div class="outcategory-div">
			<table id="spend-t1">
				<tr>
					<td>
						<div class="key-div">선물/경조사</div>
						<button class="manage-btn">···</button>
					</td>
				</tr>
				<tr>
					<td>
						<div class="is-border">
							<div class="add-div" id="add-btn">+</div>
							<div>
								<input class="input-inner" id="add-outcate">
							</div>
						</div>
					</td>
				</tr>
				<c:forEach items="${map}" var="map">
					<c:if test="${map.key == '선물/경조사'}">
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
		<div class="outcategory-div">
			<table id="spend-t1">
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
								<input class="input-inner" id="add-outcate">
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