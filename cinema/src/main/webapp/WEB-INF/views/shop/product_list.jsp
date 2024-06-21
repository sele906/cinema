<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<style>
    body {
        font-family: Arial, sans-serif;
    }

    h2 {
        color: #333;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }

    th {
        background-color: #f2f2f2;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .btn-delete {
        background-color: #f44336;
        color: white;
        border: none;
        padding: 5px 10px;
        border-radius: 5px;
        cursor: pointer;
    }

    .btn-delete:hover {
        background-color: #d32f2f;
    }

    img {
        width: 100px;
        height: auto;
    }
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.7.1.js"></script>
<script>
function delete_product(product_code) {
	if (confirm("삭제하시겠습니까?")) {
		location.href="/product/delete.do?product_code="+product_code;
		//document.form1.action = "/cinema/product_servlet/delete.do";
		//document.form1.submit();
	}
}

</script>
</head>
<body>
	<%@ include file="../include/admin_menu.jsp"%>
	<h2>상품목록</h2>
	<c:if test="${sessionScope.admin_userid!=null}">
	</c:if>
	<table border="1" width="500px">
		<tr align="center">
			<th>상품코드</th>
			<th>상품분류</th>
			<th>&nbsp;</th>
			<th>상품명</th>
			<th>가격</th>
			<th>재고삭제</th>
		</tr>
		<c:forEach var="row" items="${list}">
			<tr align="center">
				<td>${row.product_code}</td>
				<td><c:choose>
				<c:when test="${row.product_type == 4}">
            콤보
        </c:when>
						<c:when test="${row.product_type == 1}">
            팝콘
        </c:when>
						<c:when test="${row.product_type == 2}">
            음료
        </c:when>
						<c:when test="${row.product_type == 3}">
            스낵
        </c:when>
        <c:when test="${row.product_type == 5}">
            굿즈
        </c:when>
					</c:choose></td>
				<td><img src="/resources/images/store/${row.filename}" width="100px" height="100px"></td>
				<td><a href="/product/edit.do?product_code=${row.product_code}">
						${row.product_name}</a></td>
				<td><fmt:formatNumber value="${row.price}" pattern="#,###" /></td>
				<td>
						<input type="button" value="삭제" onclick="delete_product('${row.product_code}')">
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>