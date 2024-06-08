<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
input, textarea, select, button {
    font-size: 13px;
    line-height: 1.2;
    color: #666;
    font-family: 'Noto Sans KR', 'CJONLYONENEW', '맑은 고딕', '돋움', Dotum, sans-serif;
    font-weight: 400;
}

body {
    background-color: #333;
}

table {
    font-size: 13px;
    line-height: 1.2;
    color: #666;
    font-family: 'Noto Sans KR', 'CJONLYONENEW', '맑은 고딕', '돋움', Dotum, sans-serif;
    font-weight: 400;
    width: 100%;
    table-layout: fixed;
}

table td:nth-child(1) {
    width: 35%;
}

table td:nth-child(2) {
    width: 45%;
}

table td:nth-child(3) {
    width: 20%;
}

.bigsection1 {
    background-color: #eee;
    margin: 0;
}

.bigsection1 .head {
    margin: 0 80px;
    color: white;
}

.bigsection1 .section1 {
    margin: 0 80px;
    background-color: #ddd;
}

.bigsection1 .section1 .contents {
    font-size: 13px;
    line-height: 1.2;
    color: #666;
    font-family: 'Noto Sans KR', 'CJONLYONENEW', '맑은 고딕', '돋움', Dotum, sans-serif;
    font-weight: 400;
    background-color: #ddd;
}
</style>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<c:if test="${param.message=='wrong' }">
	<script>
		alert("회원정보가 일치하지 않습니다.");
	</script>
</c:if>

<script>

    function update() {
        document.getElementById('form1').action = "/member/findpwd.do";
        document.getElementById('form1').submit();
    }

    function cancelEdit() {
        window.close();
    }
</script>
</head>
<body>
    <header>
    </header>
    <h3 style="border: 1px solid white; margin: 5px 0">
        <div style="margin: 10px 80px; color: white;">비밀번호 찾기</div>
    </h3>
    <div class="bigsection1">
        <div class="head">
        </div>
        <div class="section1">
            <div class="contents">
                <form id="form1" name="form1" method="post" >
                    <table>
                    <tr>
                    <td><div style="margin: 0 0 0 30px">아이디</div></td>
                    <td><input type="text" name="userid"></td>
                    </tr>
                        <tr>
                            <td><div style="margin: 0 0 0 30px">이름</div></td>
                            <td><input type="text" name="name"></td>
                        </tr>
                        <tr>
                          <td><div style="margin: 0 0 0 30px">생년월일</div></td>
                            <td style="color: #ddd;"><input type="text" name="birth"></td>
                        </tr>
                        <tr>
                            <td><div style="margin: 0 0 0 30px">이메일</div></td>
                            <td><input type=email name="email"></td>
                        </tr>
                        <tr>
                            <td style="color: #ddd;">ㅇㅇ</td>
                            <td style="color: #ddd;">ㅇㅇ</td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <c:if test= "${findpwd!=null}">
        당신의 비밀번호는 ${findpwd} 입니다.
    </c:if>
        <div style="display: flex; justify-content: center; margin-top: 20px;">
            <button onclick="update()" style="margin-right: 15px; font-size: 14px;">찾기</button>
            <button type="button" onclick="cancelEdit()" style="font-size: 14px;">닫기</button>
        </div>
        <br><br><br>
    </div>
</body>
</html>
