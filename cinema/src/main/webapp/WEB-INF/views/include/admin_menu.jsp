<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .navbar {
        overflow: hidden;
        background-color: #333;
        font-family: Arial, sans-serif;
    }
    .navbar a {
        float: left;
        font-size: 16px;
        color: white;
        text-align: center;
        padding: 14px 20px;
        text-decoration: none;
    }
    .navbar a:hover {
        background-color: #ddd;
        color: black;
    }
    .navbar-right {
        float: right;
    }
    .navbar-user {
        float: right;
        padding: 14px 20px;
        color: #f2f2f2;
    }
</style>

<div class="navbar">
    <c:choose>
        <c:when test="${sessionScope.admin_userid == null}">
            <!-- 로그인하지 않은 사용자를 위한 컨텐츠가 필요하다면 여기에 추가 -->
        </c:when>
        <c:otherwise>
        <a href="/cboard/main.do">공지사항/자주 묻는 질문</a>
            <a href="/product/list.do">상품목록</a>
            <a href="/shop/product_write.jsp">상품등록</a>
            <a href="/list.do">이벤트</a>
            <a href="/member/index.jsp">회원관리</a>
            <div class="navbar-user">
                ${sessionScope.admin_name}님이 로그인 중입니다.
                <a href="/admin/logout.do" class="navbar-right">로그아웃</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
