<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="http://code.jquery.com/jquery-3.6.1.js"></script>
    <script>
        $(function(){
            $("#btnWrite").click(function(){
                location.href="/cinema/event/write.jsp";
            });
        });
        function delete_event(num) {
        	if (confirm("삭제하시겠습니까?")) {
        		location.href="/cinema/event/delete.do?num="+num;
        		//document.form1.action = "/cinema/product_servlet/delete.do";
        		//document.form1.submit();
        	}
        }  
    </script>
</head>
<body>
<%@ include file="../include/admin_menu.jsp"%>
    <h2>이벤트</h2>
    <form name="form1" method="post" action="/event/search.do">
        <select name="search_option">
            <c:choose>
                <c:when test="${search_option==null||search_option=='all'}">
                    <option value="all" selected>전체검색</option>
                    <option value="type">분류</option>
                    <option value="subject">제목</option>
                    <option value="contents">내용</option>
                </c:when>
                <c:when test="${search_option=='type'}">
                    <option value="all">전체검색</option>
                      <option value="type" selected>분류</option>
                    <option value="subject">제목</option>
                    <option value="contents">내용</option>
                </c:when>
                <c:when test="${search_option=='subject'}">
                    <option value="all">전체검색</option>
                    
                      <option value="type">분류</option>
                    <option value="subject" selected>제목</option>
                    <option value="contents">내용</option>
                </c:when>
                <c:when test="${search_option=='contents'}">
                    <option value="all">전체검색</option>
                      <option value="type">분류</option>
                    <option value="subject">제목</option>
                    <option value="contents" selected>내용</option>
                </c:when>
            </c:choose>
        </select>
        <input name="keyword" value="${keyword}">
        <input type="submit" value="검색" id="btnSearch">
        <button type="button" id="btnWrite">글쓰기</button>
    </form>
    <table border="1" width="900px">
        <tr>
            <th>번호</th>
            <th>분류</th>
            <th>제목</th>
            <th>날짜</th>
            <th>&nbsp;</th>
        </tr>
        <c:forEach var="dto" items="${list}">
            <tr align="center">
                <td>${dto.num}</td>
                <td>${dto.type}</td>
                <td align="left">
                    <a href="/event/view.do?num=${dto.num}">${dto.subject}</a>
                </td>
                <td>${dto.reg_date}</td>
                <td><img src="/resources/images/store/${dto.filename1}" width="100px" height="100px"></td>
                <td>
						<input type="button" value="삭제" onclick="delete_event('${dto.num}')">
				</td>
            </tr>
        </c:forEach>
</body>
</html>
