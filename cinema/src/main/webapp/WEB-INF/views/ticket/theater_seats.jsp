<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
* {
	margin: 0;
	padding: 0;
}
body {
	background-color: #222;
}

#page_wrap {
	width:1200px;
	padding: 50px 0;
	margin: 0 auto;
	display: flex;
	flex-direction: column;
}

#title {
	color: white;
	display: flex;
	align-items: baseline;
	justify-content: flex-start;
	
}
#title h2 {
	padding: 0 0 8px 0;
}

#getitem {
	display: none;
}
#seatBox {
	margin: 10px 0 30px 0;
	border-top: 1px solid white;
	border-bottom: 1px solid white;
	display: flex;
	align-items: center;
	justify-content: center;
}
</style>
<script>
$(function(){
	
	/* 좌석 데이터 전달 */
	
	let imgpath=$("#imgpath").val();
	let movieTitle=$("#movieTitle").val();
	let moviePrice=$("#moviePrice").val();
	let movieTime=$("#movieTime").val();
	let theaterNum=$("#theaterNum").val();
	let cinemaPlace=$("#cinemaPlace").val();
	let time_idx=$("#time_idx").val();
	
	let params = {
			"imgpath":imgpath,
			"movieTitle":movieTitle,
			"moviePrice":moviePrice,
			"movieTime":movieTime,
			"theaterNum":theaterNum,
			"cinemaPlace":cinemaPlace,
			"time_idx":time_idx
			}
	$.ajax({
		type: "post",
		url: "${path}/ticket/seat_screen.do",
		data: params,
		success: function(txt){
			$("#seatBox").html(txt);
		}
	});
});
</script>
</head>
<body>

<!-- 메뉴 -->

<%@include file="../menu/menu.jsp" %>

<!-- 좌석 예매 -->
<div id="page_wrap">

<div id="title">
	<h2>좌석 선택</h2>
</div> 

<div id="getitem">
	가져온 값<br>
	아이디: <input type="text" id="id" value="${sessionScope.userid}"><br>
	포스터이미지경로: <input type="text" id="imgpath" value="${map.IMGPATH}"><br>
	영화제목: <input type="text" id="movieTitle" value="${map.MOVIE_TITLE}"><br>
	금액: <input type="text" id="moviePrice" value="${map.PRICE}"><br>
	시간: <input type="text" id="movieTime" value="${map.TIME}"><br>
	상영관: <input type="text" id="theaterNum" value="${map.THEATER_NUM}"><br>
	영화관: <input type="text" id="cinemaPlace" value="${map.CINEMA_PLACE}"><br>
	
	영화코드: <input type="text" id="movieCd" value="${map.MOVIECD}"><br>
	시간코드: <input type="text" id="time_idx" value="${time_idx}"><br>
</div>

<div id="seatBox"></div>

</div>
</body>
</html>