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
	let movie_title=$("#movie_title").val();
	let movie_price=$("#movie_price").val();
	let movie_time=$("#movie_time").val();
	let theater_num=$("#theater_num").val();
	let cinema_place=$("#cinema_place").val();
	let time_idx=$("#time_idx").val();
	
	let params = {
			"imgpath":imgpath,
			"movie_title":movie_title,
			"movie_price":movie_price,
			"movie_time":movie_time,
			"theater_num":theater_num,
			"cinema_place":cinema_place,
			"time_idx":time_idx
	};
	
	$.ajax({
		url: "/ticket/seat_screen.do",
		type: "POST",
		data: params,
		success: function(txt){
			console.log(txt);
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
	포스터이미지경로: <input type="text" id="imgpath" value="${map.imgpath}"><br>
	영화제목: <input type="text" id="movie_title" value="${map.movie_title}"><br>
	금액: <input type="text" id="movie_price" value="${map.price}"><br>
	시간: <input type="text" id="movie_time" value="${map.time}"><br>
	상영관: <input type="text" id="theater_num" value="${map.theater_num}"><br>
	영화관: <input type="text" id="cinema_place" value="${map.cinema_place}"><br>
	
	영화코드: <input type="text" id="movie_cd" value="${map.movieCd}"><br>
	시간코드: <input type="text" id="time_idx" value="${time_idx}"><br>
</div>

<div id="seatBox"></div>

</div>
</body>
</html>