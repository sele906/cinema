<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	font-family: Arial, sans-serif;
}

@media ( max-width : 1600px) {
	body {
		margin: 0;
	}
}

.section1 {
	margin: 0 10%; /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	padding: 0px;
	width: auto;
}

.section2 {
	margin: 0 10%; /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	padding: 0px;
	width: auto;
}

.moviesection {
	background-color: #333;
	padding: 40px 330px 10px 330px; /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
}

.foot {
	margin: 0 10%;
}

.like-button {
	background: none;
	border: none;
	cursor: pointer;
	outline: none;
}

.like-button img {
	width: 30px;
	height: auto;
	transition: transform 0.3s ease;
}



.poster img {
	margin: 30px;
}

.titleword {
	padding-top: 20px;
	font-weight: bold;
	font-size: 24px;
}

.contents {
	margin: 0 330px; /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	padding: 0px;
	width: auto;
}

.main-menu a:hover {
	color: #ffcc00;
}

.container a:hover {
	color: red;
}

.container {
	max-width: 800px; /* 컨테이너의 최대 너비를 지정합니다. */
	margin: 0 auto; /* 가운데 정렬을 수행합니다. */
	padding: 0 20px; /* 양쪽에 20px의 여백을 추가합니다. */
}

.movie-item {
	display: inline-block;
}

.movie-item img {
	width: 200px; /* 이미지 너비를 200px로 설정합니다. */
	height: 150px; /* 이미지 높이를 150px로 설정합니다. */
}

.container .a {
	display: inline-block; /* 링크를 인라인 블록 요소로 만듭니다. */
	margin-right: 20px; /* 링크 사이의 간격을 설정합니다. */
	font-size: 20px; /* 링크의 글꼴 크기를 설정합니다. */
	color: gray; /* 링크의 글꼴 색상을 회색으로 설정합니다. */
	text-decoration: none; /* 밑줄 제거 */
}
</style>

</head>
<body>

	<%@include file="../menu/menu.jsp" %>

	<div class="container">
		<!-- 본문을 감싸는 컨테이너를 생성합니다. -->
		<a href="/store/list.do" style="text-decoration: none;"><h1 style="color: black;">스토어</h1></a>
		<hr style="border-top: 5px solid black;">
		<a href="/product/category.do?product_type=4"style="text-decoration: none;color: black;"> 콤보</a> <a
			href="/product/category.do?product_type=1"style="text-decoration: none;color: black;">팝콘</a> <a
			href="/product/category.do?product_type=2"style="text-decoration: none;color: black;">음료</a> <a
			href="/product/category.do?product_type=3"style="text-decoration: none;color: black;">스낵</a> <a
			href="/product/category.do?product_type=5"style="text-decoration: none;color: black;">굿즈</a> 
			<c:if test="${sessionScope.userid !=null }">
			<a href="/cart/list.do" style="float: right; text-decoration: none;color: black;">장바구니</a>
			</c:if>
			<c:if test="${sessionScope.userid==null }">
			<a href="/login.do" style="float: right; text-decoration: none;color: black;">장바구니</a>
			</c:if>
			
			
			
		<hr style="border-top: 2px solid black;">
		<br> <br>
		<h2>
			콤보<a href="/product/category.do?product_type=4"
				style="color: green; font-size: 24px; float: right; text-decoration: none;">+</a>
		</h2>
		<hr style="border-top: 2px solid black;">
		<div class="combo">
			<c:forEach var="row" items="${list}">
				<c:if test="${row.product_type == '4'}">
					<a
						href="/store/detail.do?product_code=${row.product_code}">
						<div class="movie-item">
							<img src="/resources/images/store/${row.filename}"
								style="width: 200px; height: 150;">
							<p style="font-size: 24px; color: #333;">${row.product_name}</p>
							<p style="font-size: 20px; color: gray;">${row.description}</p>
							<p style="font-size: 28px; color: #333;">
								<fmt:formatNumber value="${row.price}" pattern="#,###" />
								원
							</p>
						</div>
					</a>
				</c:if>
			</c:forEach>
		</div>
		<h2>
			팝콘<a href="/product/category.do?product_type=1"
				style="color: green; font-size: 24px; float: right; text-decoration: none;">+</a>
		</h2>
		<hr style="border-top: 2px solid black;">
		<div class="popcorn">
			<c:forEach var="row" items="${list}">
				<c:if test="${row.product_type == '1'}">
					<a
						href="/store/detail.do?product_code=${row.product_code}">
						<div class="movie-item">
							<img src="/resources/images/store/${row.filename}"
								style="width: 200px; height: 150;">
							<p style="font-size: 24px; color: #333;">${row.product_name}</p>
							<p style="font-size: 20px; color: gray;">${row.description}</p>
							<p style="font-size: 28px; color: #333;">
								<fmt:formatNumber value="${row.price}" pattern="#,###" />
								원
							</p>
						</div>
					</a>
				</c:if>
			</c:forEach>
		</div>

		<h2>
			음료<a href="/product/category.do?product_type=2"
				style="color: green; font-size: 24px; float: right; text-decoration: none;">+</a>
		</h2>
		<hr style="border-top: 2px solid black;">
		<div class="beverage">
			<c:forEach var="row" items="${list}">
				<c:if test="${row.product_type == '2'}">
					<a
						href="/store/detail.do?product_code=${row.product_code}">
						<div class="movie-item">
							<img src="/resources/images/store/${row.filename}"
								style="width: 200px; height: 150;">

							<p style="font-size: 24px; color: #333;">${row.product_name}</p>
							<p style="font-size: 20px; color: gray;">${row.description}</p>
							<p style="font-size: 28px; color: #333;">
								<fmt:formatNumber value="${row.price}" pattern="#,###" />
								원
							</p>
						</div>
					</a>
				</c:if>
			</c:forEach>
		</div>

		<h2>
			스낵<a href="/product/category.do?product_type=3"
				style="color: green; font-size: 24px; float: right; text-decoration: none;">+</a>
		</h2>
		<hr style="border-top: 2px solid black;">
		<div class="snack">
			<c:forEach var="row" items="${list}">
				<c:if test="${row.product_type == '3'}">
					<a
						href="/store/detail.do?product_code=${row.product_code}">
						<div class="movie-item">
							<img src="/resources/images/store/${row.filename}"
								style="width: 200px; height: 150;">
							<p style="font-size: 24px; color: #333;">${row.product_name}</p>
							<p style="font-size: 20px; color: gray;">${row.description}</p>
							<p style="font-size: 28px; color: #333;">
								<fmt:formatNumber value="${row.price}" pattern="#,###" />
								원
							</p>
						</div>
					</a>
				</c:if>
			</c:forEach>
		</div>
		<h2>
			굿즈<a href="/product/category.do?product_type=5"
				style="color: green; font-size: 24px; float: right; text-decoration: none;">+</a>
		</h2>
		<hr style="border-top: 2px solid black;">
		<div class="beverage">
			<c:forEach var="row" items="${list}">
				<c:if test="${row.product_type == '5'}">
					<a
						href="/store/detail.do?product_code=${row.product_code}">
						<div class="movie-item">
							<img src="/resources/images/store/${row.filename}"
								style="width: 200px; height: 150;">

							<p style="font-size: 24px; color: #333;">${row.product_name}</p>
							<p style="font-size: 20px; color: gray;">${row.description}</p>
							<p style="font-size: 28px; color: #333;">
								<fmt:formatNumber value="${row.price}" pattern="#,###" />
								원
							</p>
						</div>
					</a>
				</c:if>
			</c:forEach>
		</div>
	</div>

	<%@include file="../include/footer.jsp" %>

</body>
</html>
