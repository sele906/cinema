<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
        margin: 0;
        padding: 20px;
    }
    h2 {
        color: #007bff;
    }
    table {
        border-collapse: collapse;
        width: 300px;
        margin-top: 20px;
    }
    td {
        border: 1px solid #dee2e6;
        text-align: left;
        padding: 8px;
    }
    input[type="text"], input[type="password"], input[type="submit"] {
        width: calc(100% - 16px);
        padding: 8px;
        margin-top: 8px;
    }
    input[type="submit"] {
        background-color: #007bff;
        color: white;
        border: none;
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #0056b3;
    }
    .message {
        color: red;
        margin-top: 10px;
    }
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:if test="${param.message=='error' }">
	<script>
		alert("아이디 또는 비밀번호가 일치하지 않습니다.");
	</script>
</c:if>
<c:if test="${param.message=='logout'}">
	<script>
		alert('로그아웃되었습니다.');
	</script>
</c:if>
</head>
<body>
	<%@ include file="../include/admin_menu.jsp"%>
	<h2>관리자 로그인</h2>
	<form method="post" name="form1"
		action="/cinema/admin_servlet/login.do">
		<table border="1">
			<tr>
				<td>아이디</td>
				<td><input name="userid"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="passwd"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="로그인">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>