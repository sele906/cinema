<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>

<head>
<script>
	function openPopup1() {
		// 팝업 창을 띄우기
		window.open("/member/idsearch.do", 'edit', 'width=550, height=450');
	}
	function openPopup2() {
		// 팝업 창을 띄우기
		window.open("/member/pwsearch.do", 'edit', 'width=550, height=450');
	}
</script>
<style>
body {
	/* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	font-family: Arial, sans-serif;
	background-color: white;
}

.section1 {
	margin: 50px 0 150px 0;
}

.foot {
	margin: 0 10%;
}

.titleword {
	padding-top: 20px;
	font-weight: bold;
	font-size: 24px;
}

.downimg {
	position: relative;
	display: block;
	margin: 0px auto;
	width: 60%;
	height: 60%;
}

.sideimg {
	position: absolute;
	top: 320px;
	right: 50px;
}

.close-button {
	position: absolute;
	top: 8px;
	right: 10px;
	cursor: pointer;
}

form {
	width: 360px;
	background-color: #eee;
	padding: 20px;
	border-radius: 5px;
	/* box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); */
}

#loginForm  input[type="text"], #loginForm  input[type="password"],
	#loginForm  input[type="submit"] {
	border: 1px solid #777;
	border-radius: 3px;
	box-sizing: border-box;
}

#loginForm input[type="submit"] {
	background-color: #cc0000;
	color: #fff;
	cursor: pointer;
	transition: background-color 0.3s;
}

#loginForm  input[type="submit"]:hover {
	background-color: #660000;
}

.blue p {
	text-align: center;
	margin-top: 10px;
}

.blue a {
	color: #black;
	text-decoration: none;
}

#login_info {
	display: flex;
    align-items: flex-end;
    height: 52px;
}
#login_test {
	display: flex;
    padding: 0 10px;
    align-items: center;
    height: 30px;
}
#get_login_test {
	margin: 0 5px;
	cursor: pointer;
}
label {
	cursor: pointer;
}
</style>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<link rel="icon" href="../images/clearicon.ico" type="image/x-icon">
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- SweetAlert2 스크립트 먼저 호출 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- 그 다음에 스위트 얼럿을 표시하는 스크립트 호출 -->
<c:if test='${message=="error"}'>
    <script>
        alert("아이디 혹은 비밀번호가 잘못되었습니다.")
    </script>
</c:if>


<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="/resources/images/icon/clearicon.ico" type="image/x-icon">
</head>


<body>

	<%@include file="../menu/menu.jsp"%>

	<div class=section1
		style="display: flex; justify-content: center; align-items: center; background: #eee">



		<div
			style="display: flex; align-items: center; margin: 50px 0 50px 0;">
			<div>
			    <div id="login_info">
					<div class=titleword>로그인</div>
					<div id="login_test">
						<input type="checkbox" id="get_login_test">
						<label for="get_login_test">테스트 로그인</label>
					</div>
				</div>
				

				<hr style="border: 1px solid #ccc; margin: 10px 0;">

				<form id="loginForm" method="post">

					<div style="display: flex; align-items: center;">
						<div style="width: 260px;">
							<input id="userid" name="userid" placeholder="아이디를 입력하세요"
								style="width: 242px; height: 40px; margin-bottom: 5px;">
							<input id="passwd" type="password" name="pwd1" placeholder="비밀번호를 입력하세요"
								style="width: 250px; height: 41px;">
						</div>
						<div>
							<input type="button" value="로그인"
								style="width: 90px; height: 90px; margin: 0 5px; font-size: 18px; font-weight: bold; background-color: #cc0000; color: white;" onclick="login('login')">
						</div>
					</div>
					<p class="blue"
						style="display: flex; justify-content: center; align-items: center; margin: 20px 0 0 0;">
						<a href="/member/register.do" style="font-size: 13px; color: black">회원가입</a>&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;
						<button onclick="openPopup1()"
							style="border: none; background: none; cursor: pointer;">
							아이디찾기</button>
						&nbsp;&nbsp;/&nbsp;&nbsp;
						<button onclick="openPopup2()"
							style="border: none; background: none; cursor: pointer;">
							비밀번호찾기</button>
							&nbsp;&nbsp;/&nbsp;&nbsp;
						<button onclick="login('admin')"
							style="border: none; background: none; cursor: pointer;">
							관리자</button>
					</p>
				</form>

			</div>
			<div>
				<img src="/resources/images/adver/ad6.png"
					style="width: 480px; height: 240px; margin-left: 80px">
			</div>
		</div>

	</div>


	<div class="section5" style="background-color: #3a4b3b;">
		<div class="downimg">

			<img src="/resources/images/adver/ad5.png" style="width: 100%; height: 100%;">
		</div>
	</div>







	<script>

		//체크박스 선택
		var checkbox = document.getElementById('get_login_test');

		// 체크박스 상태 변경
		checkbox.addEventListener('change', function () {
			if (checkbox.checked) {
				userid = document.getElementById('userid');
				passwd = document.getElementById('passwd');
				loginform = document.getElementById('loginForm');

				userid.value = 'cois34';
				passwd.value = '1234';

				loginform.action="/member/login.do";
				loginform.submit();
			}
		});

		function closeimg1() {
			// 이미지를 감싸고 있는 요소의 display 속성을 'none'으로 설정하여 숨깁니다.
			document.querySelector('.downimg').style.display = 'none';
		}

		function closeimg2() {
			// 이미지를 감싸고 있는 요소의 display 속성을 'none'으로 설정하여 숨깁니다.
			document.querySelector('.sideimg').style.display = 'none';
		}

		function login(level) {

			logindata = document.getElementById('loginForm');
			userid = document.getElementById('userid');
			passwd = document.getElementById('passwd');

			if (userid == '') {
				alert('아이디를 입력하세요');
			}
			if (passwd == '') {
				alert('비밀번호를 입력하세요');
			}

			if (level == 'login') {
				logindata.action="/member/login.do";
				logindata.submit();
			}

			if (level == 'admin') {
				logindata.action="/admin/login.do";
				logindata.submit();
			}

		}
	</script>

	<%@ include file="../include/footer.jsp" %>

</body>

</html>