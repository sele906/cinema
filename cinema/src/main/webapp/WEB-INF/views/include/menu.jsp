<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<style>

.section1 {
	/* background-color: black; */
	background: linear-gradient(to top, black, #333, #444);
	/*background-color: #222;*/
	/*background: linear-gradient(to right, red, black, red, black, red, black, red, black, red, black, #222, #222, #222, #222, #222, #222, #222, #222, #222, black, red, black, red, black, red, black, red, black, red);
	*/
	padding: 0px;
	width: 100%;
}

header {
	margin: 0 330px;
	text-align: center;
	/* background-color: linear-gradient(to bottom, black, white); */
	/* 	background-color: linear-gradient(to top, black, #333, #888); */
	color: white;
	padding: 0px 40px 0px 40px;
	display: flex;
	/* justify-content: space-between; */
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
	/*padding-top: 100px;*/
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
	margin: 0 0px;
	/* background-color: #222; */
	background-color: none;
	color: white;
	padding: 100px 20px 10px 60px;
	display: flex;
	/* justify-content: space-between; */
	align-items: center;
	
}

.bigmenu ul {
	list-style-type: none;
	margin: 0 0 0 0px;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigmenu ul li {
	position: relative;
	margin-right: 5px;
	padding: 0 20px;
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
	background-color: #222;
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
</style>

<div class="section1">
		<header>

			<div class="logo">
				<a href="/"><img src="/resources/images/icon/mainlogo2black.png"
					style="width: 250px; height: 150;">
			</div>
			
			<div class="bigmenu">
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
				<li><a href="index.do" onmouseover="showMenu(4)"
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

			<!-- <div class=search>
				<input type="text" name="search" size="50">
				<button style="border: none; background: none;"></button>
			</div> -->
		</div>
			
			<c:choose>
				<c:when test='${sessionScope.userid==null}'>
					<div class="main-menu">
						 
						<a href="/login.do">로그인</a>&nbsp;|&nbsp; <a
							href="/member/register.do">회원가입</a>&nbsp;|&nbsp;<a
							href="/mypage/detail.do">마이페이지</a>&nbsp;|&nbsp;<a
							href="/cboard/main.do">고객센터</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="main-menu">
						${sessionScope.name}님 환영합니다. <a
							href="/member/logout.do"><img
							src="/resources/images/icon/logout white.png"><br>로그아웃</a> |<a
							href="/mypage/detail.do"><img
							src="/resources/images/icon/mypage white.png"><br>마이페이지</a> | <a
							href="/cboard/main.do"><img
							src="/resources/images/icon/callcenter white.png"><br>고객센터</a>
					</div>
				</c:otherwise>
			</c:choose>
			
			
			
		</header>

		

	</div>

</html>