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
	margin: 0; /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	padding: 0px;
	width: auto;
}

.moviesection {
	background-color: #333;
	padding: 40px 330px 10px 330px; /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
}

header {
	width: 100%;
	padding: 0;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

#M_content {
	width: 75%;
	margin: 0 10%;
	text-align: center;
	background-color: white;
	color: white;
	padding: 20px 40px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	/*box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); /*그림자 효과야*/ */
	bottom: 0;

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
	padding: 50px 0 0 0;
}

.main-menu a {
	color: black;
	text-decoration: none;
	font-weight: bold;
	font-size: 16px;
	transition: color 0.3s ease;
}

.main-menu a:hover {
	color: #ffcc00;
}

.bigmenu {
	margin: 0 10%;
	width: 75%;
	background-color: #333;
	color: white;
	padding: 10px 40px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigmenu ul {
	width: 100%;
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
	padding: 0 5%;
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
</style>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	$(function() {
		hideMenu(1);
		hideMenu(2);
		hideMenu(3);
		hideMenu(4);
	});
	function showMenu(menuNum) {
		// 숨겨진 모든 서브메뉴를 숨김
		for (let i = 1; i <= 4; i++) {
			hideMenu(i);
		}
		// 선택된 메뉴의 서브메뉴를 표시
		document.getElementById("submenu" + menuNum).style.display = "block";
	}
	function hideMenu(menuNum) {
		document.getElementById("submenu" + menuNum).style.display = "none";
	}
	function keepShow(menuNum) {
		clearTimeout(hideMenuTimeout);
	}

	function hideDelay(menuNum) {
		hideMenuTimeout = setTimeout(function() {
			hideMenu(menuNum);
		}, 100); // 딜레이
	}
</script>

<body>
	<header>

		<div id="M_content">
		
				<div class="logo">
					<a href="/"><img
						src="/resources/images/icon/mainlogo2white.png"
						style="width: 250px; height: 150;">
				</div>
		
				<c:choose>
					<c:when test='${sessionScope.userid==null}'>
						<div class="main-menu">
							<a href="/login.do"><img
								src="/resources/images/icon/login black.png"><br>로그인</a> | <a
								href="/member/register.do"><img
								src="/resources/images/icon/join black.png"><br>회원가입</a> | <a
								href="/mypage/detail.do"><img
								src="/resources/images/icon/mypage black.png"><br>마이페이지</a> | <a
								href="/cboard/main.do"><img
								src="/resources/images/icon/callcenter black.png"><br>고객센터</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="main-menu">
							${sessionScope.name}님 환영합니다. <a
								href="/member/logout.do"><img
								src="/resources/images/icon/logout black.png"><br>로그아웃</a> |<a
								href="/mypage/detail.do"><img
								src="/resources/images/icon/mypage black.png"><br>마이페이지</a> | <a
								href="/cboard/main.do"><img
								src="/resources/images/icon/callcenter black.png"><br>고객센터</a>
						</div>
					</c:otherwise>
				</c:choose>
		
		</div>
		
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
					<!-- <li><a href="../store/index.jsp" onmouseover="showMenu(4)"
						onmouseout="hideDelay(4)" onmousemove="keepShow(4)">스토어</a>
						<ul class="submenu" id="submenu4" onmouseover="keepShow(4)"
							onmouseout="hideDelay(4)">
							<li><a href="#">팝콘, 매점</a></li>
							<li><a href="#">굿즈</a></li>
						</ul></li> -->
					<li><a href="/list.do" onmouseover="showMenu(4)"
						onmouseout="hideDelay(4)" onmousemove="keepShow(4)">이벤트/혜택</a>
						<ul class="submenu" id="submenu4" onmouseover="keepShow(4)"
							onmouseout="hideDelay(4)">
							<li><a href="/list.do">진행중인 이벤트</a></li>
							<li><a href="/list.do">기프티콘</a></li>
						</ul></li>
				</ul>
		
				<div class=search>
					<input type="text" name="search" size="50">
					<button style="border: none; background: none;"></button>
				</div>
			</nav>

	</header>

	
</body>