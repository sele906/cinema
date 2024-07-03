<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<link rel="stylesheet" type="text/css" href="theater_style.css">

</head>
<body>
<!-- 선택된 좌석 리스트 숨기기 -->

<div id="savedseat_list">
	선택된 좌석<br>
	<c:forEach var="dto" items="${list}">
		<div class="saved_seat_num">
			${dto.seat_name}
		</div>
	</c:forEach>
</div>

<div id="wrap">

	<div id="seat_choose_box">
	
	<!-- 선택한 상영관에 따라 영화관 보여주기 -->
	
	<c:set var="num" value="${theater_num}"/>
	<c:if test="${num == 1}">
		<%@include file="../ticket/resource/theater1.html" %>
	</c:if>
	<c:if test="${num == 2}">
		<%@include file="../ticket/resource/theater2.html" %>
	</c:if>
	<c:if test="${num == 3}">
		<%@include file="../ticket/resource/theater3.html" %>
	</c:if>
	<c:if test="${num == 4}">
		<%@include file="../ticket/resource/theater1.html" %>
	</c:if>
	<c:if test="${num == 5}">
		<%@include file="../ticket/resource/theater2.html" %>
	</c:if>
	<c:if test="${num == 6}">
		<%@include file="../ticket/resource/theater3.html" %>
	</c:if>
	<c:if test="${num == 7}">
		<%@include file="../ticket/resource/theater1.html" %>
	</c:if>
	<c:if test="${num == 8}">
		<%@include file="../ticket/resource/theater2.html" %>
	</c:if>
	<c:if test="${num == 9}">
		<%@include file="../ticket/resource/theater3.html" %>
	</c:if>
	
	<div id="info">
		<div class="seat-info">
			<div class="seat"></div>
			<p>빈 좌석</p>
		</div>
		<div class="seat-info">
			<div class="seat select"></div>
			<p>선택한 좌석</p>
		</div>
		<div class="seat-info">
			<div class="seat choose"></div>
			<p>선택된 좌석</p>
		</div>
	</div>
	</div>
	
	<div id="choose_movieinfo">
	
	<form name="form186" id="form186" method="post" action="${path}/ticket/insert.do" >
	
		<div class="choose_info" id="movie_userid">
			${sessionScope.userid} 님 영화 예매내역
		</div>
		
		<img src="/resources/images/poster/${imgpath}">
		
		<div class="choose_info">
			<input id="movie_title" name="movie_title" value="${movie_title}">
		</div>
		
		<div class="choose_info">
			<input id="cinema_place" name="cinema_place" value="${cinema_place}"> | <input id="movie_time" name="movie_time" value="${movie_time}"> | <input id="theater_num" name="theater_num" value="${theater_num}">관
		</div>
		
		<div class="choose_info">
			좌석 정보 <input id="seat_position" name="seat_pos" value="0">
		</div>
		
		<div class="choose_info">
			인원 <input id="seat_count" name="seat_count" value="0">명
		</div>
		
		<div class="choose_info">
			금액 <input id="movieprice" name="movie_price" value="0">원
         <input type="hidden" id="price" value="${movie_price}">
		</div>
		
		<input type="hidden" id="movieCd" name="movie_cd" value="${movie_cd}">
		<input type="hidden" id="time_idx" name="time_idx" value="${time_idx}">
	</form>
	<button  id="btnconfirm" onclick="requestPay()">확인</button>
	</div>
	
</div>
<script>
	function requestPay() {
		var amount = document.getElementById("movie_price").value;
		console.log(amount);
	IMP.init('imp42661322'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
	IMP.request_pay({
		pg : "kakaopay",
		pay_method : "card",
		merchant_uid : 'merchant_' + new Date().getTime(),
		name : "쌍용시네마",
		amount :amount,
		buyer_name :'${sessionScope.name}'
	}, function(rsp) { // callback
		if (rsp.success) {
			var msg = '결제가 완료되었습니다.';
			alert(msg);
		 	document.getElementById('form186').submit();
		} else {
			var msg = '결제에 실패하였습니다.';
			msg += '에러내용 : ' + rsp.error_msg;
			alert(msg);
		}
	});
	}
</script>
<script src="theater_script.js"></script>
</body>
</html>