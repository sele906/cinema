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
$(function(){
	hideMenu(1);	
	hideMenu(2);	
	hideMenu(3);	
	hideMenu(4);	
	hideMenu(5);	
});
	function showMenu(menuNum) {
	    // 숨겨진 모든 서브메뉴를 숨김
	    for (let i = 1; i <= 5; i++) {
	        hideMenu(i);
	    }
	    // 선택된 메뉴의 서브메뉴를 표시
	    document.getElementById("submenu"+menuNum).style.display = "block";
	}
	function hideMenu(menuNum) {
		document.getElementById("submenu"+menuNum).style.display = "none";
	}
	function keepShow(menuNum) {
	    clearTimeout(hideMenuTimeout);
	}

	function hideDelay(menuNum) {
	    hideMenuTimeout = setTimeout(function() {
	        hideMenu(menuNum);
	    }, 200); // 딜레이
	}
	
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
margin : 0 330px;
padding : 0 0 200px 0;
}

margin: 0 330px;
}

footer {
background-color: #eee;
}

.foot {
margin: 0 330px;
background-color: #eee;
}

header {
background-color : black;
margin: 0 330px;
	text-align:center;
	
	color: white;
	padding: 0px 40px 0px 40px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	/*box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); /*그림자 효과야*/ */
	bottom : 0;
}

.logo img {
	width: 150px;
	height: auto;
	
}

.logo2 {
  display: inline-block; /* 가로로만 공간을 차지하도록 설정합니다. */
}

.logo2 img {
  display: block;
  margin: 0 auto;
  padding-top: 100px;
  padding-left: 120px;
}

.main-menu {
	display: flex;
	gap: 5px;
	font-size: 16px;
	padding-top : 100px;
}

.main-menu a {
	color: white;
	text-decoration: none;
	font-weight: bold;
	font-size: 16px;
	transition: color 0.3s ease;
}

.main-menu a:hover {
	color: #ffcc00;
}

.bigmenu {
margin: 0 330px;
	background-color: #333;
	color: white;
	padding: 10px 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.bigmenu ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigmenu ul li {
position: relative;
	margin-right: 5px;
	padding : 0 40px;
	font-weight: bold;
	transition: color 0.3s ease;
	white-space: nowrap;
}

.bigmenu ul li a {
	color: white;
	text-decoration: none;
	font-weight: bold;
	transition: color 0.3s ease;
}

.bigmenu ul li a:hover {
	color: #ffcc00;
}

.combo-box {
	position: relative;
	cursor: pointer;
}

.submenu {
	display: none;
	position: absolute;
	direction: row;
	top: 100%;
	left: 0;
	background-color: #555;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
	list-style: none;
	padding: 0px;
	display: flex;
	 flex-wrap: wrap;
	 /*justify-content: space-between;*/
}


.submenu a {
	color: white;
	text-decoration: none;
	display: block;
	padding: 1px 1px;
	transition: background-color 0.3s ease;
}

.submenu a:hover {
	background-color: #777;
}

.search {
	margin-left: auto;
	display: flex;
	align-items: center;
}

.search input {
	padding: 8px;
	border: none;
	border-radius: 4px;
	margin-right: 10px;
}

.search button {
	border: none;
	background: url('search-icon.png') no-repeat center center;
	background: cover;
	width: 20px;
	height: 20px;
	cursor: pointer;
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

<div class = "bigsection1">

<header>

		<div class="logo">
			<a href="/"><img src="/resources/images/icon/mainlogo2black.png" style="width: 250px; height: 150;">
		</div>
		
<c:choose>
<c:when test='${sessionScope.userid==null}'>
			<div class="main-menu">
				<a href="/member/login.do"><img src="/resources/images/icon/login white.png"><br>로그인</a>
				| <a href="/member/register.do"><img src="/resources/images/icon/join white.png"><br>회원가입</a> | 
				<a href="/member/login.do"><img src="/resources/images/icon/mypage white.png"><br>마이페이지</a> | <a
					href="../Mypage/customercenter.jsp"><img src="/resources/images/icon/callcenter white.png"><br>고객센터</a>
			</div>
			</c:when>
			<c:otherwise>
			<div class="main-menu">
		     ${sessionScope.name}님 환영합니다.
				<a href="/member/logout.do"><img src="/resources/images/icon/logout white.png"><br>로그아웃</a>
				|<a href="/mypage/detail.do"><img src="/resources/images/icon/mypage white.png"><br>마이페이지</a> | 
				<a href="../Mypage/customercenter.jsp"><img src="/resources/images/icon/callcenter white.png"><br>고객센터</a>
			</div>
			</c:otherwise>
			</c:choose>
			
	</header>
	<nav class="bigmenu">
			<ul>
				<li><a href="/moviechart.do" onmouseover="showMenu(1)"
					onmouseout="hideDelay(1)" onmousemove="keepShow(1)">예매</a>
					<ul class="submenu" id="submenu1" onmouseover="keepShow(1)"
						onmouseout="hideDelay(1)">
						<li><a href="/moviechart.do">영화먼저</a></li>
						<li><a href="/findcinema.do">극장먼저</a></li>
					</ul></li>
				<li><a href="/moviechart.do" onmouseover="showMenu(2)"
					onmouseout="hideDelay(2)" onmousemove="keepShow(2)">영화</a>
					<ul class="submenu" id="submenu2" onmouseover="keepShow(2)"
						onmouseout="hideDelay(2)">
						<li><a href="/moviechart.do">영화 예매</a></li>
						<li><a href="/moviechart.do">상영중인 영화</a></li>
					</ul></li>
				<li><a href="/findcinema.do" onmouseover="showMenu(3)"
					onmouseout="hideDelay(3)" onmousemove="keepShow(3)">극장</a>
					<ul class="submenu" id="submenu3" onmouseover="keepShow(3)"
						onmouseout="hideDelay(3)">
						<li><a href="/findcinema.do">극장 예매</a></li>
						<li><a href="/findcinema.do">쌍용시네마 찾기</a></li>
					</ul></li>
				<li><a href="../store/index.jsp" onmouseover="showMenu(4)"
					onmouseout="hideDelay(4)" onmousemove="keepShow(4)">스토어</a>
					<ul class="submenu" id="submenu4" onmouseover="keepShow(4)"
						onmouseout="hideDelay(4)">
						<li><a href="#">팝콘, 매점</a></li>
						<li><a href="#">굿즈</a></li>
					</ul></li>
				<li><a href="../show/index.jsp" onmouseover="showMenu(5)"
					onmouseout="hideDelay(5)" onmousemove="keepShow(5)">이벤트/혜택</a>
					<ul class="submenu" id="submenu5" onmouseover="keepShow(5)"
						onmouseout="hideDelay(5)">
						<li><a href="#">진행중인 이벤트</a></li>
						<li><a href="#">기프티콘</a></li>
					</ul></li>
			</ul>
		
		<div class=search>
			<input type="text" name="search" size="50">
			<button style="border: none; background: none;"></button>
		</div>
	</nav>
	
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
	
<footer style="background : #eee; margin:0; padding : 150px 0 50px 0">
		<div class = "foot" >
			<hr style="border: 1px solid #ccc; margin: 0 0 50px 0;">
		    <div style=" color: #666; padding: 10px; line-height: 0.7; font-size : 12px">
		        <p>&copy; 2024 SSANG YONG CINEMA. All rights reserved.</p>
		        <p>(04377)서울특별시 용산구 한강대로 23길 55, 아이파크몰 6층(한강로동)</p>
		        <p>대표이사 : 한승찬  /  사업자등록번호 : 104-81-45690  /  통신판매업신고번호 : 2017-서울용산-0662 사업자정보확인</p>
		        <p>호스팅사업자 : 쌍용엔터테이먼트  /  대표이메일 : hanseung@naver.com</p>
		        <div style="margin-top: 10px;">
		            <a href="#">Terms of Service</a> | <a href="#">Privacy Policy</a>
		        </div>
		    </div>
	    </div>
</footer>
</body>

		

</html>
