<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script>
    // JavaScript를 사용하여 링크 스타일 변경
    document.addEventListener("DOMContentLoaded", function() {
        var links = document.querySelectorAll('.container a');
        var currentLink = null;

        links.forEach(function(link) {
            link.addEventListener('click', function() {
                if (currentLink) {
                    currentLink.style.color = 'gray'; // 이전에 클릭된 링크의 색상을 회색으로 변경
                }
                this.style.color = 'red'; // 클릭된 링크의 색상을 빨간색으로 변경
                currentLink = this; // 현재 클릭된 링크로 설정
            });
        });
    });
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.container a:hover{
   color:red;
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
			href="/product/category.do?product_type=5"style="text-decoration: none;color: black;">굿즈</a> <c:if test="${sessionScope.userid !=null }">
			<a href="/cart/list.do" style="float: right; text-decoration: none;color: black;">장바구니</a>
			</c:if>
			<c:if test="${sessionScope.userid==null }">
			<a href="/login.do" style="float: right; text-decoration: none;color: black;">장바구니</a>
			</c:if>
		<hr style="border-top: 2px solid black;">
		<br> <br>
		<c:if test="${num == '4'}">
			<h2 style="display: inline;">콤보</h2>
			<p style="display: inline;">맛있으면 0칼로리, 아는 맛이 제일 맛있어요</p>
			<hr style="border-top: 2px solid black;">
		</c:if>
		<c:if test="${num == '1'}">
			<h2 style="display: inline;">팝콘</h2>
			<p style="display: inline;">고소, 달콤부터 고메팝콘까지, 안먹으면 서운해요</p>
			<hr style="border-top: 2px solid black;">
		</c:if>
		<c:if test="${num == '2'}">
			<h2 style="display: inline;">음료</h2>
			<p style="display: inline;">탄산음료부터 에이드까지, 마시는 즐거움!</p>
			<hr style="border-top: 2px solid black;">
		</c:if>
		<c:if test="${num == '3'}">
			<h2 style="display: inline;">스낵</h2>
			<p style="display: inline;">출출할땐 다양한 스낵이 정답이죠</p>
			<hr style="border-top: 2px solid black;">
		</c:if>
		<c:if test="${num == '5'}">
			<h2 style="display: inline;">굿즈</h2>
			<p style="display: inline;">영화속 등장인물들의 물건을 직접 만나보세요!</p>
			<hr style="border-top: 2px solid black;">
		</c:if>
		<c:forEach var="row" items="${list}">
			<a href="/store/detail.do?product_code=${row.product_code}">
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
		</c:forEach>
	</div>
	
	
	
</body>
</html>
