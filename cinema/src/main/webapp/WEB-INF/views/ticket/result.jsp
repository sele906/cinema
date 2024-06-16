<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>

$(function() {
	
	$("#cancel_All").click(function() {
		$(':checkbox').each(function() {
	        this.checked = true;                       
	    });
 		if (confirm("예매내역을 삭제하시겠습니까?")) {
			document.form1.action = "${path}/ticket/delete.do";
			document.form1.submit(); 
		} 
	});
	
	$(".cancel").click(function() { //예매취소 버튼 클릭시
		console.log('cancel');
		if (confirm("예매내역을 삭제하시겠습니까?")) {
			$(this).closest('#cancel_area').find('.checkbox').prop('checked', true);
			document.form1.action = "${path}/ticket/delete.do";
			document.form1.submit();
		} 
	});
});

</script>

<style>
* {
	margin: 0 auto;
}
body {
	margin: 0; /* body의 기본 여백을 제거합니다. */
}
#page-wrap {
	margin: 0 330px;
}
#Tcontainer {
	display: flex;
	flex-direction: column;
	align-items: center;
}
.title-container {
	width: 80%;
    margin: 20px 0 10px 0;
    display: flex;
    flex-direction: row;
    align-items: flex-end;
    justify-content: space-between;
}
#cancel_All {
	margin: 0 20px 0 5px;
	padding: 10px 15px;
} 
.titleword {
	margin: 0;
    padding-top: 20px;
    font-weight: bold;
    font-size: 27px;
}
#Ttable {
  width: 80%;
  border:none;
  border-collapse: collapse;
  text-align: center;
}
#Ttable img {
	width: 100px;
} 
#Ttable th {
	border-bottom: 2px solid black;
	padding: 10px;
} 
#Ttable td {
  border-bottom: 1px solid black;
  vertical-align: middle;
  padding: 10px;
}
#Ttable th:nth-child(1), #Ttable td:nth-child(1) {width: 80px;}
#Ttable th:nth-child(2), #Ttable td:nth-child(2) {padding: 0 5%;}
#Ttable th:nth-child(3), #Ttable td:nth-child(3) {width: 100px;}

#STable {
	width: 100%;
	text-align: left;
}
#STable td {
	padding: 5px;
	border-bottom: 1px solid gray;
}
#STable tr:nth-child(4) td {
	border: none;
}
.Mtitle {
	height: 50px;
	font-size: 1.2em;
}
.Minfo1 {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-content: center;
}
.Minfo1 div {
	margin: 0;
}
.Minfo2 {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-content: center;
}
.Minfo2 div {
	margin: 0;
	padding: 0 5px 0 0;
}
.Mseats {
	display: flex;
	flex-direction: row;
}
.Mseats div:nth-child(2) {
	border-right: 1px solid gray;
}
.Mseats div:nth-child(3) {
	padding: 3px 0 0 5px;
}
span {
	color: gray;
	font-size: 0.9em;
}
#cancel_area input {
	margin: 0 5px;
	padding: 10px 15px;
}
#cancel_area .checkbox {
	display: none;
}

.cancel, #home, #cancel_All {
	border: 1px solid red;
	background-color: white;
	color:red;
	border-radius: 10px;
}
.cancel:hover, #cancel_All:hover {
	background-color: red;
	color: white;
}

/* 예매내역 없을 떄 */
#Ttable #empty {
	padding: 40px 0 50px 0;
}

</style>

</head>
<body>
<%@include file="../menu/menu.jsp" %>


<div id="page-wrap">

	<div id="Tcontainer">
		<div class="title-container">
	   		<div class="titleword">예매 내역</div>
	   		<input type="button" id="cancel_All" value="전체취소">
		</div>
	</div>
	
	<hr style="border: 1px solid #ccc; margin: 10px 0;">
	
	<form name="form1" method="post">
	
	<table id="Ttable">
		<tr style="display:none;">
			<th></th>
			<th>티켓번호</th>
			<th>포스터</th>
			<th>영화제목</th>
			
			<th>영화관</th>
			<th>상영관</th>
			<th>좌석번호</th>
			<th>상영시간</th>
			
			<th>금액</th>
		</tr>
		<c:choose>
	    <c:when test='${empty bookTickets or bookTickets.size() == 0}'>
	        <tr>
	            <td colspan="9" id="empty">예매내역이 없습니다</td>
	        </tr>
	    </c:when>
	    
	    <c:otherwise>
	        <c:forEach var="row" items="${bookTickets}">
	            <tr>
	           		<!-- 포스터 -->
	                <td><img src="/resources/images/poster/${row.imgpath}"></td> 
	                
	                <!-- 영화정보 -->
	                <td colspan="6">
	                	<table id="STable">
		                	<tr>
		                		<td class="timeIdx" colspan="3">
		                			<span>예매번호</span>
									<b>${row.ticket_idx}</b>
								</td>
		                	</tr>
	                		<tr>
	                			<td class="Mtitle" colspan="3"><b>${row.movie_title}</b></td>
	                		</tr>
		                	<tr>
		                		<td colspan="3">
		                			<div class="Minfo1">
			                			<div>
			                				<span>관람극장</span>
			                				${row.cinema_place}
			                			</div>
			                			<div>
			                				<span>금액</span>
			                				${row.price}원
			                			</div>
		                			</div>
		                		</td>
		                	</tr>
		                	
							<tr>
								
				                <td colspan="3">
				                	<div class="Minfo2">
			                			<div class="Mseats">
			                				<span>상영관&nbsp;</span>
			                				<div>${row.theater_num}관</div>
			                				<div>${row.seat_name}</div>
			                			</div>
			                			
			                			<div>
			                				<span>상영일시</span>
			                				<fmt:formatDate value="${row.time}" pattern="yyyy-MM-dd" var="day"/>
				                			<fmt:formatDate value="${row.time}" pattern="HH:mm" var="time"/>
			                				${day}&nbsp;${time}
			                			</div>
		                			</div>
				                </td>
							</tr>
	                	</table>
	                </td>
	                
	                <!-- 예매취소 -->
	                <td>
		                <div id="cancel_area">
		                	<input type="checkbox" class="checkbox" name="Tnum" value="${row.ticket_idx}">
		                	<input type="button" class="cancel" value="예매취소">
		                </div>
	                </td>
	            </tr>
	        </c:forEach>
	    </c:otherwise>
	</c:choose>
	</table>
	
	<input type="hidden" name="userid" value="${sessionScope.userid}">
	
	</form>

</div>

</html>