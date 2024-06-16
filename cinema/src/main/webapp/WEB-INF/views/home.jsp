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

.foot {
	margin: 0 10%;
}


.section2 {
	background-color: black;
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

/* footer {
	background-color: #eee;
}

.foot {
	margin: 0 330px;
} */

/*@media ( max-width : 1600px) {
	body {
		margin: 0;
	}
}*/

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
	padding: 0 0px;
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

.downimg {
            position: relative;
            display: block;
            margin: 0px auto;
            width: 60%;
            height: 60%;
        }
        


.close-button {
            position: absolute;
            top: 8px;
            right: 10px;
            cursor: pointer;
        }

</style>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SSANG YONG CINEMA</title>
<link rel="icon" href="../../../resources/images/icon/clearicon.ico" type="image/x-icon">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<c:if test="${param.message=='logout'}">
	<script>
		alert('로그아웃되었습니다.');
	</script>
</c:if>

</head>

<body>
	
	<%@ include file="include/menu.jsp" %> 

<div class="section2" style="padding: 40px 0;">
    <div style="position: relative; width: 100%; height: 475px; margin: 0 auto;">
        <div style="width: 80%; height: 475px; margin: 0 auto; display: flex; justify-content: center;">
            <img id="posterImage1" src="/resources/images/poster/grave.jpg" style="width: 845px; height: 475px; display: block;">
            <img id="posterImage2" src="/resources/images/poster/bude.jpg" style="width: 845px; height: 475px; display: none;">
            <img id="posterImage3" src="/resources/images/poster/kong.jpg" style="width: 845px; height: 475px; display: none;">
            <img id="posterImage4" src="/resources/images/poster/10year.jpg" style="width: 845px; height: 475px; display: none;">
            <img id="posterImage5" src="/resources/images/poster/omen.jpg" style="width: 845px; height: 475px; display: none;">
            <img id="posterImage6" src="/resources/images/poster/panda4.jpg" style="width: 845px; height: 475px; display: none;">
            <img id="posterImage7" src="/resources/images/poster/dosi4.jpg" style="width: 845px; height: 475px; display: none;">
        </div>

        <img id="playicon" src="/resources/images/icon/playicon.png" width="100px" height="100px" onclick="toggleVideo()" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); cursor: pointer;">
        <img id="right" src="/resources/images/icon/right.png" width="50px" height="150px" onclick="toggleImage('next')" style="position: absolute; top: 50%; left: 95%; transform: translate(-50%, -50%); cursor: pointer;">
        <img id="left" src="/resources/images/icon/left.png" width="50px" height="150px" onclick="toggleImage('prev')" style="position: absolute; top: 50%; left: 5%; transform: translate(-50%, -50%); cursor: pointer;">

        <div class="youtube" style="display: none;">
            <iframe id="youtubeVideo1" width="1472" height="475" src="https://youtube.com/embed/rjW9E1BR_30?autoplay=0&mute=1&controls=0&showinfo=0&modestbranding=1" frameborder="0" allowfullscreen="allowfullscreen"></iframe>
            <iframe id="youtubeVideo2" width="1472" height="475" src="https://youtube.com/embed/6kjApj4YXgY?autoplay=0&mute=1&controls=0&showinfo=0&modestbranding=1" frameborder="0" allowfullscreen="allowfullscreen"></iframe>
            <iframe id="youtubeVideo3" width="1472" height="475" src="https://youtube.com/embed/pMAPj6WVsT4?autoplay=0&mute=1&controls=0&showinfo=0&modestbranding=1" frameborder="0" allowfullscreen="allowfullscreen"></iframe>
            <iframe id="youtubeVideo4" width="1472" height="475" src="https://youtube.com/embed/tu4TyftCqw8?autoplay=0&mute=1&controls=0&showinfo=0&modestbranding=1" frameborder="0" allowfullscreen="allowfullscreen"></iframe>
            <iframe id="youtubeVideo5" width="1472" height="475" src="https://youtube.com/embed/3q28FbqoyYg?autoplay=0&mute=1&controls=0&showinfo=0&modestbranding=1" frameborder="0" allowfullscreen="allowfullscreen"></iframe>
            <iframe id="youtubeVideo6" width="1472" height="475" src="https://youtube.com/embed/b0yAOYIvP1Y?autoplay=0&mute=1&controls=0&showinfo=0&modestbranding=1" frameborder="0" allowfullscreen="allowfullscreen"></iframe>
            <iframe id="youtubeVideo7" width="1472" height="475" src="https://youtube.com/embed/pMAPj6WVsT4?autoplay=0&mute=1&controls=0&showinfo=0&modestbranding=1" frameborder="0" allowfullscreen="allowfullscreen"></iframe>
            
        </div>
    </div>
</div>

<script>
    let currentImageIndex = 0;
    const totalImages = 7; // 총 이미지 개수

    window.onload = function() {
        // 모든 이미지를 숨김
        for (let i = 0; i < totalImages; i++) {
            document.getElementById('posterImage' + (i + 1)).style.display = 'none';
        }

        // 첫 번째 이미지만 표시
        document.getElementById('posterImage1').style.display = 'block';
    };

    function toggleImage(direction) {
        // 이미지 변경
        if (direction === 'next') {
            currentImageIndex = (currentImageIndex + 1) % totalImages;
        } else if (direction === 'prev') {
            currentImageIndex = (currentImageIndex - 1 + totalImages) % totalImages;
        }

        // 모든 이미지를 숨김
        for (let i = 0; i < totalImages; i++) {
            document.getElementById('posterImage' + (i + 1)).style.display = 'none';
        }

        // 다음 이미지를 표시
        document.getElementById('posterImage' + (currentImageIndex + 1)).style.display = 'block';

        // 현재 이미지에 해당하는 영상을 표시
        document.querySelector('.youtube').style.display = 'none'; // 모든 영상 숨김
        document.getElementById('youtubeVideo' + (currentImageIndex + 1)).style.display = 'block'; // 해당하는 영상만 표시
        document.getElementById('playicon').style.display = 'block';;
    }

    function toggleVideo() {
        var image = document.getElementById('posterImage' + (currentImageIndex + 1));
        var icon = document.getElementById('playicon');
        var videoDiv = document.querySelector('.youtube');

        if (image.style.display !== 'none') { // 이미지가 표시되어 있는 경우
            // 현재 이미지만 표시하고 나머지 이미지는 숨깁니다.
            for (let i = 0; i < totalImages; i++) {
                if (i !== currentImageIndex) {
                    document.getElementById('posterImage' + (i + 1)).style.display = 'none';
                }
            }
            // 현재 이미지에 해당하는 영상만 표시합니다.
            for (let i = 0; i < totalImages; i++) {
                document.getElementById('youtubeVideo' + (i + 1)).style.display = 'none';
            }
            document.getElementById('youtubeVideo' + (currentImageIndex + 1)).style.display = 'block';
            // 이미지, 아이콘, 비디오를 숨기고 비디오를 재생합니다.
            image.style.display = 'none';
            icon.style.display = 'none';
            videoDiv.style.display = 'block';
            playVideo();
            // 비디오 재생이 끝나면 이미지와 비디오를 순서대로 표시합니다.
            document.getElementById('youtubeVideo' + (currentImageIndex + 1)).addEventListener('ended', function() {
                image.style.display = 'block';
                icon.style.display = 'block';
                videoDiv.style.display = 'none';
            });
        } else { // 이미지가 숨겨져 있는 경우 (즉, 비디오가 표시 중인 경우)
            // 이미지와 아이콘을 표시하고 비디오를 숨깁니다.
            image.style.display = 'block';
            icon.style.display = 'block';
            videoDiv.style.display = 'none';
            // 비디오를 일시 정지합니다.
            pauseVideo();
        }
    }


    function playVideo() {
        var youtubeIframe = document.getElementById('youtubeVideo' + (currentImageIndex + 1));
        // 비디오를 재생하는데, src의 autoplay=0을 autoplay=1로 변경하여 자동 재생합니다.
        youtubeIframe.src = youtubeIframe.src.replace('autoplay=0', 'autoplay=1');
    }

    function pauseVideo() {
        var youtubeIframe = document.getElementById('youtubeVideo' + (currentImageIndex + 1));
        // 비디오를 일시 정지하기 위해 postMessage를 사용하여 pauseVideo 명령을 전달합니다.
        youtubeIframe.contentWindow.postMessage('{"event":"command","func":"' + 'pauseVideo' + '","args":""}', '*');
    }
</script>



	<div class="section3">
		<!-- <div class="soje"
			style="width: 140px; margin: 0px 0px 0px 370px; padding-top: 50px;">
			<p
				style="color: #777; margin: 0; font-size: 24px; font-weight: bold; text-align: center;">박스오피스</p>
		</div>
		<hr style="border: 1px solid #777; margin: 5px 330px 30px 330px"> -->

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
			// 최대 5개의 영화만 표시
			int maxMoviesToShow = 5;
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
				%>
				<div class="movie-item" style="position: relative;">
					<div class="image-container">
						<img src="/resources/images/poster/<%=movieCd%>.jpg"
							style="width: 200px; height: 150; margin: 0">
					</div>


					<p
						style="position: absolute; top: 238px; left: 20px; color: #eee; font-size: 64px;"><%=rank%></p>
					<p style="font-weight: bold;"><%=movieTitle%></p>
					<p>
						예매율 :<%=salesShare%>%
					</p>
					<c:choose>
						<c:when test="${sessionScope.userid!=null}">
							<button onclick="moviebook('<%=movieCd%>')">예매</button>
						</c:when>
						<c:otherwise>
							<button onclick="confirmAction()">예매</button>
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
				function moviebook(movieCd) {
				        window.location.href = '/ticket/book_tickets.do?movieCd=' + movieCd;
				    }</script>
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


	<div class="section4">
		<div class="soje"
			style="width: 140px; margin: 10px 0px 30px 370px; padding-top: 50px;">
			<p
				style="color: black; margin: 0; font-size: 24px; font-weight: bold; text-align: center;">EVENT</p>
			<hr style="border: 1px solid black;">
		</div>

		<div class="adimg" style="text-align: center;">
			<button onclick="window.location.href='/detail.do?num=4'"
				style="border: none; background: none; cursor: pointer;">
				<img src="/resources/images/adver/ad2.png"
					style="width: 350px; height: 350px; margin: 0 20px">
			</button>
			<button onclick="window.location.href='/detail.do?num=5'"
				style="border: none; background: none; cursor: pointer;">
				<img src="/resources/images/adver/ad3.png"
					style="width: 350px; height: 350px; margin: 0 20px">
			</button>
			<button onclick="window.location.href='/detail.do?num=6'"
				style="border: none; background: none; cursor: pointer;">
				<img src="/resources/images/adver/ad4.png"
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

      <div class="soje" style="width: 140px; margin: 10px 0px 30px 370px; padding-top: 50px;">
         <p style="color: black; margin:0; font-size: 24px; font-weight : bold; text-align:center;">STORE</p>
         <hr style="border: 1px solid black;">
      </div>
      
      <div class="store" style="margin: 0 350px 100px 350px; display: flex; align-items: center;">
      
         <div style="border: 1px solid #ddd; border-radius: 20px; padding: 10px; width: 350px; margin : 0  10px;">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <h2 style="margin: 10px;">콤보</h2>
                <button onclick="window.location.href='../store/index.jsp'" style="margin: 10px;">더보기</button>
            </div>
            <div style="display: flex; align-items: center; ">
               <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=203'" style="margin: 0 0 0 20px; padding: 0; border: none; background: none; cursor: pointer;"><img src="/resources/images/store/cgv.jpg" style="width: 100px; height: 100px; margin:0 20px "></button>
              <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=203'" style="margin: 0; padding: 0;border: none; background: none; cursor: pointer;"><p style= "font-size:16px ">쌍용콤보<br>10,000원</p></button>
           </div>
           <div style="display: flex; align-items: center; ">
               <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=204'" style="margin: 0 0 0 20px; padding: 0; border: none; background: none; cursor: pointer;"><img src="/resources/images/store/large.jpg" style="width: 100px; height: 100px; margin:0 20px "></button>
              <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=204'" style="margin: 0; padding: 0;border: none; background: none; cursor: pointer;"><p style= "font-size:16px ">라지콤보<br>15,000원</p></button>
           </div>
           <div style="display: flex; align-items: center; ">
               <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=202'" style="margin: 0 0 0 20px; padding: 0; border: none; background: none; cursor: pointer;"><img src="/resources/images/store/small.jpg" style="width: 100px; height: 100px; margin:0 20px "></button>
              <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=202'" style="margin: 0; padding: 0;border: none; background: none; cursor: pointer;"><p style= "font-size:16px ">스몰콤보<br>7,000원</p></button>
           </div>
        </div>
        
        <div style="border: 1px solid #ddd; border-radius: 20px; padding: 10px; width: 350px; margin : 0 10px ;">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <h2 style="margin: 10px;">스낵</h2>
                <button onclick="window.location.href='../store/index.jsp'" style="margin: 10px;">더보기</button>
            </div>
            <div style="display: flex; align-items: center; ">
               <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=224'" style="margin: 0 0 0 20px; padding: 0; border: none; background: none; cursor: pointer;"><img src="/resources/images/store/me.jpg" style="width: 100px; height: 100px; margin:0 20px "></button>
              <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=224'" style="margin: 0; padding: 0;border: none; background: none; cursor: pointer;"><p style= "font-size:16px ">오징어<br>3,500원</p></button>
           </div>
           <div style="display: flex; align-items: center; ">
               <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=220'" style="margin: 0 0 0 20px; padding: 0; border: none; background: none; cursor: pointer;"><img src="/resources/images/store/chili.jpg" style="width: 100px; height: 100px; margin:0 20px "></button>
              <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=220'" style="margin: 0; padding: 0;border: none; background: none; cursor: pointer;"><p style= "font-size:16px ">칠리치즈나쵸<br>4,900원</p></button>
           </div>
           <div style="display: flex; align-items: center; ">
               <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=221'" style="margin: 0 0 0 20px; padding: 0; border: none; background: none; cursor: pointer;"><img src="/resources/images/store/plain.jpg" style="width: 100px; height: 100px; margin:0 20px "></button>
              <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=221'" style="margin: 0; padding: 0;border: none; background: none; cursor: pointer;"><p style= "font-size:16px ">플레인핫도그<br>4,500원</p></button>
           </div>
        </div>
        
<!--         <div style="border: 1px solid #ddd; border-radius: 20px; padding: 10px; width: 350px; margin : 0  10px;">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <h2 style="margin: 10px;">굿즈</h2>
                <button onclick="window.location.href='../store/index.jsp'" style="margin: 10px;">더보기</button>
            </div>
            <div style="display: flex; align-items: center; ">
               <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=262'" style="margin: 0 0 0 20px; padding: 0; border: none; background: none; cursor: pointer;"><img src="/resources/images/store/pamiobook.jpg" style="width: 100px; height: 100px; margin:0 20px "></button>
              <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=262'" style="margin: 0; padding: 0;border: none; background: none; cursor: pointer;"><p style= "font-size:16px ">파묘 책갈피<br>3,000원</p></button>
           </div>
           <div style="display: flex; align-items: center; ">
               <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=264'" style="margin: 0 0 0 20px; padding: 0; border: none; background: none; cursor: pointer;"><img src="/resources/images/store/wonkachoco.jpg" style="width: 100px; height: 100px; margin:0 20px "></button>
             <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=264'" style="margin: 0; padding: 0;border: none; background: none; cursor: pointer;"><p style= "font-size:16px ">웡카 초콜릿<br>4,000원</p></button>
           </div>
           <div style="display: flex; align-items: center; ">
               <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=267'" style="margin: 0 0 0 20px; padding: 0; border: none; background: none; cursor: pointer;"><img src="/resources/images/store/dunepad.jpg" style="width: 100px; height: 100px; margin:0 20px "></button>
              <button onclick="window.location.href='/cinema/store_servlet/detail.do?product_code=267'" style="margin: 0; padding: 0;border: none; background: none; cursor: pointer;"><p style= "font-size:16px ">듄 마우스패드<br>15,000원</p></button>
           </div>
        </div> -->
        
      </div>
      

<div class="section5" style=" background-color:#3a4b3b;">
         <div class="downimg">
         <div class="close-button" onclick="closeimg1()">
            <img src="/resources/images/icon/close black.png"  style="width:20px; height: 20px;" alt="Close">
         </div>
         <img src="/resources/images/adver/ad5.png" style="width: 100%; height: 100%;">
      </div>
      </div>
      </div>

      <script>
          function closeimg1() {
              // 이미지를 감싸고 있는 요소의 display 속성을 'none'으로 설정하여 숨깁니다.
              document.querySelector('.downimg').style.display = 'none';
          }
      </script>
      
      <%@ include file="include/footer.jsp" %>
      
</body>
</html>