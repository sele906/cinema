<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
    }
    table {
        border-collapse: collapse;
        width: 100%;
        margin-top: 20px;
    }
    th, td {
        text-align: left;
        padding: 8px;
    }
    th {
        background-color: #4CAF50;
        color: white;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    a {
        color: #333;
        text-decoration: none;
    }
    a:hover {
        text-decoration: underline;
    }
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%@ include file="../include/admin_menu.jsp"%>
<body>
	<table border="1" width="500px">
		<tr align="center">
			<th>아이디</th>
			<th>이름</th>
			<th>생년월일</th>
		</tr>
		<c:forEach var="row" items="${list}">
			<tr align="center">
				<td>${row.userid}</td>
				<td><a href="/member/detail.do?userid=${row.userid}">
						${row.name}</a></td>
				<td>${row.birth}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>