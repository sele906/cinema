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
<!DOCTYPE html>

<html>
<head>

<style>
body {
	margin: 0;
	/* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	font-family: Arial, sans-serif;
	/*background-color: white;*/
	background: linear-gradient(to right, red, black, red, black, red, black, red, black
		, red, black, #222, #222, #222, #222, #222, #222, #222, #222, #222,
		black, red, black, red, black, red, black, red, black, red);
}

@media ( max-width : 1600px) {
	body {
		margin: 0px;
	}
}

footer {
	margin: 0 10%;
}

.foot {
	margin: 0 10%;
}

header {
	margin: 0 10%;
	text-align: center;
	background-color: white;
	color: white;
	padding: 0px 40px 0px 40px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	/*box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); /*그림자 효과야*/ */
	bottom: 0;
}

.section1 {
	padding: 30px;
	margin: 0 10%;
	background: white;
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
	padding: 20px 0 30px 0;
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
	background-color: #333;
	color: white;
	padding: 10px 20px;
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

.selectcity {
	
}

.allcinema {
	max-width: 1200px;
	margin: 0 auto;
	background-color: #fff;
	padding: 20px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	border-radius: 10px;
	position: relative;
}


.allcinema2 {
	border: 5px solid black;
}

.selectcity ul {
	list-style: none;
	padding: 0;
	margin: 0;
	display: flex;
}

.selectcity li {
	font-size: 20px;
	font-weight: bold;
	margin-right: 20px;
	display: inline;
}

.citylist {
	list-style: none;
	padding: 0;
	margin: 0;
	display: flex;
	justify-content: space-around;
	align-items: center;
}

.citylist li {
	margin: 0 20px;
	font-size: 20px;
	font-weight: bold;
	cursor: pointer;
	padding: 10px;
	transition: color 0.3s ease;
	position: relative; /* 추가된 부분 */
}

.citylist li:after {
	content: "";
	position: absolute;
	top: 50%;
	right: -22px;
	height: 50%;
	border-right: 1px solid #aaa;
	transform: translateY(-50%);
}

.citylist li:last-child:after {
	display: none;
}

.citylist li:hover {
	color: #d10000;
}

.theater {
	display: none;
}

.theater.active {
	display: block;
}

.theater li {
	list-style: none;
	display: inline;
	font-size: 20px;
	font-weight: bold;
	margin: 0 10px;
	cursor: pointer;
	transition: color 0.3s ease;
	position: relative;

}

.theater li:after {
	content: "";
	position: absolute;
	top: 50%;
	right: -13px;
	height: 50%;
	border-right: 1px solid #aaa;
	transform: translateY(-50%);
}

.theater li:last-child:after {
	display: none; /* 마지막 링크 뒤에 선을 표시하지 않도록 설정 */
}

.theater li:hover {
	color: #d10000;
}

.namephoto {
	display: none;
}

.namephoto.active {
	display: block;
}

.linetext {
	margin-top: 100px;
	text-align: center;
	position: relative;
}

.npline {
	border-top: 2px solid #aaa;
	margin: 8px 0;
}

.nptext {
	font-size: 48px;
	font-weight: bold;
	color: #cc0000;
	background-color: white; /* 배경색을 흰색으로 설정 */
	padding: 0 10px; /* 텍스트 주위에 여백 추가 */
	position: absolute;
	top: -20px; /* 선 위에 위치하도록 설정 */
	left: 50%;
	transform: translateX(-50%);
}

#datebutton button {
	margin: 5px 3px;
	padding: 8px;
	cursor: pointer;
	font-size: 14px;
	font-weight: bold;
}

#datebutton button.selected {
	background-color: #eee;
	color: #d10000;
}

.citylist li.selected {
	color: #d10000;
	/* 다른 스타일도 필요한 경우 여기에 추가 */
}

.time-slot-buttons button {
	border: 1px solid #000;
	background-color: #fff;
	color: #000;
	padding: 10px;
	margin: 15px 0;
	border-radius: 5px;
	font-size: 16px;
}

.time-slot-buttons button:hover {
	background-color: #ddd;
}
</style>

<meta charset="UTF-8">
<title>극장 선택</title>
<link rel="icon" href="/resources/images/icon/clearicon.ico" type="image/x-icon">
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
		}, 200); // 딜레이
	}
	function bookfalse(){
		var confirmation = confirm("로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?");
	    if (confirmation) {
	        // 사용자가 확인을 누른 경우 로그인 페이지로 이동
	        window.location.href = "/login.do"; // 로그인 페이지의 URL로 수정
	    } else {
	        // 사용자가 취소를 누른 경우 현재 페이지 유지
	        return;
	    }
	}
	function bookTicket(movieCd, timeSlot, currentRoom) {

		var cinema_place = document.querySelector('.namephoto.active h1').textContent;
		cinema_place = cinema_place.replace(/\s/g, '');
		var roomNumber = currentRoom.match(/\d+/)[0]; //room1 > 1로 바꾸는 정규표현식
		var selectedButton = document
				.querySelector('#datebutton button.selected').textContent;

		var month = selectedButton.substring(0, 2);
		var day = selectedButton.substring(4, 6);

		//날짜 합치기
		var date = "2024" + '-' + month + '-' + day + " " + timeSlot;

		document.getElementById('cinema_place').value = cinema_place;
		document.getElementById('movieCd').value = movieCd;
		document.getElementById('time1').value = date;
		document.getElementById('theater_num').value = roomNumber;

		document.form2.submit();
	}
</script>

</head>
<body>

	<header>

		<div class="logo">
			<a href="/"><img src="/resources/images/icon/mainlogo2white.png"
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
						href="../Mypage/customercenter.jsp"><img
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
						href="../Mypage/customercenter.jsp"><img
						src="/resources/images/icon/callcenter black.png"><br>고객센터</a>
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

	<div class=section1>
		<div class=titleword>극장별 예매</div>

		<hr style="border: 1px solid #ccc; margin: 10px 0;">

		<script>
			function showlist(city) {
				// 모든 목록 숨김
				document.querySelectorAll('.theater').forEach(
						function(theater) {
							theater.classList.remove('active');
						});

				// 선택한목록 표시
				document.getElementById(city).classList.add('active');
			}
		</script>
		<script>
			function showlist2(namto) {
				// 모든 목록 숨김
				document.querySelectorAll('.namephoto').forEach(
						function(namephoto) {
							namephoto.classList.remove('active');
						});

				// 선택한목록 표시
				document.getElementById(namto).classList.add('active');
			}
		</script>

		<script>
			//도시 리스트 글씨 바꾸는거
			document.addEventListener("DOMContentLoaded", function() {
				var cityListItems = document.querySelectorAll('.citylist li');

				cityListItems.forEach(function(item) {
					item.addEventListener('click', function() {
						// 모든 리스트 아이템의 클래스 제거
						cityListItems.forEach(function(li) {
							li.classList.remove('selected');
						});

						// 선택된 리스트 아이템에 클래스 추가
						item.classList.add('selected');

						// 기존 스크립트 내용을 여기에 추가
						var cityCode = item.getAttribute('onclick').match(
								/showlist\('(\w+)'\)/)[1];
						showlist(cityCode);
					});
				});
			});
		</script>


		<div class="allcinema" style="background-color:#333; color:white;">
			<div class="allcinema2">
				<h2 style="padding: 0 40px;">전체 극장</h2>
				<hr style="border: 1px solid #ccc; margin: 10px 0;">
				<ul class="citylist">

					<li onclick="showlist('c1')">서울</li>
					<li onclick="showlist('c2')">경기</li>
					<li onclick="showlist('c3')">인천</li>
					<li onclick="showlist('c4')">강원</li>
					<li onclick="showlist('c5')">충청/대전</li>
					<li onclick="showlist('c6')">경상/대구</li>
					<li onclick="showlist('c7')">부산/울산</li>
					<li onclick="showlist('c8')">전라/광주</li>
					<li onclick="showlist('c9')">제주</li>
				</ul>


				<hr style="border: 1px solid #ccc; margin: 10px 0;">

				<script>
					$(document).ready(
							function() {
								$("#c1").on("click", function() {
									$("html").fadeOut(25).fadeIn(25); // 페이지 깜빡임
									$("html, body").animate({
										scrollTop : 0
									}, 0); // 페이지 젤 위로
								});
								$("#datebutton").on(
										"click",
										function() {
											$("#datebutton, #movieinfo, #dfd")
													.fadeOut(25).fadeIn(25); // 페이지 깜빡임
										});
							});
				</script>

				<div id="c1" class="theater active">
					<ul>
						<li onclick="showlist2('t1')">SYC강남</li>
						<li onclick="showlist2('t2')">SYC건대</li>
						<li onclick="showlist2('t3')">SYC대학로</li>
						<li onclick="showlist2('t4')">SYC명동</li>
						<li onclick="showlist2('t5')">SYC압구정</li>
						<li onclick="showlist2('t6')">SYC여의도</li>
						<li onclick="showlist2('t7')">SYC용산</li>
						<li onclick="showlist2('t8')">SYC잠실</li>
						<li onclick="showlist2('t9')">SYC홍대</li>
					</ul>
				</div>

				<div id="c2" class="theater">
					<ul>
						<li>SYC성남</li>
						<li>SYC고양</li>
						<li>SYC부천</li>
						<li>SYC의정부</li>
						<li>SYC구리</li>
					</ul>
				</div>

				<div id="c3" class="theater">
					<ul>
						<li>SYC인천</li>
						<li>SYC부평</li>
						<li>SYC송도</li>
					</ul>
				</div>

				<div id="c4" class="theater">
					<ul>
						<li>SYC강릉</li>
						<li>SYC춘천</li>
						<li>SYC속초</li>
					</ul>
				</div>

				<div id="c5" class="theater">
					<ul>
						<li>SYC대전</li>
						<li>SYC세종</li>
						<li>SYC청주</li>
					</ul>
				</div>

				<div id="c6" class="theater">
					<ul>
						<li>SYC대구</li>
						<li>SYC경주</li>
						<li>SYC창원</li>
						<li>SYC김해</li>
					</ul>
				</div>

				<div id="c7" class="theater">
					<ul>
						<li>SYC부산</li>
						<li>SYC광안리</li>
						<li>SYC울산</li>
					</ul>
				</div>

				<div id="c8" class="theater">
					<ul>
						<li>SYC광주</li>
						<li>SYC순천</li>
						<li>SYC여수</li>
						<li>SYC목포</li>
					</ul>
				</div>

				<div id="c9" class="theater">
					<ul>
						<li>SYC제주</li>
						<li>SYC서귀포</li>
					</ul>
				</div>

			</div>
		</div>
		<div class="linetext">
			<div class="npline"></div>
			<div class="npline"></div>
			<div class="nptext">
				<img src="/resources/images/icon/theaterlogo.png"
					style="width: 200px; height: 150;">
			</div>
		</div>

		<div id="t1" class="namephoto active">
			<h1 style="margin: 40px 0 0 30px; text-align: left;">SYC 강남</h1>
			<img src="/resources/images/cinemaimg/gangnam.png"
				style="width: 100%; margin-top: 10px;">
		</div>

		<div id="t2" class="namephoto">
			<h1 style="margin: 40px 0 0 30px; text-align: left;">SYC 건대</h1>
			<img src="/resources/images/cinemaimg/gunde.png"
				style="width: 100%; margin-top: 10px;">
		</div>

		<div id="t3" class="namephoto">
			<h1 style="margin: 40px 0 0 30px; text-align: left;">SYC 대학로</h1>
			<img src="/resources/images/cinemaimg/dehakro.png"
				style="width: 100%; margin-top: 10px;">
		</div>

		<div id="t4" class="namephoto">
			<h1 style="margin: 40px 0 0 30px; text-align: left;">SYC 명동</h1>
			<img src="/resources/images/cinemaimg/mungdong.png"
				style="width: 100%; margin-top: 10px;">
		</div>

		<div id="t5" class="namephoto">
			<h1 style="margin: 40px 0 0 30px; text-align: left;">SYC 압구정</h1>
			<img src="/resources/images/cinemaimg/apgujung.png"
				style="width: 100%; margin-top: 10px;">
		</div>

		<div id="t6" class="namephoto">
			<h1 style="margin: 40px 0 0 30px; text-align: left;">SYC 여의도</h1>
			<img src="/resources/images/cinemaimg/yeouido.png"
				style="width: 100%; margin-top: 10px;">
		</div>

		<div id="t7" class="namephoto">
			<h1 style="margin: 40px 0 0 30px; text-align: left;">SYC 용산</h1>
			<img src="/resources/images/cinemaimg/yongsan.png"
				style="width: 100%; margin-top: 10px;">
		</div>

		<div id="t8" class="namephoto">
			<h1 style="margin: 40px 0 0 30px; text-align: left;">SYC 잠실</h1>
			<img src="/resources/images/cinemaimg/jamsil.png"
				style="width: 100%; margin-top: 10px;">
		</div>

		<div id="t9" class="namephoto">
			<h1 style="margin: 40px 0 0 30px; text-align: left;">SYC 홍대</h1>
			<img src="/resources/images/cinemaimg/hongde.png"
				style="width: 100%; margin-top: 10px;">
		</div>


		<h1 id="dfd">날짜별 예매</h1>
		<div id="datebutton"></div>
		<script>
			document
					.addEventListener(
							"DOMContentLoaded",
							function() {
								var dateButtonsContainer = document
										.getElementById('datebutton');
								var currentDate = new Date();

								for (var i = 0; i < 7; i++) {
									var date = new Date(currentDate);
									date.setDate(currentDate.getDate() + i);

									//var year = date.getFullYear();
									var month = (date.getMonth() + 1)
											.toString().padStart(2, '0');
									var day = date.getDate().toString()
											.padStart(2, '0');
									var dayOfWeek = [ '일', '월', '화', '수', '목',
											'금', '토' ][date.getDay()];

									var dateString = /*year + '년 ' +*/month
											+ '월 ' + day + '일 (' + dayOfWeek
											+ ')';
									var button = document
											.createElement('button');
									button.textContent = dateString;

									button
											.addEventListener(
													'click',
													function(event) {
														var selectedDate = event.target.textContent;

														// 모든 버튼의 클래스 제거
														var buttons = document
																.querySelectorAll('#datebutton button');
														buttons
																.forEach(function(
																		btn) {
																	btn.classList
																			.remove('selected');
																});

														// 선택된 버튼에 클래스 추가
														event.target.classList
																.add('selected');

														// 선택한 날짜를 웹 페이지에 표시
														var resultContainer = document
																.getElementById('result');
														resultContainer.textContent = '< '+selectedDate +' 영화 입니다 >';
													});

									dateButtonsContainer.appendChild(button);

									if (i === 0) {
										button.click(); // 오늘 날짜 버튼에 대해 클릭을 시뮬레이트
									}
								}
							});
		</script>
		<div id="result"
			style="font-size: 24px; font-weight: bold; margin-top: 40px"></div>
		<hr style="border: 1px solid #ccc; margin: 10px 0 40px 0;">

		<div id="movieinfo" style="margin-top: 20px;">

			<%
			// 오늘 날짜 가져오기
			Calendar calendar = Calendar.getInstance();
			Date today = calendar.getTime();

			// 오늘 날짜에서 하루를 뺀 어제 날짜 가져오기
			calendar.add(Calendar.DAY_OF_YEAR, -1);
			Date yesterday = calendar.getTime();

			// "yyyyMMdd" 형식으로 날짜 포맷팅
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
			String yesterdayFormatted = dateFormat.format(yesterday);

			// API 호출에 필요한 정보 설정
			String apiUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";
			String apiKey = "f13c0057896b0be1847c420d8c9d265b"; // 실제 API 키로 교체

			// 매개변수 설정 (필요에 따라 수정)
			Map<String, String> params = new HashMap<>();
			params.put("key", apiKey);
			params.put("targetDt", "20240303");
			try {
				// API 호출
				String apiResponse = ApiCaller.callApi(apiUrl, params);

				// JSON 파싱을 위한 JSONObject 사용
				JSONParser parser = new JSONParser();
				JSONObject jsonResponse = (JSONObject) parser.parse(apiResponse);

				// 필요한 데이터 추출
				JSONObject boxOfficeResult = (JSONObject) jsonResponse.get("boxOfficeResult");
				JSONArray dailyBoxOfficeList = (JSONArray) boxOfficeResult.get("dailyBoxOfficeList");
			%>
			<div class="poster">



				<%
				// 최대 6개의 영화만 표시
				int maxMoviesToShow = 10;
				int movieCount = 0;
				%>

				<div class="movie-item-container" style="margin: 0;">
					<%
					// 영화 정보를 테이블에 출력
					for (Object movie : dailyBoxOfficeList) {
						JSONObject movieObj = (JSONObject) movie;
						String movieTitle = (String) movieObj.get("movieNm"); // 영화 제목
						String movieCd = (String) movieObj.get("movieCd"); // 영화 코드
						String rank = (String) movieObj.get("rank"); // 영화 순위
					%>

					<div class="movie-item" style="position: relative;">
						<img src="/resources/images/poster/<%=movieCd%>.jpg"
							style="width: 200px; height: 150;"><br>
						<p style="font-size: 24px; font-weight: bold; display: inline;"><%=movieTitle%></p>
						<c:choose>
							<c:when test="${sessionScope.userid!=null}">
								<button onclick="gomoviedetail('<%=movieCd%>')"
									style="display: inline;">영화정보</button>
							</c:when>
							<c:otherwise>
								<button onclick="gomovie('<%=movieCd%>')"
									style="display: inline;">영화정보</button>
							</c:otherwise>
						</c:choose>
						<br>
						<br>

						<script>
							function gomoviedetail(movieCd) {
								// moviedetail.jsp 페이지로 이동하는 코드
								window.location.href = '/like/heart.do?movieCd='
										+ movieCd;
							}
							function gomovie(movieCd) {
								/* window.location.href = '/moviedetail.jsp?movieCd='
										+ movieCd; */
								window.location.href = '/like/heart.do?movieCd='
									+ movieCd;
							}
						</script>

						<%
						String[] timeSlots = null;
						String[] room = null;

						if (rank.equals("1")) {
							room = new String[] { "room1", "room2", "room3" };
						} else if (rank.equals("2")) {
							room = new String[] { "room4", "room5" };
						} else if (rank.equals("3")) {
							room = new String[] { "room6" };
						} else if (rank.equals("4")) {
							room = new String[] { "room7" };
							timeSlots = new String[] { "9:50", "15:30", "20:40" };
						} else if (rank.equals("5")) {
							room = new String[] { "room8" };
							timeSlots = new String[] { "13:20", "19:10" };
						} else if (rank.equals("6")) {
							room = new String[] { "room9" };
							timeSlots = new String[] { "14:00", "20:30" };
						} else if (rank.equals("7")) {
							room = new String[] { "room7" };
							timeSlots = new String[] { "11:50", "17:50" };
						} else if (rank.equals("8")) {
							room = new String[] { "room8" };
							timeSlots = new String[] { "10:00", "16:40" };
						} else if (rank.equals("9")) {
							room = new String[] { "room9" };
							timeSlots = new String[] { "11:10", "17:20" };
						} else if (rank.equals("10")) {
							room = new String[] { "room7" };
							timeSlots = new String[] { "21:00" };
						}
						%>

						<div class="time-buttons">
							<%
							for (String currentRoom : room) {
							%>
							<div class="room-container">
								<div class="room-label">
									<%
									// 변수명에는 영어를 사용하고, 출력할 때 한글로 변환
									if (currentRoom.equals("room1")) {
										out.print("1관");
									} else if (currentRoom.equals("room2")) {
										out.print("2관");
									} else if (currentRoom.equals("room3")) {
										out.print("3관");
									} else if (currentRoom.equals("room4")) {
										out.print("4관");
									} else if (currentRoom.equals("room5")) {
										out.print("5관");
									} else if (currentRoom.equals("room6")) {
										out.print("6관");
									} else if (currentRoom.equals("room7")) {
										out.print("7관");
									} else if (currentRoom.equals("room8")) {
										out.print("8관");
									} else if (currentRoom.equals("room9")) {
										out.print("9관");
									}
									%>
								</div>
								<%
								if (currentRoom.equals("room1")) {
								%>
								<%
								timeSlots = new String[] { "9:30", "12:35", "15:40", "18:45", "21:50" };
								%>
								<%
								} else if (currentRoom.equals("room2")) {
								%>
								<%
								timeSlots = new String[] { "10:40", "13:45", "16:50", "19:55", "23:00" };
								%>
								<%
								} else if (currentRoom.equals("room3")) {
								%>
								<%
								timeSlots = new String[] { "11:45", "14:50", "17:55", "21:00" };
								%>
								<%
								} else if (currentRoom.equals("room4")) {
								%>
								<%
								timeSlots = new String[] { "10:30", "13:35", "16:40", "20:50" };
								%>
								<%
								} else if (currentRoom.equals("room5")) {
								%>
								<%
								timeSlots = new String[] { "11:30", "14:40", "19:50", "22:00" };
								%>
								<%
								} else if (currentRoom.equals("room6")) {
								%>
								<%
								timeSlots = new String[] { "10:05", "13:10", "16:15", "19:20", "22:25" };
								%>
								<%-- 			<% } else if (currentRoom.equals("room7")) { %>
				<% timeSlots = new String[]{"9:00", "12:00", "15:00", "18:00", "21:00"}; %>
			<% } else if (currentRoom.equals("room8")) { %>
				<% timeSlots = new String[]{"10:00", "13:00", "16:00", "19:00", "22:00"}; %>
			<% } else if (currentRoom.equals("room9")) { %>
				<% timeSlots = new String[]{"11:00", "14:00", "17:00", "20:00"}; %> --%>
								<%
								}
								%>

								<div class="time-slot-buttons">
									<%
									for (String timeSlot : timeSlots) {
									%>
									<c:choose>
									<c:when test="${sessionScope.userid!=null}">
									<button
										onclick="bookTicket('<%=movieCd%>', '<%=timeSlot%>', '<%=currentRoom%>')">
										<%=timeSlot%>
										</script>
									</button>
									</c:when>
									<c:otherwise>
									<button
										onclick="bookfalse()">
										<%=timeSlot%>
										</script>
									</button>
									</c:otherwise>
									</c:choose>
									<%
									}
									%>
								</div>
							</div>
							<%
							}
							%>
						</div>

					</div>
					<hr style="border: 1px solid #ccc; margin: 30px 0;">

					<%
					movieCount++;
					if (movieCount >= maxMoviesToShow) {
						break; // 최대 표시할 영화 개수에 도달하면 반복문 종료
					}
					}

					} catch (IOException | ParseException e) {
					// API 호출 중 예외 처리
					out.println("API 호출 중 오류 발생: " + e.getMessage());
					}
					%>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../include/footer.jsp" %>

<form name="form2" method="post" action="/ticket/MovieF.do" style="display: none;">

   영화관 <input id="cinema_place" name="cinema_place" value="SYC강남">
   영화코드 <input id="movieCd" name="movieCd">
   시간 <input id="time1" name="time1" value="2024-03-08 09:30">
   상영관<input id="theater_num" name="theater_num" value="1">
   <input type="submit">
</form>   
</body>
</html>