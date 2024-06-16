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
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Calendar"%>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>

<head>

<style>
body {
	 /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	font-family: Arial, sans-serif;
	background-color: white;
	
}



.section1{
margin: 0 330px;
}

footer {
background-color: #eee;
}
.foot {
margin: 0 330px;
}

header {
margin: 0 330px;
	text-align:center;
	background-color: white;
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

.downimg {
            position: relative;
            display: block;
            margin: 100px auto;
            width: 80%;
            height: 80%;
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
        
  .redbutton {
    background-color: #cc0000;
    color: white;
    padding: 2px 16px;
    border: none;
    border-radius: 5px;
    font-size: 15px;
    cursor: pointer;
    font-weight:bold;
    margin:2px 0 0 0;
}


</style>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영화 차트</title>
<link rel="icon" href="../../../resources/images/clearicon.ico" type="image/x-icon">
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
</script>

<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="../../../resources/images/icon/clearicon.ico" type="image/x-icon">
</head>


<body>
	<header>

		<div class="logo">
			<a href="/"><img src="../../../resources/images/icon/mainlogo2white.png" style="width: 250px; height: 150;">
		</div>
		
<c:choose>
<c:when test='${sessionScope.userid==null}'>
			<div class="main-menu">
				<a href="/login.do"><img src="../../../resources/images/icon/login black.png"><br>로그인</a>
				| <a href="/member/register.do"><img src="../../../resources/images/icon/join black.png"><br>회원가입</a> | 
				<a href="/login.do"><img src="../../../resources/images/icon/mypage black.png"><br>마이페이지</a> | <a
					href="/customercenter.do"><img src="../../../resources/images/icon/callcenter black.png"><br>고객센터</a>
			</div>
			</c:when>
			<c:otherwise>
			<div class="main-menu">
		     ${sessionScope.name}님 환영합니다.
				<a href="/member/logout.do"><img src="../../../resources/images/icon/logout black.png"><br>로그아웃</a>
				|<a href="/mypage/detail.do"><img src="../../../resources/images/icon/mypage black.png"><br>마이페이지</a> | 
				<a href="/customercenter.do"><img src="../../../resources/images/icon/callcenter black.png"><br>고객센터</a>
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

<div class=section1>
	<div class=titleword>
		상영중인 영화
	</div>
	
	<hr style="border: 1px solid #ccc; margin: 10px 0;">

<div>
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
		String apiKey = "975639d7befb5ab3b079a6f057165314"; // 실제 API 키로 교체

		// 매개변수 설정 (필요에 따라 수정)
		Map<String, String> params = new HashMap<>();
		params.put("key", apiKey);
		params.put("targetDt", yesterdayFormatted);
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
			// 최대 10개의 영화만 표시
			int maxMoviesToShow = 10;
			int movieCount = 0;
			%>

			<div class="movie-item-container">
				<%
				// 영화 정보를 테이블에 출력
				for (Object movie : dailyBoxOfficeList) {
					JSONObject movieObj = (JSONObject) movie;
					String movieTitle = (String) movieObj.get("movieNm"); // 영화 제목
					String salesShare = (String) movieObj.get("salesShare"); // 누적 예매율
					String movieCd = (String) movieObj.get("movieCd"); // 영화 코드
					String rank = (String) movieObj.get("rank"); // 영화 순위
					String audiAcc = (String) movieObj.get("audiAcc"); // 누적 관객수
					int audiAccValue = Integer.parseInt(audiAcc);
					DecimalFormat formatter = new DecimalFormat("###,###");
					String formattedAudiAcc = formatter.format(audiAccValue);
					
	
				%>
				<div class="movie-item" style="position: relative;">
				<p class="movie-rank">NO <%=rank %></p>
				<c:choose>
				<c:when test="${sessionScope.userid!=null}">
					<button onclick="gomoviedetail('<%=movieCd%>')" style="border: none; background: none; cursor: pointer;"><img src="../../../resources/images/poster/<%=movieCd%>.jpg" style="width: 200px; height: 150;"></button>
					</c:when>
					<c:otherwise>
					<button onclick="gomovie('<%=movieCd%>')" style="border: none; background: none; cursor: pointer;"><img src="../../../resources/images/poster/<%=movieCd%>.jpg" style="width: 200px; height: 150;"></button>
					</c:otherwise>
					</c:choose>
						<div style="text-align:center; margin-left:30px;">
						<hr style="border: 1px solid #ccc; margin: 7px 0 4px 0;">
							<p style="font-weight: bold;"><%=movieTitle%></p>
							<p>예매율 :<%=salesShare%>%</p>
							<p style="width:180px;">누적관객수 :<%=formattedAudiAcc%>명</p>
							<hr style="border: 1px solid #ccc; margin: 4px 0 7px 0;">
						</div>
					<c:choose>
				<c:when test="${sessionScope.userid!=null}">
					<button  style="margin-left:30px;" class="redbutton" onclick="moviebook('<%=movieCd%>')">예매</button>
					</c:when>
					<c:otherwise>
					 <button  style="margin-left:30px;" class="redbutton"  onclick="confirmAction()">예매</button>
        <script>
            function confirmAction() {
                if (confirm("예매를 하려면 로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?")) {
                    // 확인을 클릭했을 때 로그인 페이지로 이동
                    window.location.href = "/login.do";
                } else {
                    // 취소를 클릭했을 때 아무런 동작도 하지 않음
                }
            }
        </script>
					</c:otherwise>
						</c:choose>
				</div>
				
				<script>
				    function gomoviedetail(movieCd) {
				        // moviedetail.jsp 페이지로 이동하는 코드
				        //window.location.href = '../like_servlet/heart.do?movieCd=' + movieCd;
				    	window.location.href = '/like/heart.do?movieCd=' + movieCd;
				    }
				    function gomovie(movieCd){
				    	//window.location.href ='../review_servlet/noheart.do?movieCd='+movieCd;
				    	window.location.href ='/review/noheart.do?movieCd='+movieCd;
				    }
				    function moviebook(movieCd) {
				        window.location.href = '/ticket/book_tickets.do?movieCd=' + movieCd;
				    }
				</script>
				
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

	
		
		<div class="downimg">
         <div class="close-button" onclick="closeimg1()">
            <img src="../../../resources/images/icon/close black.png"  style="width:20px; height: 20px;" alt="Close">
         </div>
         <img src="../../../resources/images/poster/notyet.png" style="width: 100%; height: 100%;">
      </div>
      </div>
     
      
      
      <div class="sideimg">
         <div class="close-button" onclick="closeimg2()">
            <img src="../../../resources/images/icon/close black.png"  style="width:20px; height: 20px;" alt="Close">
         </div>
         <img src="../../../resources/images/adver/ad4.png" style="width: 230px; height: 400px;">
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
		
		<footer style="background : #eee; margin:0; padding : 150px 0 50px 0">
		<div class = "foot" >
			<hr style="border: 1px solid #ccc; margin: 0 0 50px 0;">
		    <div style=" color: #666; padding: 10px; line-height: 0.7; font-size : 12px">
		        <p>&copy; 2024 SSANG YONG CINEMA. All rights reserved.</p>
		        <p>(04377)서울특별시 용산구 한강대로 23길 55, 아이파크몰 6층(한강로동)</p>
		        <p>대표이사 : 한승찬  /  사업자등록번호 : 104-81-45690  /  통신판매업신고번호 : 2017-서울용산-0662 사업자정보확인</p>
		        <p>호스팅사업자 : 쌍용엔터테이먼트  /  대표이메일 : sycinema@gmail.com</p>
		        <div style="margin-top: 10px;">
		            <a href="#">Terms of Service</a> | <a href="#">Privacy Policy</a>
		        </div>
		    </div>
	    </div>
</footer>
		
</body>

</html>