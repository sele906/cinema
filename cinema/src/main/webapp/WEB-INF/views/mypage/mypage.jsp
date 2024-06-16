<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	function openPopup() {
	    // 팝업 창을 띄우기
	    window.open('/member/edit.do', 'edit', 'width=650, height=550');
	}
</script>
<style>
body {
	 /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	font-family: Arial, sans-serif;
	margin : 0;
	
}


.bigsection1{
	background-color: black;
	
	margin : 0;
}
.section1{
	background-color : white;
	margin : 0 10%;
	padding : 0 0 200px 0;
}

.foot {
	margin: 0 10%;
}


h3{
	display: flex;
}
.poster {
	padding-top : 50px;
	background-color : white;
	display: flex;
	justify-content: center; /* 아이템을 수평으로 가운데 정렬합니다. */
    align-items: flex-start; /* 아이템을 상단에 정렬합니다. */
    flex-wrap: wrap;
}

.poster img {
	width: 200px;
	height: 300px;
	margin: 10px;
}

.movie-item-container {
	color: black;
	font-size: 16px;
	justify-cotent: center;
	display: flex;
	flex-wrap: wrap;
	justify-content: space-around;
}

.movie-item p {
  margin: 4px 0; 
}

.movie-item {
	width: 200px;
	margin: 15px;
	text-align: center;
	position: relative;
}

 .titleword {
	padding-top : 20px;
	font-weight: bold;
	font-size: 24px;
}

.movie-rank {
  background-color: red;
  position: absolute;
  top: 15px;
  left: 10px;
  color: white;
  font-size: 18px; 
  width: 60px; 
  height: 20px; 
}

.container {
	max-width: 800px;
	margin: 0 auto;
	padding: 0 20px;
}

.movie-item img {
	width: 200px;
	height: 150px;
}

td {
	padding: 20px 10px;
}

table {
	width: 100%; /* 테이블의 너비를 100%로 설정합니다. */
}
</style>
</head>
<body>

<%@include file="../menu/menu.jsp" %>

<div class = "bigsection1">
	
	<div class = "section1">
	<div class="container">
		<table  style="background-color:#eee">
			<tr>
				<td><img src="/resources/images/profile/${dto.filename}" alt="이미지"
    onerror="this.onerror=null; this.src='/resources/images/basic.png';"
    style="border-radius: 50%; overflow: hidden;"
    width="150px" height="150px"><button onclick="openPopup()"  style= "border: none;   background: none;cursor: pointer;" >
    <img src="/resources/images/peen.png" width="50px" height="50px" ></button></td>
				<td><h3>${sessionScope.name}님 환영합니다.</h3>
					<hr> <h3>현재 고객님의 등급은 <c:choose>
						<c:when test="${dto.buy < 100000}">
						브론즈
					</c:when>
						<c:when test="${dto.buy < 200000}">
						실버
					</c:when>
						<c:when test="${dto.buy < 300000}">
						골드 
					</c:when>
					<c:when test="${dto.buy >= 300000}">
						다이아
					</c:when>
					</c:choose> 입니다.</h3>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><h2>MY COUPON</h2>
					<hr>
					<h5>영화관람권</h5>
					<hr>
					<h5>구매한 상품</h5></td>
				<td><h2>등급</h2>
					<hr>
					<h5>
						다음 등급까지 남은 점수:&nbsp;&nbsp;
					<c:choose>
    <c:when test="${dto.buy< 100000}">
        <span style="color: #CD7F32;">
            <c:out value="${100000 - dto.buy}"/>
        </span>
    </c:when>
    <c:when test="${dto.buy < 200000}">
        <span style="color: #C0C0C0;">
            <c:out value="${200000 - dto.buy}"/>
        </span>
    </c:when>
    <c:when test="${dto.buy < 300000}">
        <span style="color: #FFD700;">
            <c:out value="${300000 - dto.buy}"/>
        </span>
    </c:when>
    <c:when test="${dto.buy >= 300000}">
        <span style="color: #ADD8E6;">
            최고등급입니다!!!!!
        </span>
    </c:when>
</c:choose>
					</h5>
					<hr> <br><br><br>
				</td>
				<td></td>
			</tr>
		</table>
		<br><br>
		<table border="1" style="width: 100%;background-color:#eee" > <!-- 테이블의 너비를 100%로 설정합니다. -->
			<tr>
				<td align="center"><a href="/mypage/list.do" style="color:black"><img src="/resources/images/heart2.png"  width="100px" height="100px"><br>내가찜한 영화</a></td>
				<td align="center"><a href="#" style="color:black"><img src="/resources/images/clapboard.png" width="100px" height="100px"><br>내가 본 영화</a></td>
				<td align="center"><a href="/review/list.do" style="color:black"><img src="/resources/images/review.png" width="100px" height="100px"><br>내가 쓴 리뷰</a></td>
			</tr>
		</table>
		<a href="/ticket/list.do" style="color:black"><h2>MY 예매내역</h2></a>
		<table border="2" style="width: 100%;" > <!-- 테이블의 너비를 100%로 설정합니다. -->
			<tr>
				
			</tr>
		</table>
		<h2>MY Q&A</h2>
		<table border="2" style="width: 100%;" align="center"> <!-- 테이블의 너비를 100%로 설정합니다. -->
			<tr>
				
			</tr>
		</table>
	</div>
</div>
	
	</div>
	
		<%@ include file="../include/footer.jsp" %>

</body>

		

</html>
