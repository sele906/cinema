<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.io.IOException"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@ page import="com.example.cinema.api.ApiCaller"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>

<head>
<script>
	function openPopup1() {
		// 팝업 창을 띄우기
		window.open("/member/idsearch.do", 'edit', 'width=550, height=450');
	}
	function openPopup2() {
		// 팝업 창을 띄우기
		window.open("/member/pwsearch.do", 'edit', 'width=550, height=450');
	}
</script>
<style>
body {
	/* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	font-family: Arial, sans-serif;
	background-color: white;
}

.section1 {
	margin: 50px 0 150px 0;
}

footer {
	background-color: #eee;
}

.foot {
	margin: 0 330px;
}

header {
	margin: 0 330px;
	text-align: center;
	background-color: white;
	color: black;
	font-weight: bold;
	padding: 0px 40px 0px 40px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	/*box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); /*그림자 효과야*/ */
	bottom: 0;
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
	padding-top: 100px;
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
	padding: 0 40px;
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

.titleword {
	padding-top: 20px;
	font-weight: bold;
	font-size: 24px;
}

.downimg {
	position: relative;
	display: block;
	margin: 0px auto;
	width: 60%;
	height: 60%;
}

.sideimg {
	position: absolute;
	top: 320px;
	right: 50px;
}

.close-button {
	position: absolute;
	top: 8px;
	right: 10px;
	cursor: pointer;
}

form {
	width: 360px;
	background-color: #eee;
	padding: 20px;
	border-radius: 5px;
	/* box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); */
}

#loginForm  input[type="text"], #loginForm  input[type="password"],
	#loginForm  input[type="submit"] {
	border: 1px solid #777;
	border-radius: 3px;
	box-sizing: border-box;
}

#loginForm input[type="submit"] {
	background-color: #cc0000;
	color: #fff;
	cursor: pointer;
	transition: background-color 0.3s;
}

#loginForm  input[type="submit"]:hover {
	background-color: #660000;
}

.blue p {
	text-align: center;
	margin-top: 10px;
}

.blue a {
	color: #black;
	text-decoration: none;
}
</style>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<link rel="icon" href="../images/clearicon.ico" type="image/x-icon">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- SweetAlert2 스크립트 먼저 호출 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- 그 다음에 스위트 얼럿을 표시하는 스크립트 호출 -->
<c:if test='${message=="error"}'>
    <script>
        alert("아이디 혹은 비밀번호가 잘못되었습니다.")
    </script>
</c:if>

<script>
	$(function() {
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
		}, 200); // 딜레이
	}
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="/resources/images/icon/clearicon.ico" type="image/x-icon">
</head>


<body>
	<header>

		<div class="logo">
			<a href="/"><img
				src="/resources/images/icon/mainlogo2white.png"
				style="width: 250px; height: 150;"></a>
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

	</header>

	<nav class="bigmenu">
		<ul>
			<li><a href="#" onmouseover="showMenu(1)"
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

	<div class=section1
		style="display: flex; justify-content: center; align-items: center; background: #eee">



		<div
			style="display: flex; align-items: center; margin: 50px 0 50px 0;">
			<div>
				<div class=titleword>로그인</div>
				<hr style="border: 1px solid #ccc; margin: 10px 0;">

				<form id="loginForm" method="post"
					action="/member/login.do">

					<div style="display: flex; align-items: center;">
						<div style="width: 260px;">
							<input name="userid" placeholder="아이디를 입력하세요"
								style="width: 242px; height: 40px; margin-bottom: 5px;">
							<input type="password" name="pwd1" placeholder="비밀번호를 입력하세요"
								style="width: 250px; height: 41px;">
						</div>
						<div>
							<input type="submit" value="로그인"
								style="width: 90px; height: 90px; margin: 0 5px; font-size: 18px; font-weight: bold;">
						</div>
					</div>
					<p class="blue"
						style="display: flex; justify-content: center; align-items: center; margin: 20px 0 0 0;">
						<a href="/member/register.do" style="font-size: 13px; color: black">회원가입</a>&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;
						<button onclick="openPopup1()"
							style="border: none; background: none; cursor: pointer;">
							아이디찾기</button>
						&nbsp;&nbsp;/&nbsp;&nbsp;
						<button onclick="openPopup2()"
							style="border: none; background: none; cursor: pointer;">
							비밀번호찾기</button>

					</p>
				</form>

			</div>
			<div>
				<img src="/resources/images/adver/ad6.png"
					style="width: 480px; height: 240px; margin-left: 80px">
			</div>
		</div>

	</div>


	<div class="section5" style="background-color: #3a4b3b;">
		<div class="downimg">

			<img src="/resources/images/adver/ad5.png" style="width: 100%; height: 100%;">
		</div>
	</div>







	<script>
		function closeimg1() {
			// 이미지를 감싸고 있는 요소의 display 속성을 'none'으로 설정하여 숨깁니다.
			document.querySelector('.downimg').style.display = 'none';
		}

		function closeimg2() {
			// 이미지를 감싸고 있는 요소의 display 속성을 'none'으로 설정하여 숨깁니다.
			document.querySelector('.sideimg').style.display = 'none';
		}
	</script>

	<footer style="background: #eee; margin: 0; padding: 100px 0 50px 0">
		<div class="foot">
			<hr style="border: 1px solid #ccc; margin: 0 0 50px 0;">
			<div
				style="color: #666; padding: 10px; line-height: 0.7; font-size: 12px">
				<p>&copy; 2024 SSANG YONG CINEMA. All rights reserved.</p>
				<p>(04377)서울특별시 용산구 한강대로 23길 55, 아이파크몰 6층(한강로동)</p>
				<p>대표이사 : 한승찬 / 사업자등록번호 : 104-81-45690 / 통신판매업신고번호 :
					2017-서울용산-0662 사업자정보확인</p>
				<p>호스팅사업자 : 쌍용엔터테이먼트 / 대표이메일 : hanseung@naver.com</p>
				<div style="margin-top: 10px;">
					<a href="#">Terms of Service</a> | <a href="#">Privacy Policy</a>
				</div>
			</div>
		</div>
	</footer>

</body>

</html>