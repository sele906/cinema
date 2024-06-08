<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%@include file="../menu/menu.jsp" %>
<body>
<% String context=request.getContextPath();
response.sendRedirect(context+"/show/list.do");%>
</body>
</html>