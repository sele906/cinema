<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.HashMap"%>
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

<!DOCTYPE html>
<html>

<head>
<style>
body {
	margin: 0;
	font-family: Arial, sans-serif;
}

.titleword {
	padding-top: 20px;
	font-weight: bold;
	font-size: 24px;
	margin-left: 350px;
}

.section1 {
	/* background-color: black; */
	background: linear-gradient(to top, black, #333, #444);
	/*background-color: #222;*/
	/*background: linear-gradient(to right, red, black, red, black, red, black, red, black, red, black, #222, #222, #222, #222, #222, #222, #222, #222, #222, black, red, black, red, black, red, black, red, black, red);
	*/
	padding: 0px;
	width: 100%;
}

.section2 {
	background-color: white;
	/* background: linear-gradient(to right,#222, #111, black, black, black, black, black, #111, #222); */
	/*background: linear-gradient(to right, red, black, red, black, red, black, red, black, red, black, #222, #222, #222, #222, #222, #222, #222, #222, #222, black, red, black, red, black, red, black, red, black, red);
*/
	margin: 0;
	padding: 0;
	height: 475px;
}

.section3 {
	/* background-color: #222; */
	/*background: linear-gradient(to right, red, black, red, black, red, black, red, black, red, black, #222, #222, #222, #222, #222, #222, #222, #222, #222, black, red, black, red, black, red, black, red, black, red);
	*/
	background: linear-gradient(to bottom, black, #333, #444);
	padding: 0px;
	width: 100%;
}

footer {
	background-color: #eee;
}

.foot {
	margin: 0 330px;
}

/*@media ( max-width : 1600px) {
	body {
		margin: 0;
	}
}*/
header {
	margin: 0 330px;
	text-align: center;
	/* background-color: linear-gradient(to bottom, black, white); */
	/* 	background-color: linear-gradient(to top, black, #333, #888); */
	color: white;
	padding: 0px 40px 0px 40px;
	display: flex;
	justify-content: space-between;
	align-items: center;
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
	background-color: #222;
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

.poster {
	margin: 0 330px;
	background: linear-gradient(to bottom, black, #333, #444);
	/*background-color: #222; */
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
	color: white;
	font-size: 16px;
	justify-cotent: center;
	display: flex;
	flex-wrap: wrap;
	justify-content: space-around;
}

.movie-item {
	width: 200px;
	margin: 15px;
	text-align: center;
}

.movie-item p {
	margin: 4px 0; /* 각 문단의 위아래 여백을 조절 */
}

.youtube {
	padding: 0 330px;
	/*width: 100%;*/
	margin-bottom: 0;
	padding-bottom: 0;
	overflow: hidden;
}

.youtube iframe {
	width: 100%;
	height: 475px; /* 조절 가능한 높이값 설정 */
}

.image-container {
	position: relative;
	display: inline-block;
}

.image-container::before {
	content: "";
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: linear-gradient(to top, rgba(0, 0, 0, 0.5) 0%,
		rgba(0, 0, 0, 0) 100%);
	pointer-events: none;
}
</style>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SSANG YONG CINEMA</title>
<link rel="icon" href="/resources/images/icon/clearicon.ico" type="image/x-icon">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<c:if test="${param.message=='logout'}">
	<script>
		alert('로그아웃되었습니다.');
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

<style>
 .board-heading {
            text-align: center;
            margin-bottom: 20px;
        }

        .search-form {
            text-align: center;
            margin-bottom: 20px;
        }

.menu-item {
    margin: 10px; /* 버튼 간격 조절 */
}

.menu-item input[type="button"] {
    background-color: #000000; /* 검정색 배경 */
    color: white; /* 흰색 텍스트 */
    border: none; /* 테두리 제거 */
    padding: 10px 20px; /* 내부 여백 */
    cursor: pointer; /* 커서 모양 */
    font-size: 16px; /* 텍스트 크기 */
}

.menu-item input[type="button"]:hover {
    background-color: #0056b3; /* 마우스 호버 시 배경색 변경 */
}

</style>
<style>
 table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
            color: #333;
        }

</style>





</head>

<body>
	<div class="section1">


		<header>

			<div class="logo">
				<a href="/"><img src="/resources/images/icon/mainlogo2black.png"
					style="width: 250px; height: 150;"></a>
			</div>

			<c:choose>
				<c:when test='${sessionScope.userid==null}'>
					<div class="main-menu">
						<a href="/login.do"><img
							src="/resources/images/icon/login white.png"><br>로그인</a> | <a
							href="/member/register.do"><img
							src="/resources/images/icon/join white.png"><br>회원가입</a> | <a
							href="/mypage/detail.do"><img
							src="/resources/images/icon/mypage white.png"><br>마이페이지</a> | <a
							href="/cboard/index.do"><img
							src="/resources/images/icon/callcenter white.png"><br>고객센터</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="main-menu">
						${sessionScope.name}님 환영합니다. <a
							href="/member/logout.do"><img
							src="/resources/images/icon/logout white.png"><br>로그아웃</a> |<a
							href="/mypage/detail.do"><img
							src="/resources/images/icon/mypage white.png"><br>마이페이지</a> | <a
							href="/cboard/index.do"><img
							src="/resources/images/icon/callcenter white.png"><br>고객센터</a>
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
				<li><a href="/list.do" onmouseover="showMenu(5)"
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

	</div>

	
    <div class="section2" style="margin-top: 20px; margin-bottom: 20px;">
    <div class="titleword">고객센터</div>

        <div style="display: flex; justify-content: center;">
            <div class="menu-item">
                <input type="button" id="noti" value="공지사항" onclick="location.href='/cboard/index.do'">
            </div>
            <div class="menu-item">
                <input type="button" id="qna" value="자주 묻는 질문" onclick="location.href='/cboard/qnaindex.do'">
            </div>
        </div>
    </div>

<div class="section3"></div>


	<div class="section4">
		<div class="soje"
			style="width: 140px; margin: 10px 0px 30px 370px; padding-top: 50px;">
			<p
				style="color: black; margin: 0; font-size: 24px; font-weight: bold; text-align: center;">EVENT</p>
			<hr style="border: 1px solid black;">
		</div>

		<div class="adimg" style="text-align: center;">
			<button onclick="#"
				style="border: none; background: none; cursor: pointer;">
				<img src="/resources/images/adver/ad1.png"
					style="width: 350px; height: 350px; margin: 0 20px">
			</button>
			<button onclick="#"
				style="border: none; background: none; cursor: pointer;">
				<img src="/resources/images/adver/ad2.png"
					style="width: 350px; height: 350px; margin: 0 20px">
			</button>
			<button onclick="#"
				style="border: none; background: none; cursor: pointer;">
				<img src="/resources/images/adver/ad3.png"
					style="width: 350px; height: 350px; margin: 0 20px">
			</button>
		</div>
		<div
			style="text-align: center; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; width: 100%; font-size: 18px; font-weight: bold;">
			<div style="display: inline-block; margin: 0 20px; width: 350px">
				<p>통신사 혜택으로 쌍용시네마에서 할인받자 !!</p>
			</div>
			<div style="display: inline-block; margin: 0 20px; width: 350px">
				<p>톡학생증 발급하면 쌍용시네마 영화 할인</p>
			</div>
			<div style="display: inline-block; margin: 0 20px; width: 350px">
				<p>쌍용시네마에서만 즐길 수 있는 무비퀘스트 !</p>
			</div>
		</div>
	</div>



	<footer style="background: #eee; margin: 0; padding: 50px 0 50px 0">
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