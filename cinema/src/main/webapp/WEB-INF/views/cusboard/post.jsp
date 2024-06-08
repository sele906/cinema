<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 페이지</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .btn-back, .btn-edit {
            background-color: #6c757d;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-back:hover, .btn-edit:hover {
            background-color: #5a6268;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
            font-weight: normal;
        }
        .post-image {
            max-width: 100%;
            height: auto;
            display: block;
            margin-bottom: 20px;
        }
        .post-contents {
            line-height: 1.6;
            color: #333;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <input type="button" class="btn btn-back" value="목록" onclick="location.href='/board/list.do'">
    <table>
        <tr>
            <th>분류</th>
            <td>
                <c:choose>
                    <c:when test="${dto.type==1}">공지사항</c:when>
                    <c:when test="${dto.type==2}">자주 묻는 질문</c:when>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th>제목</th>
            <td>${dto.subject}</td>
        </tr>
        <tr>
            <th>조회수</th>
            <td>${dto.see}</td>
        </tr>
    </table>

    <c:choose>
        <c:when test="${dto.filename=='-' || empty dto.filename}">
            <img class="post-image" src="/resources/images/notification.png">
        </c:when>
        <c:otherwise>
            <img class="post-image" src="/resources/images/${dto.filename}">
        </c:otherwise>
    </c:choose>

    <div class="post-contents">${dto.contents}</div>

    <div class="btn-container">
    <input type="hidden" name="num" value="${dto.num}">
        <input type="button" class="btn btn-edit" value="수정/삭제" onclick="location.href='/board/edit.do?num=${dto.num}'">
    </div>
</div>
</body>
</html>