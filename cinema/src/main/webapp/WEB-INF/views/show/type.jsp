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
body {
	margin: 0; /* body의 기본 여백을 제거합니다. */
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
	<c:set var="item" value="${item}" />
	<%@include file="../menu/menu.jsp"%>
	<div class="container">
		<!-- 본문을 감싸는 컨테이너를 생성합니다. -->
			<a href="/list.do" style="text-decoration: none;"><h1 style="color: black;">EVENT</h1></a>
		<hr style="border-top: 5px solid black;">
			<a href="/category.do?type=영화" style="text-decoration: none; color: black;">영화</a> 
			<a href="/category.do?type=굿즈" style="text-decoration: none; color: black;">굿즈</a> 
			<a href="/category.do?type=할인" style="text-decoration: none; color: black;">할인</a>

		<hr style="border-top: 2px solid black;">
		<br> <br>
		<c:if test="${type== '영화'}">
			<h2 style="display: inline;">영화</h2>
			<p style="display: inline;">맛있으면 0칼로리, 아는 맛이 제일 맛있어요</p>
			<hr style="border-top: 2px solid black;">
		</c:if>
		<c:if test="${type == '굿즈'}">
			<h2 style="display: inline;">팝콘</h2>
			<p style="display: inline;">고소, 달콤부터 고메팝콘까지, 안먹으면 서운해요</p>
			<hr style="border-top: 2px solid black;">
		</c:if>
		<c:if test="${type == '할인'}">
			<h2 style="display: inline;">할인</h2>
			<p style="display: inline;">탄산음료부터 에이드까지, 마시는 즐거움!</p>
			<hr style="border-top: 2px solid black;">
		</c:if>
		<c:forEach var="row" items="${list}">
    <a href="<c:url value='/detail.do?num=${row.num}' />">
				<div class="movie-item">
					<img src="/resources/images/store/${row.filename1}"
						style="width: 200px; height: 150;">
					<p style="font-size: 24px; color: #333;">${row.subject}</p>
				</div>
			</a>
		</c:forEach>
	</div>
</body>
</html>
