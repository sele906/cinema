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
	margin: 0px;
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

.foot {
	margin: 0 10%;
}

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
	<%@include file="../menu/menu.jsp" %>
	
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

	<%@ include file="../include/footer.jsp" %>

	
</body>
</html>