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
</head>
<style>
* {
	margin: 0;
	padding: 0;
}

body {
	background-color: #fff;
}

#page-wrap {
	margin: 0 auto;
	width: 850px;
	height: 609px;
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
	align-items: flex-start;
}

#title-wrap {
	padding: 30px 0 10px 0;
}
#title-wrap h2 {
	padding: 0 0 8px 0;
}

#wrap {
	display: grid;
	grid-template-columns: 300px 150px 1fr 1fr;
	grid-template-rows : 40px 1fr;
	justify-content: center;
}

.item {
	/* border-right: 1px solid red; */
}

/* 표 머리부분 */
.item:nth-child(1) {
	grid-column: 1 / 5;
	grid-row: 1 / 2;
	
	display: grid;
	grid-template-columns: 300px 150px 1fr 1fr;
	justify-content: center;
	align-items: center;
	
	border-top: 2px solid black;
	border-bottom: 1px solid black;
}
.title-item {
	height:25px;
	text-align: center;
	font-weight: bold;
}
.title-item:nth-child(4) {
	border: none;
}

/* 1번째 칸 */

.item:nth-child(2) {
	grid-column: 1 / 2;
	grid-row: 2 / 3;
	
	display: flex;
	flex-direction:column;
	justify-content: center;
	align-items: center;
	padding: 40px;
	
	border-right: 1px solid grey;
}
.item:nth-child(2) input {
	display: none;
}
.item:nth-child(2) h2 {
	font-size: 1.5em;
	padding: 5px;
}
.item:nth-child(2) p {
	font-size: 1.1em;
	padding: 0 3px 3px 3px;
}

/* 2번째 칸 */

.item:nth-child(3) {
	grid-column: 2 / 3;
	grid-row: 2 / 3;
	
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
	align-items: center;
	
	border-right: 1px solid grey;
	
	overflow-y: auto;
	height: 488px;
}

.item:nth-child(3)::-webkit-scrollbar-track
{
	background-color: #F5F5F5;
}

.item:nth-child(3)::-webkit-scrollbar
{
	width: 10px;
	background-color: #F5F5F5;
}

.item:nth-child(3)::-webkit-scrollbar-thumb
{
	background-color: grey;
}

.item:nth-child(3) input {
	display: none;
}

.places {
	padding: 14px;
	font-size: 1.1em;
	font-weight: bold;
	border-bottom: 1px grey solid;
}
.places:nth-child(9) {
	border: none;
}

.places:hover {
	cursor: pointer;
	color: red;
}
.places.clicked {
    color: red;
}

/* 세번째 칸 */

.item:nth-child(4) {
	grid-column: 3 / 4;
	grid-row: 2 / 3;
	
	min-width: 200px;	
	border-right: 1px solid grey;
}

#choose_day {
	overflow-y: scroll;
	height: 488px;
}
#choose_day::-webkit-scrollbar-track
{
	background-color: #F5F5F5;
}

#choose_day::-webkit-scrollbar
{
	width: 10px;
	background-color: #F5F5F5;
}

#choose_day::-webkit-scrollbar-thumb
{
	background-color: grey;
}

#day_warning_box {
	width: 100%;
	height: 100%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}
#day_warning {
	text-align: center;
}

.day_box {
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
	padding: 15px;
	border-bottom: 1px solid grey;
}
.day_box .info {
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: flex-start;
	padding: 0 0 10px 0;
}
.day_box .info .title {
	padding: 0 10px 0 0;
	border-right: 1px grey solid;
}
.day_box .info .place {
	padding: 0 0 0 10px;
}
.day_box .day {
	font-size: 1.4em;
}


.day_box:hover {
	cursor: pointer;
	color: red;
}
.day_box:hover .title {
	border-right: 1px solid red;
}
.day_box.clicked {
    color: red;
}
.day_box.clicked .title {
	border-right: 1px solid red;
}


/* 네번째 칸 */

.item:nth-child(5) {
	grid-column: 4 / 5;
	grid-row: 2 / 3;
	
	min-width: 150px;	
}

#choose_time {
	overflow-y: scroll;
	height: 488px;
}
#choose_time::-webkit-scrollbar-track
{
	background-color: #F5F5F5;
}

#choose_time::-webkit-scrollbar
{
	width: 10px;
	background-color: #F5F5F5;
}

#choose_time::-webkit-scrollbar-thumb
{
	background-color: grey;
}

#time_warning_box {
	width: 100%;
	height: 100%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}
#time_warning {
	text-align: center;
}

#form3 {
	display: none;
}
.time_box {
	display: flex;
	flex-direction: row;
	align-items: baseline;
	justify-content: center;
	margin: 10px;
	padding: 10px 5px;
	border-radius: 10px;
}
.time_box .theaterNum {
	padding: 0 7px 0 0;
}
.time_box .time {
	font-size: 1.7em;
	font-weight: bold;
}

.time_box:hover {
	cursor: pointer;
	background-color: red;
	color: white;
}

</style>
<script>
$(function(){
	
 	$("#choose_day").css("display", "none");
	$("#choose_time").css("display", "none"); 
	
	
	$(".places").click(function(){ //장소 선택
		
		//클릭될때마다 클래스 click 상태로 바꾸기
		$(".places").removeClass("clicked"); //기존 clicked 클래스 지우기
		
		//경고창 지우기
		$("#day_warning_box").css("display", "none");
		$("#time_warning_box").css("display", "none");
		
		$(this).addClass("clicked");
		
        var selectedPlace = $(this).text();
        $("#cinema_place").val(selectedPlace);
        
        let movie_title=$("#movie_title").val();
    	let cinema_place=$("#cinema_place").val();
    	
    	//다음화면으로 전달할 값
    	let params = {
   			"movie_title":movie_title,
   			"cinema_place":cinema_place
    	}
        
        //시간표 보여주기
        if (cinema_place != "") {
			$.ajax({
				type: "POST",
				url: "/ticket/movie_place.do",
				data: params,
				success: function(txt){
					console.log(txt);
					$("#choose_day").css({
						"display": "flex", 
						"flex-direction": "column"
					});
					$("#choose_day").html(txt);
					$("#choose_time").html("");
					$("#choose_time").css("display", "none");
					$("#time_warning_box").css("display", "flex");
				}
			}); 
		} else {
		}
    });
});

$(document).on('click','.day_box', function(){ //날짜 선택
	
	$(".day_box").removeClass("clicked"); 
	$(this).addClass("clicked");
	
	let title = $(this).find(".title").html().trim();
	let place = $(this).find(".place").html().trim();
	let day = $(this).find(".day").html().trim();
	
	//다음화면으로 전달할 값
	let params = {
		"title":title,
		"place":place,
		"day": day
	}
    
    //영화시간 보여주기
    if (cinema_place != "") {
		$.ajax({
			type: "POST",
			url: "/ticket/movie_time.do",
			data: params,
			success: function(txt){
				$("#choose_time").css({
					"display": "flex", 
					"flex-direction": "column"
				});
				$("#choose_time").html(txt);
				$("#time_warning_box").css("display", "none");
			}
			
		}); 
	}
});

$(document).on('click','.time_box', function(){ //시간 선택 
	let movieCd = $("#movie_code").val();
	
	let input = $('<input>', {
        'type': 'hidden',
        'name': 'movieCd',
        'value': movieCd
    });
	
 	$(this).find('form').append(input); 
    $(this).find('form').submit();
});

</script>
<body>

<!-- 메뉴 -->
<%@include file="../menu/menu.jsp" %>

<div id="page-wrap">

	<div id="title-wrap">
		<h2>상영 시간</h2>
	</div>

	<div id="wrap">
		<div class="item">
			<div class="title-item">
				영화
			</div>
			
			<div class="title-item">
				지역 선택
			</div>
			
			<div class="title-item">
				날짜 선택
			</div>
			
			<div class="title-item">
				시간 선택
			</div>	
		</div>
		
		<div class="item">
		
		<img src="/resources/images/poster/${map.IMGPATH}" width="200px" height="300px">
		
		<h2>${map.MOVIE_TITLE}</h2>
		
		
		<p>13000원</p>
		
		<!-- input 전달값 숨기기 -->
		<input name="movie_code" id="movie_code" value="${movieCd}">
		<input name="movie_title" id="movie_title" value="${map.movie_title}">
		<input name="movie_price" value="${map.price}">
		
		</div>
		
		<div class="item">
			
			<div class="places">SYC강남</div>
			<div class="places">SYC건대</div>
			<div class="places">SYC대학로</div>
			<div class="places">SYC명동</div>
			<div class="places">SYC압구정</div>
			<div class="places">SYC여의도</div>
			<div class="places">SYC잠실</div>
			<div class="places">SYC성남</div>
			<div class="places">SYC고양</div>
			<div class="places">SYC부천</div>
			<div class="places">SYC의정부</div>
			<div class="places">SYC구리</div>
			<div class="places">SYC인천</div>
			<div class="places">SYC송도</div>
			<div class="places">SYC강릉</div>
			<div class="places">SYC춘천</div>
			<div class="places">SYC속초</div>
			<div class="places">SYC대전</div>
			<div class="places">SYC세종</div>
			<div class="places">SYC청주</div>
			<div class="places">SYC대구</div>
			<div class="places">SYC경주</div>
			<div class="places">SYC창원</div>
			<div class="places">SYC김해</div>
			<div class="places">SYC부산</div>
			<div class="places">SYC광안리</div>
			<div class="places">SYC울산</div>
			<div class="places">SYC광주</div>
			<div class="places">SYC순천</div>
			<div class="places">SYC여수</div>
			<div class="places">SYC목포</div>
			<div class="places">SYC제주</div>
			<div class="places">SYC서귀포</div>
			
			
			<br>
			<input name="cinema_place" id="cinema_place">
			
		</div>
		
		<div class="item">
			<div id="day_warning_box">
				<div id="day_warning"> 지역을 선택하세요 </div>
			</div>
			
			<div id="choose_day"></div>
		</div>
		
		<div class="item">
			<div id="time_warning_box">
				<div id="time_warning"> 날짜를 선택하세요</div>
			</div>
			
			<!-- 시간 선택시 로그인 여부 알아보기 -->
			
			<c:if test="${param.message eq 'error'}">
			    <script>
			    	if (confirm('로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?')) {
			    		location.href = "/login.do"
			    	}
			    </script>
			</c:if>
			
			<div id="choose_time"></div>
		</div>
	
	</div>
	
</div>




</body>
</html>