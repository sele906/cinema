
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.section1 {
	margin: 0 10%;
}

.main-menu a:hover {
	color: #ffcc00;
}

.container a:hover {
	color: red;
}

header {
	text-align: center;
	background-color: #222;
	color: white;
	padding: 0px 40px 0px 40px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
	bottom: 0;
}

.sidebar {
	float: left; /* 왼쪽으로 부유시킵니다. */
	width: 200px; /* 사이드바 너비를 지정합니다. */
}

body {
	margin: 0; /* body의 기본 여백을 제거합니다. */
}

.movie-item {
	display: inline-block;
}

.movie-item img {
	width: 200px; /* 이미지 너비를 200px로 설정합니다. */
	height: 150px; /* 이미지 높이를 150px로 설정합니다. */
}

.container .a {
	display: inline-block; /* 링크를 인라인 블록 요소로 만듭니다. */
	margin-right: 20px; /* 링크 사이의 간격을 설정합니다. */
	font-size: 20px; /* 링크의 글꼴 크기를 설정합니다. */
	color: gray; /* 링크의 글꼴 색상을 회색으로 설정합니다. */
	text-decoration: none; /* 밑줄 제거 */
}

.poster {
	position: relative;
	display: inline-block;
	/* 이미지와 버튼이 올바르게 배치될 수 있도록 inline-block으로 설정합니다. */
}

.deleteButton {
	position: absolute;
	top: 5px;
	right: 5px;
	width: 30px; /* 버튼의 너비를 지정합니다. */
	height: 30px; /* 버튼의 높이를 지정합니다. */
	background-color: black; /* 배경색을 검정으로 지정합니다. */
	border: 2px solid white; /* 테두리를 흰색으로 지정합니다. */
	border-radius: 50%; /* 동그라미 모양의 버튼을 만듭니다. */
	color: white; /* 텍스트 색상을 흰색으로 지정합니다. */
	font-size: 18px; /* 텍스트 크기를 조정합니다. */
	cursor: pointer;
}


    .redbutton {
        background-color: #cc0000;
        color: white;
        padding: 2px 16px;
        border: none;
        border-radius: 5px;
        font-size: 15px;
        cursor: pointer;
        font-weight:bold;
        margin:2px 0 0 0;
    }
table {
margin:0;
width:100%;
}

table td:nth-child(1) {
    width: 15%;
    vertical-align: top;
    margin:0;
}

table td:nth-child(2) {
    width: 85%;
    margin:0;
}

</style>
</head>
<body>
	<%@include file="../menu/menu.jsp"%>

	<div class="section1">
		<table>
			<tr>
				<td>
			
	
		<div class="container">
			<div class="sidebar" style="margin-top: 30px;">
				<div
					style="display: flex; justify-content: center; align-items: center; flex-direction: column; text-align: center;">
					<div
						style="border: 1px solid #000; border-radius: 10px; background-color: #fff; padding: 10px; margin-bottom: 10px; width: 180px; height: 180px; font-size: 18px; font-weight: bold">
						<img src="/resources/images/profile/${sessionScope.filename}" alt="이미지"
							onerror="this.onerror=null; this.src='/resources/images/basic.png';"
							style="border-radius: 50%; overflow: hidden; width: 150px; height: 150px; margin-bottom: 8px;"
							height="120px"><br> ${sessionScope.name}님
					</div>
				</div>
				<div
					style="border: 1px solid #000; border-radius: 10px; background-color: #fff; padding: 10px; margin-bottom: 10px; text-align: center">
					<a href="/mypage/list.do"
						style="color: black; text-decoration: none;">기대되는 영화</a>
				</div>
				<div
					style="border: 1px solid #000; border-radius: 10px; background-color: #fff; padding: 10px; margin-bottom: 10px; text-align: center">
					<a href="#" style="color: black; text-decoration: none;">내가 본 영화</a>
				</div>
				<div
					style="border: 1px solid #000; border-radius: 10px; background-color: #fff; padding: 10px; text-align: center">
					<a href="/review/list.do" style="color: black; text-decoration: none;">내가 쓴 리뷰</a>
				</div>
			</div>

		</div>

</td>
<td>

		<div class="main-content"">
	<c:choose>
    <c:when test='${type == "like"}'>
        <c:choose>
            <c:when test='${empty list or list.size() == 0}'>
                <div style="text-align: center;">
                    <h3 style="margin-right: 100px;">
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>기대되는 영화가 없습니다.<br> 영화 상세에서 '하트버튼'을 클릭하여 영화를 추가해보세요.
                    </h3>
                    <br>
                    <button onclick="window.location.href='/moviechart.do'">무비차트</button>
                </div>
            </c:when>
            <c:otherwise>
            <p style="margin: 25px 0 30px 35px; font-size : 22px; font-weight:bold;">기대되는 영화</p>
                <c:forEach var="row" items="${list}">
                    <div class="poster" style="margin : 0 40px 40px 40px;">
                        <a href="/like/heart.do?movieCd=${row.moviecode}"><img src="/resources/images/poster/${row.moviecode}.jpg"
                            style="width: 240px; height: 360px; margin:0;"></a>
                        <button class="deleteButton" onclick="deleteLike('${row.moviecode}')">X </button>
                        <hr style="border: 1px solid #ccc; margin: 7px 0 4px 0;">
                        <p style="text-align:center; font-size:24px; font-weight:bold; margin:0"> ${row.movieTitle}</p>
                        <hr style="border: 1px solid #ccc; margin: 4px 0 7px 0;">
                        <p style="text-align:center; margin-top:2px;"><button onclick="moviebook('${row.moviecode}')" class="redbutton">예매</button></p>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test='${type == "review"}'>
        <c:choose>
            <c:when test='${empty list or list.size() == 0}'>
                <div style="text-align: center;">
                    <h3 style="margin-right: 100px;">
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>작성한 리뷰가 없습니다.<br> 영화 상세에서 '리뷰버튼'을 클릭하여 리뷰를 남겨주세요.
                    </h3>
                    <br>
                    <button onclick="window.location.href='/moviechart.do'">무비차트</button>
                </div>
            </c:when>
            <c:otherwise>
            	<p style="margin: 25px 0 30px 35px; font-size : 22px; font-weight:bold;">내가 작성한 리뷰</p>
                  <c:forEach var="row" items="${list}">
                    <div class="poster" style="margin : 0 40px 40px 40px;">
                    	<div style="display: flex;    line-height: 35px;border-bottom: 1px solid #ddd; ">
                    		<div>
		                        <a href="/like/heart.do?movieCd=${row.moviecode}"><img src="/resources/images/poster/${row.moviecode}.jpg"
		                            style="width: 140px; height: 200px; margin:0;"></a>
		                        <button class="deleteButton" onclick="deleteReview('${row.review_id}')">X </button>
	                        </div>
	                        <div style="width:650px; margin-left: 50px">
		                        <p style="text-align:left; font-size:24px; font-weight:bold; margin-bottom:15px; display: inline-block;  line-height: 35px;border-bottom: 2px solid #bbb;"> ${row.movieTitle}</p>
		                        <p style="text-align:left; font-size:24px; font-weight:bold; margin:0">
								    <script>
								        // 숫자값 가져오기
								        var ratingValue = ${row.value};
								
								        // 별 생성 함수
								        function generateStars(value) {
								            var stars = '';
								            for (var i = 0; i < value; i++) {
								                stars += '★'; // 별 문자 추가
								            }
								            return stars;
								        }
								        // 별 출력
								        document.write(generateStars(ratingValue));
								    </script>
								</p>
		                         <p style="text-align:left; font-size:16px; font-weight:normal; margin:15px 0 0 0; display: inline-block;  line-height: 35px; " > ${row.content}</p>

	                        </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </c:when>
</c:choose>
		</div>
		
		</td>
		</tr>
		</table>

	</div>
</body>
<script>
function deleteReview(review_id) {
	$.ajax({
		type : "post",
		url : "/review/delete.do",
		data : {
			"review_id" : review_id
		// 올바른 데이터 필드 사용
		},
		success : function(txt) {
			location.reload();
		}
	});
}
	function deleteLike(moviecode) {
		$.ajax({
			type : "post",
			url : "/like/delete.do",
			data : {
				"moviecode" : moviecode
			// 올바른 데이터 필드 사용
			},
			success : function(txt) {
				location.reload();
			}
		});
	}
	function moviebook(movieCd) {
		window.location.href = '/ticket/book_tickets.do?movieCd='+ movieCd;
	}
</script>
				
</html>
