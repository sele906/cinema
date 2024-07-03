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
<script>
function list(page,moviecode) {
	location.href = "/like/heart.do?cur_page=" + page
			+ "&movieCd="+moviecode;
}
function list2(page,moviecode) {
	location.href = "/review/noheart.do?cur_page=" + page
			+ "&movieCd="+moviecode;
}

function review(movieCd,movieTitle) {
    window.open('/review/write.do?movieTitle=' + encodeURIComponent(movieTitle)+"&moviecode="+ movieCd, 'popup', 'width=650, height=550');
}
</script>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
}

body::before {
	content: "";
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.6); /* 반투명한 검은 색 배경 */
	z-index: -1; /* 배경 이미지 위에 위치하도록 z-index 설정 */
}

.section1 {
	margin: 0 330px; /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	padding: 0px;
	width: auto;
}

.section2 {
	margin: 0 330px; /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	padding: 0px;
	width: auto;
}

.moviesection {
	background-color: #333;
	padding: 40px 0 10px 0; /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	margin: 0 330px;
}

footer {
	background-color: #eee;
}

.foot {
	margin: 0 330px;
}

header {
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

.redbutton {
	background-color: #990000;
	color: white;
	padding: 2px 16px;
	border: none;
	border-radius: 5px;
	font-size: 15px;
	cursor: pointer;
	font-weight: bold;
	margin: 2px 0 0 0;
}
</style>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영화 차트</title>
<link rel="icon" href="../../../resources/images/clearicon.ico"
	type="image/x-icon">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
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
<link rel="icon" href="../../../resources/images/icon/clearicon.ico"
	type="image/x-icon">
</head>



<body>
	<div class=section1>
		<header>

			<div class="logo">
				<a href="/"><img
					src="../../../resources/images/icon/mainlogo2white.png"
					style="width: 250px; height: 150;">
			</div>

			<c:choose>
				<c:when test='${sessionScope.userid==null}'>
					<div class="main-menu">
						<a href="/login.do"><img
							src="../../../resources/images/icon/login black.png"><br>로그인</a>
						| <a href="/member/register.do"><img
							src="../../../resources/images/icon/join black.png"><br>회원가입</a>
						| <a href="/mypage/detail.do"><img
							src="../../../resources/images/icon/mypage black.png"><br>마이페이지</a>
						| <a href="/customercenter.do"><img
							src="../../../resources/images/icon/callcenter black.png"><br>고객센터</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="main-menu">
						${sessionScope.name}님 환영합니다. <a href="/member/logout.do"><img
							src="../../../resources/images/icon/logout black.png"><br>로그아웃</a>
						|<a href="/mypage/detail.do"><img
							src="../../../resources/images/icon/mypage black.png"><br>마이페이지</a>
						| <a href="/customercenter.do"><img
							src="../../../resources/images/icon/callcenter black.png"><br>고객센터</a>
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
				<li><a href="/store.do" onmouseover="showMenu(4)"
					onmouseout="hideDelay(4)" onmousemove="keepShow(4)">스토어</a>
					<ul class="submenu" id="submenu4" onmouseover="keepShow(4)"
						onmouseout="hideDelay(4)">
						<li><a href="/store.do">팝콘, 매점</a></li>
						<li><a href="/store.do">굿즈</a></li>
					</ul></li>
				<li><a href="/index.do" onmouseover="showMenu(5)"
					onmouseout="hideDelay(5)" onmousemove="keepShow(5)">이벤트/혜택</a>
					<ul class="submenu" id="submenu5" onmouseover="keepShow(5)"
						onmouseout="hideDelay(5)">
						<li><a href="/index.do">진행중인 이벤트</a></li>
						<li><a href="/index.do">기프티콘</a></li>
					</ul></li>
			</ul>

			<div class=search>
				<input type="text" name="search" size="50">
				<button style="border: none; background: none;"></button>
			</div>
		</nav>

		<div style="background-color: white; padding: 10px;">
			<div class=titleword>영화 정보</div>
			<hr style="border: 1px solid #ccc; margin: 0px 0;">
		</div>

	</div>

	<%
	// API 호출에 필요한 정보 설정
	String apiUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json";
	String apiKey = "4ed2f64a7d20045f0edf7f9c77955da3"; // 실제 API 키로 교체

	// 매개변수 설정 (필요에 따라 수정)
	Map<String, String> params = new HashMap<>();
	params.put("key", apiKey);
	params.put("movieCd", request.getParameter("movieCd"));
	//params.put("movieCd", "20234675");

	try {
		// API 호출
		String apiResponse = ApiCaller.callApi(apiUrl, params);

		// JSON 파싱을 위한 JSONObject 사용
		JSONParser parser = new JSONParser();
		JSONObject jsonResponse = (JSONObject) parser.parse(apiResponse);

		// 필요한 데이터 추출 (info)
		JSONObject movieInfoResult = (JSONObject) jsonResponse.get("movieInfoResult");
		JSONObject movieInfo = (JSONObject) movieInfoResult.get("movieInfo");

		// 필요한 데이터 추출 (home)
		//	JSONObject boxOfficeResult = (JSONObject) jsonResponse.get("boxOfficeResult");
		//	JSONArray dailyBoxOfficeList = (JSONArray) boxOfficeResult.get("dailyBoxOfficeList");

		// 리스트 객체 추출 (info)
		JSONArray genres = (JSONArray) movieInfo.get("genres");
		JSONArray audits = (JSONArray) movieInfo.get("audits");
		JSONArray directors = (JSONArray) movieInfo.get("directors");
		JSONArray actors = (JSONArray) movieInfo.get("actors");

		// 영화 정보를 테이블에 출력
		String movieCd = (String) movieInfo.get("movieCd"); // 코드
		String movieTitle = (String) movieInfo.get("movieNm"); // 제목
		String movieNmEn = (String) movieInfo.get("movieNmEn"); // 제목
		String genreNm = (String) ((JSONObject) genres.get(0)).get("genreNm"); //장르
		String showTm = (String) movieInfo.get("showTm"); // 상영시간
		String watchGradeNm = (String) ((JSONObject) audits.get(0)).get("watchGradeNm"); //
		String peopleNm = directors.isEmpty() ? "-" : (String) ((JSONObject) directors.get(0)).get("peopleNm"); //
		String actor1 = actors.isEmpty() ? "-" : (String) ((JSONObject) actors.get(0)).get("peopleNm"); //
		String actor2 = actors.size() > 1 ? (String) ((JSONObject) actors.get(1)).get("peopleNm") : ""; //
		String actor3 = actors.size() > 2 ? (String) ((JSONObject) actors.get(2)).get("peopleNm") : ""; //
		String actor4 = actors.size() > 3 ? (String) ((JSONObject) actors.get(3)).get("peopleNm") : ""; //
	%>
	<script>
		function toggleLike(moviecode,movieTitle) {

			var heartIcon = document.getElementById('heartIcon');
			// JSP 코드를 JavaScript 문자열로 포함하여 직접 사용할 수 없습니다.
			// 대신, JavaScript 변수를 사용하여 로그인 상태를 확인합니다.
			var loggedIn =<%=session.getAttribute("userid") != null%>
		; // 로그인 상태를 확인하는 JavaScript 변수
			if (!loggedIn) {
				var result = confirm("로그인이 필요합니다. 로그인하시겠습니까?");
				if (result) {
					// 확인 버튼을 누른 경우
					window.location.href = "/login.do"; // 로그인 페이지 URL로 이동합니다. 필요에 따라 수정해야 합니다.
				} else {
					// 취소 버튼을 누른 경우
					return false; // 이벤트를 취소합니다.
				}
			} else {
				if (heartIcon.src.includes('empty_heart2.png')) { // 여기서는 파일 경로를 정확하게 비교합니다.
					heartIcon.src = '../../../resources/images/filled_heart2.png';
					$.ajax({
								type : "post",
								url : "/like/insert.do",
								data : {
									"moviecode" : moviecode,
									"movieTitle" : movieTitle,
								}, // 옵션 객체의 끝에 쉼표 추가
								success : function(txt) {
									if(txt=="success"){
										if (confirm("내가 찜한 영화에 등록되었습니다. 내가 찜한 영화로 이동하시겠습니까?")) {
											// 사용자가 확인을 누른 경우 마이페이지로 이동합니다.
											window.location.href = "/mypage/list.do"; // 마이페이지 URL을 입력하세요.
										} else {
											// 사용자가 확인을 누르지 않은 경우 아무것도 하지 않습니다.
										}
									}
								}
							});

				} else {
					heartIcon.src = '../../../resources/images/empty_heart2.png';
					$.ajax({
						type : "post",
						url : "/like/delete.do",
						data : {
							"moviecode" : moviecode
						}, // 옵션 객체의 끝에 쉼표 추가
						success : function(txt) {
							if(txt=="delete"){
								alert("삭제되었습니다.")
							}
						}
					});
				}
			}
		}
	</script>
	<div class="moviesection">
		<div class="movie-item"
			style="position: relative; display: flex; align-items: center; margin-left: 40px">
			<div class="poster">
				<img src="../../../resources/images/poster/<%=movieCd%>.jpg"
					style="width: 240px; height: 360;">
			</div>
			<div class=minfo style="margin-top: -50px;">
				<p
					style="color: white; font-size: 48px; font-weight: bold; margin: 0 0 0 80px; padding-right: 20px;"><%=movieTitle%></p>
				<p
					style="color: #888; font-size: 24px; font-weight: normal; margin: 0 0 0 83px;"><%=movieNmEn%></p>
				<hr style="border: 1px solid #ccc; margin: 20px 0 20px 80px;">
				<p
					style="color: white; font-size: 15px; font-weight: normal; margin: 10px 0 0 80px;">
					장르 :
					<%=genreNm%></p>
				<p
					style="color: white; font-size: 15px; font-weight: normal; margin: 10px 0 0 80px;">
					감독 :
					<%=peopleNm%></p>
				<p
					style="color: white; font-size: 15px; font-weight: normal; margin: 10px 0 0 80px;">
					배우 :
					<%=actor1%>
					<%=actor2%>
					<%=actor3%>
					<%=actor4%></p>
				<p
					style="color: white; font-size: 15px; font-weight: normal; margin: 10px 0 0 80px;"><%=watchGradeNm%></p>
				<p
					style="color: white; font-size: 15px; font-weight: normal; margin: 10px 0 0 80px;">
					상영시간 :
					<%=showTm%>분
				</p>
				<hr style="border: 1px solid #ccc; margin: 20px 0 20px 80px;">
				<c:choose>
					<c:when test="${sessionScope.userid!=null}">
						<button style="margin-left: 80px" class="redbutton"
							onclick="moviebook('<%=movieCd%>')">예매</button>
						<button style="margin-left: 80px" class="redbutton"
							onclick="review('<%=movieCd%>','<%=movieTitle%>')">리뷰</button>
					</c:when>
					<c:otherwise>
						<button style="margin-left: 80px" class="redbutton"
							onclick="confirmAction()">예매</button>
						<button style="margin-left: 80px" class="redbutton"
							onclick="confirmAction2()">리뷰</button>
						<script>
							function confirmAction() {
								if (confirm("예매를 하려면 로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?")) {
									// 확인을 클릭했을 때 로그인 페이지로 이동
									window.location.href = "/login.do";
								} else {
									// 취소를 클릭했을 때 아무런 동작도 하지 않음
								}
							}
							function confirmAction2() {
								if (confirm("리뷰를 작성하려면 로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?")) {
									// 확인을 클릭했을 때 로그인 페이지로 이동
									window.location.href = "/login.do";
								} else {
									// 취소를 클릭했을 때 아무런 동작도 하지 않음
								}
							}
						</script>
					</c:otherwise>
				</c:choose>
				<button class="like-button"
					onclick="toggleLike('<%=movieCd%>','<%=movieTitle%>')">
					<c:choose>
						<c:when test="${list == null}">
							<img id="heartIcon"
								src="../../../resources/images/empty_heart2.png" alt="Like">
						</c:when>
						<c:otherwise>
							<img id="heartIcon"
								src="../../../resources/images/filled_heart2.png" alt="Like">
						</c:otherwise>
					</c:choose>
				</button>
			</div>
		</div>
	</div>


	<script>
		function moviebook(movieCd) {
			window.location.href = '/ticket/book_tickets.do?movie_cd='
					+ movieCd;
		}
	</script>

	<div class="contents"
		style="color: black; font-size: 15px; font-weight: normal; padding-left: 80px; background-color: white;'">
		<br> <br> <br> <br>
		<%
		// 각 영화 코드에 따라 해당하는 줄거리를 출력합니다.
		if ("20234675".equals(movieCd)) {
		%><p>
			미국 LA, 거액의 의뢰를 받은 무당 ‘화림’(김고은)과 ‘봉길’(이도현)은<br> 기이한 병이 대물림되는 집안의
			장손을 만난다.<br> 조상의 묫자리가 화근임을 알아챈 ‘화림’은 이장을 권하고,<br> 돈 냄새를 맡은
			최고의 풍수사 ‘상덕’(최민식)과 장의사 ‘영근’(유해진)이 합류한다.<br> <br> “전부 잘 알
			거야… 묘 하나 잘못 건들면 어떻게 되는지”<br> <br> 절대 사람이 묻힐 수 없는 악지에 자리한
			기이한 묘.<br> ‘상덕’은 불길한 기운을 느끼고 제안을 거절하지만,<br> ‘화림’의 설득으로 결국
			파묘가 시작되고…<br> <br> 나와서는 안될 것이 나왔다..
		</p>
		<%
		} else if ("20236180".equals(movieCd)) {
		%>
		<p>
			세상에서 가장 달콤한 여정<br> 좋은 일은 모두 꿈에서부터 시작된다!<br> <br> 마법사이자
			초콜릿 메이커 ‘윌리 웡카’의 꿈은 디저트의 성지, ‘달콤 백화점’에 자신만의 초콜릿 가게를 여는 것.<br> 가진
			것이라고는 낡은 모자 가득한 꿈과 단돈 12소버린 뿐이지만 특별한 마법의 초콜릿으로 사람들을 사로잡을 자신이 있다. <br>
			<br> 하지만 먹을 것도, 잠잘 곳도, 의지할 사람도 없는 상황 속에서 낡은 여인숙에 머물게 된 ‘웡카’는<br>
			‘스크러빗 부인’과 ‘블리처’의 계략에 빠져 눈더미처럼 불어난 숙박비로 인해 순식간에 빚더미에 오른다.<br>
			게다가 밤마다 초콜릿을 훔쳐가는 작은 도둑 ‘움파 룸파’의 등장과 ‘달콤 백화점’을 독점한 초콜릿 카르텔의 강력한 견제까지.<br>
			세계 최고의 초콜릿 메이커가 되는 길은 험난하기만 한데…
		</p>
		<%
		} else if ("20247074".equals(movieCd)) {
		%>
		<p>
			1945년 해방 이후 남과 북은 서로 다른 길을 걸어 왔다.<br> 자유를 억압하고 인권을 탄압하는 공산주의 독재
			국가 북한과 <br> 자유와 민주주의에 기초한 경제 번영과 선진국의 길로 들어선 대한민국.<br> <br>
			두 나라는 같은 언어, 역사, 인종을 공유하면서 어떻게 극단적인 두 나라로 갈라졌을까?<br> 지난 70년 역사를
			통해서 오늘의 대한민국을 만들고 지켜내기 위해 노력했던 이승만 대통령과 <br> 건국1세대들의 희생과 투쟁을 조명한
			작품.
		</p>
		<%
		} else if ("20247076".equals(movieCd)) {
		%>
		<p>
			‘탄지로’와 상현‘한텐구’의 목숨을 건 혈투와, <br> ‘무잔'과의 최종 국면을 앞둔 귀살대원들의 마지막 훈련을
			그린 영화
		</p>
		<%
		} else if ("20236295".equals(movieCd)) {
		%>
		<p>
			황제의 모략으로 멸문한 가문의 유일한 후계자 폴.(티모시 샬라메)<br> 어머니 레이디 제시카(레베카 퍼거슨)와
			간신히 목숨만 부지한 채 사막으로 도망친다.<br> 그곳에서 만난 반란군들과 숨어 지내다 그들과 함께 황제의 모든
			것을 파괴할 전투를 준비한다.<br> 한편 반란군들의 기세가 높아질수록 불안해진 황제와 귀족 가문은 <br>
			잔혹한 암살자 페이드 로타(오스틴 버틀러)를 보내 반란군을 몰살하려 하는데…<br> <br> 2월, 운명의
			반격이 시작된다!
		</p>
		<%
		} else if ("20231415".equals(movieCd)) {
		%>
		<p>
			60년 만에 찾아간 고향, 16살의 추억을 만났다. 요즘 들어 돌아가신 엄마가 자꾸 꿈에 보이는 은심(나문희). <br>
			마침 절친이자 사돈 지간인 금순(김영옥)이 연락도 없이 불쑥 찾아오자, 은심은 금순과 함께 고향 남해로 떠나기로 한다. <br>
			그곳에서 우연히 자신을 짝사랑하던 태호(박근형)를 만나며 잊고 지낸 추억을 하나둘씩 떠올리게 되는데… <br> <br>
			“다음에 다시 태어나도 네 친구 할 끼야” <br> <br> 한 편의 시가 되는 우정, 어쩌면 마지막
			소풍이 시작된다..
		</p>
		<%
		} else if ("20247219".equals(movieCd)) {
		%>
		<p>
			인신매매시장 규모 연 1,500억불<br> 전 세계 800만 명의 아이들이 사라졌다! <br> <br>
			한 순간에 납치되어, 전 세계에 밀매되는 아이들.<br> 믿을 수 없는 실화를 기반으로 한 구출 작전이 시작된다!
		</p>
		<%
		} else if ("20206946".equals(movieCd)) {
		%>
		<p>
			내 돈을 사기 친 그 놈이 구조 요청을 해왔다! 세탁소 화재로 인해 대출상품을 알아보던 생활력 만렙 덕희에게 <br>
			어느 날, 거래은행의 손대리가 합리적인 대출상품을 제안하겠다며 전화를 걸어온다. <br> 대출에 필요하다며 이런저런
			수수료를 요구한 손대리에게 돈을 보낸 덕희는 이 모든 과정이 보이스피싱이었음을 뒤늦게 인지하고 충격에 빠진다. <br>
			전 재산을 잃고 아이들과 거리로 나앉게 생긴 덕희에게 어느 날 손대리가 다시 전화를 걸어오는데… <br> <br>
			이번엔 살려달라는 전화다! <br> 경찰도 포기한 사건, 덕희는 손대리도 구출하고 잃어버린 돈도 찾겠다는 일념으로
			필살기 하나씩 장착한 직장 동료들과 함께 중국 칭다오로 직접 날아간다.
		</p>
		<%
		} else if ("20235145".equals(movieCd)) {
		%>
		<p>
			'기적의 시작’은 이승만 대통령의 어린 시절부터의 일대기를 다루는 다큐멘터리 영화로<br> 이승만의 독립운동,
			건국, 6·25 한국전쟁을 승리로 이끈 과정, 대한민국 산업화의 기반을 다지는 과정 등에 초점을 맞춰<br> 이승만
			대통령이 대한민국을 위해 어떤 기여를 했으며 어떤 유산을 남겼는지 알기 쉽게 설명한다.<br> <br>
			이승만 대통령 역으로 국민배우 임동진이 출연한 재연 장면을 더해 감동을 극대화 하였고,<br> 20년 간의 제작
			기간을 통해 이승만 대통령과 함께 큰 일을 했던 백선엽 장군의 증언,<br> 아들 이인수 박사의 생전 마지막 고백
			등을 담아 어디에서도 들어 볼 수 없는 생생한 이야기를 관객들에게 전한다.
		</p>
		<%
		} else if ("20247063".equals(movieCd)) {
		%>
		<p>
			함께 있지만 그들은 언제나 혼자였다<br> 1970년 바튼 아카데미,<br> 크리스마스를 맞아 모두가 떠난
			텅빈 학교에는 세 사람이 남게 된다.<br> 고집불통 역사 선생님 ‘폴’, 문제아 ‘털리’ 그리고 주방장 ‘메리’<br>
			이들은 원치 않았던 동고동락을 시작하게 되고,<br> 예상치 못한 순간, 서로의 비밀을 공유하면서 특별한 우정을
			나누게 되는데…
		</p>
		<%
		} else if ("20236732".equals(movieCd)) {
		%>
		<p>
			천재적이지만 특이한 과학자 갓윈 백스터(윌렘 대포)에 의해 새롭게 되살아난 벨라 백스터(엠마 스톤).<br> 갓윈의
			보호를 받으며 성장하던 벨라는 날이 갈수록 세상에 대한 호기심과 새로운 경험에 대한 갈망이 넘쳐난다.<br> <br>
			아름다운 벨라에게 반한 짓궂고 불손한 바람둥이 변호사 덩컨 웨더번(마크 러팔로)이 더 넓은 세계를 탐험하자는 제안을 하자,<br>
			벨라는 새로운 경험에 대한 갈망으로 대륙을 횡단하는 여행을 떠나고<br> 처음 보는 광경과 새롭게 만난 사람들을
			통해 놀라운 변화를 겪게 되는데….<br> <br> 세상에 대한 경이로움과 아름다움, 놀라운 반전과 유머로
			가득한 벨라의 여정이 이제 시작된다.
		</p>
		<%
		} else if ("20234789".equals(movieCd)) {
		%>
		<p>
			12살의 어느 날,<br> '해성'의 인생에서 갑자기 사라져버린 첫 사랑, '나영'.<br> 12년 후,
			'나영'은 뉴욕에서 작가의 꿈을 안고 살아가다 <br> SNS를 통해 우연히 어린시절 첫 사랑 '해성'이<br>
			자신을 찾고 있었다는 사실을 알게 된다.<br> <br> 또 한 번의 12년 후,<br> 인연의
			끈을 붙잡기 위해 용기 내어 뉴욕을 찾은 '해성'.<br> 수많은 "만약"의 순간들이 스쳐가며,<br>
			끊어질 듯 이어져온 감정들이 다시 교차하게 되는데…<br> <br> 우리는 서로에게 기억일까? 인연일까?<br>
		</p>
		<%
		} else if ("19970037".equals(movieCd)) {
		%>
		<p>
			타고난 파이터이며 아웃사이더인 민, 폭력 조직에서 성공하기를 꿈꾸는 태수, 미래에 대한 소박한 꿈을 버리지 않는 환규는 <br>
			무차별적 싸움과 혼돈속에서 10대를 보낸다.<br> <br> 어느날 환규를 따라 나간 노예팅에서 민은
			로미를 만나 운명적 사랑을 느끼고 이날 이후 민은 기꺼이 로미의 노예가 된다.<br> 민과 환규는 방황하던 마음을
			잡고 분식집을 개업하여 열심히 살아보려고 애쓰고 감옥에서 나온 태수는 전갈 조직의 중간 보스로 자리를 잡는데...<br>
		</p>
		<%
		} else if ("20230614".equals(movieCd)) {
		%>
		<p>
			공무원 생활을 그만두고 7년 만에 대망의 첫 작품인 애니메이션
			<사운드백 카나데의 돌>로 꿈에 그리던 감독 데뷔를 하게 된 ‘히토미’. <br>
			업계에서 히트 제조기로 추앙받는 메인 프로듀서 ‘유키시로’와 내내 실랑이를 벌이며 그녀의 열정은 점차 시들해지고 제작
			현장에는 먹구름이 드리워진다! <br>
			한편, 토요일 오후 5시 황금시간대의 라이벌은 한때 ‘히토미’의 롤모델이었던 천재감독 ‘오우지’의 신작으로 결정되는데… 8년
			만의 신작 발표를 앞두고 <br>
			자취를 감춰버린 ‘오우지’로 인해 멘붕에 빠져버린 <운명전선 리델라이트>의 메인 프로듀서 베테랑 ‘아리시나’!
			마침내 시작된 숙명의 애니메이션 대결.<br>
			<br>
			흥행 전쟁의 승자는 과연 누구일까?!<br>
		</p>
		<%
		} else {
		%>
		<p>해당 영화에 대한 소개가 없습니다</p>
		<%
		}
		%>
		<br> <br>
		<div>

			<h3>영화 리뷰</h3>

			<div style="width: 900px; display: flex; flex-wrap: wrap;">
				<c:forEach var="dto" items="${list2}" varStatus="loop">
					<div
						style="width: 50%; display: flex; flex-wrap: wrap; box-sizing: border-box;">
						<div
							style="width: 50%; border-top: 1px solid #000; border-bottom: 1px solid #000; box-sizing: border-box; padding: 10px;">
							<img src="/cinema/images/${dto.filename}" alt="이미지"
								onerror="this.onerror=null; this.src='../../../resources/images/basic.png';"
								style="border-radius: 50%; overflow: hidden; width: 100px; height: 100px;"><br>
							<br> <span class="masked-userid">${dto.userid}</span>
						</div>
						<div
							style="width: 50%; border-top: 1px solid #000; border-bottom: 1px solid #000; box-sizing: border-box; padding: 10px;">
							남긴 평점
							<p
								style="text-align: left; font-size: 18px; font-weight: bold; margin: 0">
								<script>
                        var ratingValue = ${dto.value};
                        function generateStars(value) {
                            var stars = '';
                            for (var i = 0; i < value; i++) {
                                stars += '★'; // 별 문자 추가
                            }
                            return stars;
                        }
                        document.write(generateStars(ratingValue));
                    </script>
							</p>
							<p
								style="text-align: left; font-size: 16px; font-weight: normal; margin: 15px 0 0 0; line-height: 1.5;">${dto.content}</p>
						</div>
					</div>
				</c:forEach>
			</div>

			<table width="900px">
				<tr align="center">
					<td colspan="4"><c:choose>
							<c:when test="${sessionScope.userid!=null}">
								<c:if test="${page.curPage > 1}">
									<a href="#" onclick="list('1','${movieCd}')">[처음]</a>
								</c:if>
								<c:if test="${page.curBlock > 1}">
									<a href="#" onclick="list('${page.prevPage}','${movieCd}')">[이전]</a>
								</c:if>
								<c:forEach var="num" begin="${page.blockStart}"
									end="${page.blockEnd}">
									<c:choose>
										<c:when test="${num == page.curPage}">
											<span style="color: red">${num}</span>
										</c:when>
										<c:otherwise>
											<a href="#" onclick="list('${num}','${movieCd}')">${num}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${page.curBlock < page.totBlock}">
									<a href="#" onclick="list('${page.nextPage}','${movieCd}')">[다음]</a>
								</c:if>
								<c:if test="${page.curPage < page.totPage}">
									<a href="#" onclick="list2('${page.totPage}','${movieCd}')">[마지막]</a>
								</c:if></td>
					</c:when>
					<c:otherwise>
						<c:if test="${page.curPage > 1}">
							<a href="#" onclick="list2('1','${movieCd}')">[처음]</a>
						</c:if>
						<c:if test="${page.curBlock > 1}">
							<a href="#" onclick="list2('${page.prevPage}','${movieCd}')">[이전]</a>
						</c:if>
						<c:forEach var="num" begin="${page.blockStart}"
							end="${page.blockEnd}">
							<c:choose>
								<c:when test="${num == page.curPage}">
									<span style="color: red">${num}</span>
								</c:when>
								<c:otherwise>
									<a href="#" onclick="list2('${num}','${movieCd}')">${num}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${page.curBlock < page.totBlock}">
							<a href="#" onclick="list2('${page.nextPage}','${movieCd}')">[다음]</a>
						</c:if>
						<c:if test="${page.curPage < page.totPage}">
							<a href="#" onclick="list2('${page.totPage}','${movieCd}')">[마지막]</a>
						</c:if>
						</td>
					</c:otherwise>
					</c:choose>
				</tr>
			</table>

			<script>
    function maskUserId(userId) {
        var visibleChars = 3; // 처음 몇 글자를 숨길지 설정
        var masked = userId.substr(0, visibleChars); // 처음 visibleChars 글자를 추출
        for (var i = visibleChars; i < userId.length; i++) {
            masked += '*'; // 나머지 글자를 '*'로 대체
        }
        return masked;
    }

    // 화면 로딩 후 실행
    document.addEventListener('DOMContentLoaded', function() {
        var userIdElements = document.querySelectorAll('.masked-userid');
        userIdElements.forEach(function(element) {
            element.textContent = maskUserId(element.textContent); // 사용자 ID를 '*'로 대체한 값으로 설정
        });
    });
</script>



		</div>

		<script>
   
     // 사용자 ID의 일부를 '*'로 대체하는 함수

    function setBackgroundImage(movieCd) {
        var posterUrl = "../../../resources/images/poster/" + movieCd + ".jpg";

        // 배경 이미지 설정
        document.body.style.backgroundImage = "url('" + posterUrl + "')";
        document.body.style.backgroundSize = "cover";
        document.body.style.backgroundRepeat = "no-repeat";
        document.body.style.backgroundAttachment = "fixed";


    }

    // 함수 호출 시 movieCd 전달
    setBackgroundImage('<%=movieCd%>
			');
		</script>

		<%
		} catch (IOException | ParseException e) {
		// API 호출 중 예외 처리
		out.println("API 호출 중 오류 발생: " + e.getMessage());
		}
		%>





		<div class="section2" style="background-color: white; padding: 30px;">
			<hr style="border: 1px solid #ccc; margin: 0;">



		</div>

		<footer>
			<div class="foot">
				<hr style="border: 1px solid #ccc; margin: 0 0 10px 0;">
				<div
					style="color: #666; padding: 10px; line-height: 0.7; font-size: 12px">
					<p>&copy; 2024 SSANG YONG CINEMA. All rights reserved.</p>
					<p>(04377)서울특별시 용산구 한강대로 23길 55, 아이파크몰 6층(한강로동)</p>
					<p>대표이사 : 한승찬 / 사업자등록번호 : 104-81-45690 / 통신판매업신고번호 :
						2017-서울용산-0662 사업자정보확인</p>
					<p>호스팅사업자 : 쌍용엔터테이먼트 / 대표이메일 : sycinema@gmail.com</p>
					<div style="margin-top: 10px;">
						<a href="#">Terms of Service</a> | <a href="#">Privacy Policy</a>
					</div>
				</div>
			</div>
		</footer>
</body>
</html>