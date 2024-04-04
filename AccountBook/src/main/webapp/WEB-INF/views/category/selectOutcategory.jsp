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
				<c:forEach items="${list}" var="list">
					<c:if test="${list.bigcate == '식비'}">
						<tr>
							<td class="hide">${list.categoryid}</td>
							<td>
								<div class="is-border">
									<input class="input-inner update" value="${list.smallcate}">
									<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
									<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
								</div>
							</td>
						</tr>
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
				<c:forEach items="${list}" var="list">
					<c:if test="${list.bigcate == '문화/여가'}">
						<tr>
							<td class="hide">${list.categoryid}</td>
							<td>
								<div class="is-border">
									<input class="input-inner update" value="${list.smallcate}">
									<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
									<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
								</div>
							</td>
						</tr>
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
				<c:forEach items="${list}" var="list">
					<c:if test="${list.bigcate == '패션/뷰티'}">
						<tr>
							<td class="hide">${list.categoryid}</td>
							<td>
								<div class="is-border">
									<input class="input-inner update" value="${list.smallcate}">
									<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
									<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
								</div>
							</td>
						</tr>
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
				<c:forEach items="${list}" var="list">
					<c:if test="${list.bigcate == '공과금'}">
						<tr>
							<td class="hide">${list.categoryid}</td>
							<td>
								<div class="is-border">
									<input class="input-inner update" value="${list.smallcate}">
									<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
									<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
								</div>
							</td>
						</tr>
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
				<c:forEach items="${list}" var="list">
					<c:if test="${list.bigcate == '마트/편의점'}">
						<tr>
							<td class="hide">${list.categoryid}</td>
							<td>
								<div class="is-border">
									<input class="input-inner update" value="${list.smallcate}">
									<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
									<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
								</div>
							</td>
						</tr>
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
				<c:forEach items="${list}" var="list">
					<c:if test="${list.bigcate == '주거/통신'}">
						<tr>
							<td class="hide">${list.categoryid}</td>
							<td>
								<div class="is-border">
									<input class="input-inner update" value="${list.smallcate}">
									<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
									<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
								</div>
							</td>
						</tr>
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
				<c:forEach items="${list}" var="list">
					<c:if test="${list.bigcate == '의료/건강'}">
						<tr>
							<td class="hide">${list.categoryid}</td>
							<td>
								<div class="is-border">
									<input class="input-inner update" value="${list.smallcate}">
									<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
									<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
								</div>
							</td>
						</tr>
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
				<c:forEach items="${list}" var="list">
					<c:if test="${list.bigcate == '교육'}">
						<tr>
							<td class="hide">${list.categoryid}</td>
							<td>
								<div class="is-border">
									<input class="input-inner update" value="${list.smallcate}">
									<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
									<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
								</div>
							</td>
						</tr>
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
				<c:forEach items="${list}" var="list">
					<c:if test="${list.bigcate == '생활용품'}">
						<tr>
							<td class="hide">${list.categoryid}</td>
							<td>
								<div class="is-border">
									<input class="input-inner update" value="${list.smallcate}">
									<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
									<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
								</div>
							</td>
						</tr>
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
				<c:forEach items="${list}" var="list">
					<c:if test="${list.bigcate == '교통/차량'}">
						<tr>
							<td class="hide">${list.categoryid}</td>
							<td>
								<div class="is-border">
									<input class="input-inner update" value="${list.smallcate}">
									<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
									<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
								</div>
							</td>
						</tr>
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
				<c:forEach items="${list}" var="list">
					<c:if test="${list.bigcate == '선물/경조사'}">
						<tr>
							<td class="hide">${list.categoryid}</td>
							<td>
								<div class="is-border">
									<input class="input-inner update" value="${list.smallcate}">
									<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
									<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
								</div>
							</td>
						</tr>
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
				<c:forEach items="${list}" var="list">
					<c:if test="${list.bigcate == '기타'}">
						<tr>
							<td class="hide">${list.categoryid}</td>
							<td>
								<div class="is-border">
									<input class="input-inner update" value="${list.smallcate}">
									<button class="update-btn check-btn hide" id="update-btn"><i class="fi fi-rr-check"></i></button>
									<button class="update-btn cross-btn hide" id="delete-btn"><i class="fi fi-rr-cross"></i></button>
								</div>
							</td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>