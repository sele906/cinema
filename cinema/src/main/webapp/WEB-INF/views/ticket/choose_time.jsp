<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:forEach var="row" items="${list}">

	<div class="time_box">
		
		<div class="theaterNum">
			${row.theater_num}관
		</div>
		
		<div class="time">
			${row.time}
		</div>
	
		<form name="form3" id="form3" method="post" action="${path}/ticket/seats.do">
			<input name="idx" value="${row.time_idx}">
		</form>
	
	</div>
	
</c:forEach>


</body>
</html>