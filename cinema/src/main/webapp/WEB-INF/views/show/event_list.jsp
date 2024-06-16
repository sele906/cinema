<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    body {
        margin: 0;
    }
    
    .foot {
		margin: 0 10%;
	}

    .container {
        max-width: 1000px;
        margin: 0 10%;
        padding: 0 20px;
        font-size: 18px;
        font-weight: bold;
    }

    .movie-item {
        display: inline-block;
    }

    .movie-item img {
        width: 200px;
        height: 250px;
        margin-right: 40px;
    }

    .container .a {
        display: inline-block;
        margin-right: 20px;
        font-size: 20px;
        color: gray;
        text-decoration: none;
    }
</style>
</head>
<body>
<%@include file="../menu/menu.jsp" %>
<div class="container">
    <a href="<c:url value="/list.do" />" style="text-decoration: none;"><h1 style="color: black;">EVENT</h1></a>
    <hr style="border-top: 5px solid black;">
    <a href="<c:url value="/category.do?type=영화" />" style="text-decoration: none; color: black;">영화</a> / <a href="<c:url value="/category.do?type=굿즈" />" style="text-decoration: none; color: black;">굿즈</a> / <a href="<c:url value="/category.do?type=할인" />" style="text-decoration: none; color: black;">할인</a> 
    <hr style="border-top: 2px solid black;">
    
    <br> <br>
    <h2>
        영화<a href="<c:url value="/category.do?type=영화" />" style="color: green; font-size: 24px; float: right; text-decoration: none;">+</a>
    </h2>
    <hr style="border-top: 2px solid black;">
    <div class="combo">
        <c:forEach var="row" items="${list}">
            <c:if test="${row.type == '영화'}">
                <a href="<c:url value="/detail.do?num=${row.num}" />">
                    <div class="movie-item">
                        <img src="/resources/images/store/${row.filename1}" style="width: 200px; height: 300;">
                        <p style="font-size: 16px; font-weight: bold; color: #333;">${row.subject}</p>
                    </div>
                </a>
            </c:if>
        </c:forEach>
    </div>
    <h2>
        굿즈<a href="<c:url value="/category.do?type=굿즈" />" style="color: green; font-size: 24px; float: right; text-decoration: none;">+</a>
    </h2>
    <hr style="border-top: 2px solid black;">
    <div class="combo">
        <c:forEach var="row" items="${list}">
            <c:if test="${row.type == '굿즈'}">
                <a href="<c:url value="/detail.do?num=${row.num}" />">
                    <div class="movie-item">
                        <img src="/resources/images/store/${row.filename1}" style="width: 200px; height: 150;">
                        <p style="font-size: 16px; font-weight: bold; color: #333;">${row.subject}</p>
                    </div>
                </a>
            </c:if>
        </c:forEach>
    </div>
    <h2>
        할인<a href="<c:url value="/category.do?type=할인" />" style="color: green; font-size: 24px; float: right; text-decoration: none;">+</a>
    </h2>
    <hr style="border-top: 2px solid black;">
    <div class="combo">
        <c:forEach var="row" items="${list}">
            <c:if test="${row.type == '할인'}">
                <a href="<c:url value="/detail.do?num=${row.num}" />">
                    <div class="movie-item">
                        <img src="/resources/images/adver/${row.filename1}" style="width: 200px; height: 150;">
                        <p style="font-size: 16px; font-weight: bold; color: #333;">${row.subject}</p>
                    </div>
                </a>
            </c:if>
        </c:forEach>
    </div>
</div> 

<%@ include file="../include/footer.jsp" %>

</body>
</html>
