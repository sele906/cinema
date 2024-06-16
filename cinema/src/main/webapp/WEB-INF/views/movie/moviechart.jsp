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



.foot {
margin: 0 10%;
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
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="../../../resources/images/icon/clearicon.ico" type="image/x-icon">
</head>


<body>
	
<%@include file="../menu/menu.jsp" %>

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
     
      
      
      <!-- <div class="sideimg">
         <div class="close-button" onclick="closeimg2()">
            <img src="../../../resources/images/icon/close black.png"  style="width:20px; height: 20px;" alt="Close">
         </div>
         <img src="../../../resources/images/adver/ad4.png" style="width: 230px; height: 400px;">
      </div> -->
   
      
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
		
	<%@ include file="../include/footer.jsp" %>
		
</body>

</html>