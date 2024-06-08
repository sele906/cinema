<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<title>공지사항/이벤트 등록</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<style>
a:hover {
	color: red;
	text-decoration: underline;
	cursor: pointer;
}
</style>
<script>
	function list(page) {
		location.href = "/board/list.do?cur_page=" + page
				+ "&search_option=${search_option}&keyword=${keyword}";

	}
</script>
</head>

<body class="p-3 m-0 border-0 bd-example m-0 border-0">
	<form name="form1" method="post"
		action="/board/search.do">
		<select name="search_option">
			<c:choose>
				<c:when test="${search_option == null || search_option == 'all'}">
					<option value="all" selected>전체검색</option>
					<option value="subject">제목</option>
					<option value="contents">내용</option>
				</c:when>


				<c:when test="${search_option == 'subject'}">
					<option value="all">전체검색</option>
					<option value="subject" selected>제목</option>
					<option value="contents">내용</option>
				</c:when>
				<c:when test="${search_option == 'contents'}">
					<option value="all">전체검색</option>
					<option value="subject">제목</option>
					<option value="contents" selected>내용</option>
				</c:when>
			</c:choose>
		</select> <input name="keyword" value="${keyword}"> <input
			type="submit" value="확인" id="btnSearch">

		<button type="button" value="글쓰기"
			onclick="location.href='/board/write.do'">글쓰기</button>
	</form>
	<table class="table" border="1">
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">분류</th>
				<th scope="col">제목</th>
				<th scope="col">날짜</th>
				<th scope="col">조회수</th>
			</tr>
		</thead>

		<tbody class="table-group-divider">

			<c:forEach var="dto" items="${list}">
				<tr>
					<td scope="row">${dto.num}</td>
					<td><c:choose>
							<c:when test="${dto.type == 1}">공지사항</c:when>
							<c:when test="${dto.type == 2}">자주 묻는 질문</c:when>
						</c:choose></td>
					<td
						onclick="location.href='/board/post.do?num=${dto.num}'"><a>${dto.subject}</a></td>
					<td>${dto.reg_date}</td>
					<td>${dto.see}</td>
				</tr>
			</c:forEach>
			<tr align="center">
				<td colspan="7"><c:if test="${page.curPage > 1}">
						<a href="#" onclick="list('1')">[처음]</a>
					</c:if> <c:if test="${page.curBlock > 1}">
						<a href="#" onclick="list('${page.prevPage}')">[이전]</a>
					</c:if> <c:forEach var="num" begin="${page.blockStart}"
						end="${page.blockEnd}">
						<c:choose>
							<c:when test="${num == page.curPage}">
								<span style="color: red">${num}</span>
							</c:when>
							<c:otherwise>
								<a href="#" onclick="list('${num}')">${num}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach> <c:if test="${page.curBlock < page.totBlock}">
						<a href="#" onclick="list('${page.nextPage}')">[다음]</a>
					</c:if> <c:if test="${page.curPage < page.totPage}">
						<a href="#" onclick="list('${page.totPage}')">[마지막]</a>
					</c:if></td>
			</tr>
	</table>

</body>
</html>