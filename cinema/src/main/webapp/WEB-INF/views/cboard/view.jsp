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
        .btn-back {
            margin-bottom: 20px;
            padding: 10px 20px;
            background-color: #808080; /* 회색 */
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-back:hover {
            background-color: #666666; /* 마우스 호버 시 색상 변경 */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            background-color: #f9f9f9; /* 배경색 변경 */
        }
        th {
            font-weight: normal;
            min-width: 120px; /* 테이블 헤더 최소 너비 */
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
        .btn-edit {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-edit:hover {
            background-color: #0056b3;
        }
    </style>
  
</head>
<body>
<div class="container">
   <input type="button" class="btn btn-back" value="목록" onclick="location.href='/cboard/main.do'">
    <table>
        <tr>
            <th style="min-width: 150px;">분류</th>
            <td style="min-width: 200px;">
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
            <th>날짜</th>
            <td>${dto.reg_date}</td>
        </tr>
        <tr>
            <th>조회수</th>
            <td>${dto.see}</td>
        </tr>
        <tr>
            <th>내용</th>
            <td class="post-contents" colspan="2">${dto.contents}</td>
        </tr>
    </table>
    <div class="btn-container">
    <input type="hidden" name="num" value="${dto.num}">
    </div>
</div>
</body>
</html>
