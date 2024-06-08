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
 
 	<div class="day_box">
 	
 		<div class="info">
 			<div class="title">
 			${row.movie_title}
	 		</div>
	 		
	 		<div class="place">
	 			${row.cinema_place}
	 		</div>
 		</div>
 		
 		<div class="day">
 			${row.time}
 		</div> 
 		
 	</div>
	
</c:forEach>
<br>


</body>
</html>