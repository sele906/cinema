<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.io.IOException"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@ page import="com.example.cinema.api.ApiCaller"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>

<!DOCTYPE html>
<html>

<head>
<style>
body {
	margin: 0;
	font-family: Arial, sans-serif;
}

.titleword {
	padding-top: 20px;
	font-weight: bold;
	font-size: 24px;
	margin-left: 350px;
}

.section1 {
	/* background-color: black; */
	background: linear-gradient(to top, black, #333, #444);
	/*background-color: #222;*/
	/*background: linear-gradient(to right, red, black, red, black, red, black, red, black, red, black, #222, #222, #222, #222, #222, #222, #222, #222, #222, black, red, black, red, black, red, black, red, black, red);
	*/
	padding: 0px;
	width: 100%;
}

.section2 {
	margin-top: 20px;
	margin-bottom: 20px;
}

.titleword {
	padding-top: 20px;
	font-weight: bold;
	font-size: 24px;
	margin-left: 350px;
}

.menu-item {
	margin: 20px; /* Increase the margin */
}

.section3 {
	/* background-color: #222; */
	/*background: linear-gradient(to right, red, black, red, black, red, black, red, black, red, black, #222, #222, #222, #222, #222, #222, #222, #222, #222, black, red, black, red, black, red, black, red, black, red);
	*/
	background: linear-gradient(to bottom, black, #333, #444);
	padding: 0px;
	width: 100%;
}

.foot {
	margin: 0 10%;
}

/*@media ( max-width : 1600px) {
	body {
		margin: 0;
	}
}*/

.board-heading {
            text-align: center;
            margin-bottom: 20px;
        }

        .search-form {
            text-align: center;
            margin-bottom: 20px;
        }



.poster {
	margin: 0 330px;
	background: linear-gradient(to bottom, black, #333, #444);
	/*background-color: #222; */
	display: flex;
	justify-content: center; /* 아이템을 수평으로 가운데 정렬합니다. */
	align-items: flex-start; /* 아이템을 상단에 정렬합니다. */
	flex-wrap: wrap;
}

.poster img {
	width: 200px;
	height: 300px;
	margin: 10px;
}

.movie-item-container {
	color: white;
	font-size: 16px;
	justify-cotent: center;
	display: flex;
	flex-wrap: wrap;
	justify-content: space-around;
}

.movie-item {
	width: 200px;
	margin: 15px;
	text-align: center;
}

.movie-item p {
	margin: 4px 0; /* 각 문단의 위아래 여백을 조절 */
}

.youtube {
	padding: 0 330px;
	/*width: 100%;*/
	margin-bottom: 0;
	padding-bottom: 0;
	overflow: hidden;
}

.youtube iframe {
	width: 100%;
	height: 475px; /* 조절 가능한 높이값 설정 */
}

.image-container {
	position: relative;
	display: inline-block;
}

.image-container::before {
	content: "";
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: linear-gradient(to top, rgba(0, 0, 0, 0.5) 0%,
		rgba(0, 0, 0, 0) 100%);
	pointer-events: none;
}
</style>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SSANG YONG CINEMA</title>
<link rel="icon" href="/resources/images/icon/clearicon.ico" type="image/x-icon">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<c:if test="${param.message=='logout'}">
	<script>
		alert('로그아웃되었습니다.');
	</script>
</c:if>


<script>
	function list(page) {
		location.href = "/cboard/qna.do?cur_page=" + page
				+ "&search_option=${search_option}&keyword=${keyword}";
	}
</script>

<style>
.board-heading {
	text-align: center;
	margin-bottom: 20px;
}

.search-form {
	text-align: center;
	margin-bottom: 20px;
}

.menu-item {
	margin: 10px; /* 버튼 간격 조절 */
}

.menu-item input[type="button"] {
	background-color: #000000; /* 검정색 배경 */
	color: white; /* 흰색 텍스트 */
	border: none; /* 테두리 제거 */
	padding: 10px 20px; /* 내부 여백 */
	cursor: pointer; /* 커서 모양 */
	font-size: 16px; /* 텍스트 크기 */
}

.menu-item input[type="button"]:hover {
	background-color: #0056b3; /* 마우스 호버 시 배경색 변경 */
}
</style>
<style>
table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
	color: #333;
}
</style>

<style>
    /* 마우스를 올렸을 때 색상 변경할 클래스 */
    .highlight-row:hover {
        background-color: grey; /* 원하는 색상으로 변경하세요 */
    }
</style>

<script>
    // JavaScript를 사용하여 효과 추가
    $(document).ready(function() {
        // 각 행에 마우스가 올라갔을 때 이벤트를 추가합니다.
        $(".highlight-row").hover(
            function() {
                $(this).addClass("highlight-row"); // 클래스를 추가하여 색상 변경
            },
            function() {
                $(this).removeClass("highlight-row"); // 클래스를 제거하여 원래 색상으로 돌림
            }
        );
    });
</script>





</head>

<body>
	
	<%@include file="../menu/menu.jsp" %>

	<div class="section2" style="margin-top: 20px; margin-bottom: 20px;">
		<div class="titleword">고객센터</div>

		<div style="display: flex; justify-content: center;">
			<div class="menu-item">
				<input type="button" id="noti" value="공지사항"
					onclick="location.href='/cboard/index.do'">
			</div>
			<div class="menu-item">
				<input type="button" id="qna" value="자주 묻는 질문"
					onclick="location.href='/cboard/qnaindex.do'">
			</div>
		</div>
	</div>
		<div>
			<div class="titleword">자주 묻는 질문</div>
			
			<div class="search-form">
			<form name="form2" method="get" action="/cboard/cearch.do">
			<select name="csearch_option">
				<c:choose>
					<c:when test="${csearch_option == null || csearch_option =='all' }">
						<option value="all" selected>전체검색</option>
						<option value="subject">제목</option>
						<option value="contents">내용</option>
					</c:when>
	
					<c:when test="${csearch_option == 'subject' }">
						<option value="all">전체검색</option>
	
						<option value="subject" selected>제목</option>
						<option value="contents">내용</option>
					</c:when>
					<c:when test="${csearch_option == 'contents' }">
						<option value="all">전체검색</option>
					
						<option value="subject">제목</option>
						<option value="contents" selected>내용</option>
					</c:when>
				</c:choose>
		</select>
		<input name = "keyword" value="${keyword}">
		<input type="submit" value="검색" id="btnsearch">
		</form>
		</div>
		</div>
		
		
		<div style="margin: 0 auto; width: 900px;">
			<table border="1" width="900px">
				<tr>
					<th>번호</th>
					<th style="min-width: 120px;">분류</th>
					<th>제목</th>
					<th>조회수</th>
					<th>날짜</th>
				</tr>
				<c:forEach var="dto" items="${list}">
					<c:if test="${dto.type == 2}">
						<tr align="center" class="highlight-row" onclick="location.href='/cboard/view.do?num=${dto.num}'">
							<td>${dto.num}</td>
							<td><c:choose>
									<c:when test="${dto.type == 1}">공지사항</c:when>
									<c:when test="${dto.type == 2}">자주 묻는 질문</c:when>
								</c:choose></td>
							<td>${dto.subject}</td>
							<td>${dto.see}</td>
							<td>${dto.reg_date.substring(0, 10)}</td>
						</tr>
					</c:if>
				</c:forEach>
				<tr align="center">
					<td colspan="7"><c:if test="${page.curPage>1}">
							<a href="#" onclick="list('1')">[처음]</a>
						</c:if> <c:if test="${page.curBlock>1}">
							<a href="#" onclick="list('${page.prevPage}')">[이전]</a>
						</c:if> <c:forEach var="num" begin="${page.blockStart}"
							end="${page.blockEnd}">
							<c:choose>
								<c:when test="${num==page.curPage}">
									<span style="color: red">${num}</span>
								</c:when>
								<c:otherwise>
									<a href="#" onclick="list('${num}')">${num}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach> <c:if test="${page.curBlock<page.totBlock}">
							<a href="#" onclick="list('${page.nextPage}')">[다음]</a>
						</c:if> <c:if test="${page.curPage<page.totPage}">
							<a href="#" onclick="list('${page.totPage}')">[마지막]</a>
						</c:if></td>
				</tr>
			</table>


		</div>

		<div class="section3"></div>


		<div class="section4">
			<div class="soje"
				style="width: 140px; margin: 10px 0px 30px 370px; padding-top: 50px;">
				<p
					style="color: black; margin: 0; font-size: 24px; font-weight: bold; text-align: center;">EVENT</p>
				<hr style="border: 1px solid black;">
			</div>

			<div class="adimg" style="text-align: center;">
				<button onclick="#"
					style="border: none; background: none; cursor: pointer;">
					<img src="/resources/images/adver/ad1.png"
						style="width: 350px; height: 350px; margin: 0 20px">
				</button>
				<button onclick="#"
					style="border: none; background: none; cursor: pointer;">
					<img src="/resources/images/adver/ad2.png"
						style="width: 350px; height: 350px; margin: 0 20px">
				</button>
				<button onclick="#"
					style="border: none; background: none; cursor: pointer;">
					<img src="/resources/images/adver/ad3.png"
						style="width: 350px; height: 350px; margin: 0 20px">
				</button>
			</div>
			<div
				style="text-align: center; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; width: 100%; font-size: 18px; font-weight: bold;">
				<div style="display: inline-block; margin: 0 20px; width: 350px">
					<p>통신사 혜택으로 쌍용시네마에서 할인받자 !!</p>
				</div>
				<div style="display: inline-block; margin: 0 20px; width: 350px">
					<p>톡학생증 발급하면 쌍용시네마 영화 할인</p>
				</div>
				<div style="display: inline-block; margin: 0 20px; width: 350px">
					<p>쌍용시네마에서만 즐길 수 있는 무비퀘스트 !</p>
				</div>
			</div>
		</div>

	<%@ include file="../include/footer.jsp" %>

		
</body>
</html>