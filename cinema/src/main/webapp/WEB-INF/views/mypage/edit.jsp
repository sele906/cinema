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
<c:if test="${param.message=='close'}">
    <script>
        window.close();
        window.opener.location.reload();
    </script>
</c:if>
<script>
    function showPostcode() {
        new daum.Postcode({
            oncomplete : function(data) {
                let fullAddr = "";
                let extraAddr = "";
                if (data.userSelectedType === "R") {
                    fullAddr = data.roadAddress;
                } else {
                    fullAddr = data.jibunAddress;
                }
                if (data.userSelectedType === "R") {
                    if (data.bname !== "") {
                        extraAddr += data.bname;
                    }
                    if (data.buildingName !== "") {
                        extraAddr += (extraAddr !== "" ? ", " + data.buildingName : data.buildingName);
                    }
                    fullAddr += (extraAddr !== "" ? "(" + extraAddr + ")" : "");
                }
                document.getElementById("address1").value = fullAddr;
                document.getElementById("address2").focus();
            }
        }).open();
    }

    function update() {
        document.getElementById('form1').action = "/member/update.do";
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
        <div style="margin: 10px 80px; color: white;">회원정보 수정</div>
    </h3>
    <div class="bigsection1">
        <div class="head">
            <br>
            <div style="color:black; margin-bottom:20px; font-size:20px;">
            ${dto.name}님</div>
        </div>
        <div class="section1">
            <div class="contents">
                <form id="form1" name="form1" method="post" enctype="multipart/form-data">
                    <table>
                        <tr>
                            <td><div style="margin: 0 0 0 30px">프로필 이미지</div></td>
                            <td><img src="/resources/images/profile/${dto.filename}" onerror="this.onerror=null; this.src='/resources/images/basic.png';" style="border-radius: 50%; overflow: hidden;" width="100px" height="100px"></td>
                        </tr>
                        <tr>
                            <td style="color: #ddd;"></td>
                            <td><input type="file" name="file1"></td>
                        </tr>
                        <tr>
                            <td style="color: #ddd;"></td>
                            <td style="color: #ddd;">ㅇㅇ</td>
                        </tr>
                        <tr>
                            <td><div style="margin: 0 0 0 30px">비밀번호</div></td>
                            <td><input type="password" name="passwd1" id="passwd1" value=${dto.pwd1}></td>
                        </tr>
                        <tr>
                            <td><div style="margin: 0 0 0 30px">비밀번호 확인</div></td>
                            <td><input type="password" name="passwd2" id="passwd2" value=${dto.pwd2}></td>
                        </tr>
                        <tr>
                            <td><div style="margin: 0 0 0 30px">이름</div></td>
                            <td><input type="text" name="name" value=${dto.name}></td>
                        </tr>
                        <tr>
                            <td><div style="margin: 0 0 0 30px">전화번호</div></td>
                            <td><input type="tel" name="tel" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" title="###-####-####" placeholder="예) 010-1234-5678" value=${dto.tel}></td>
                        </tr>
                        <tr>
                            <td><div style="margin: 0 0 0 30px">이메일</div></td>
                            <td><input name="email" value=${dto.email}></td>
                        </tr>
                        <tr>
                            <td><div style="margin: 0 0 0 30px">주소</div></td>
                            <td><input name="address1" id="address1" value=${dto.addr1}></td>
                            <td><button type="button" onclick="showPostcode()">주소 찾기</button></td>
                        </tr>
                        <tr>
                            <td><div style="margin: 0 0 0 30px">상세주소</div></td>
                            <td><input name="address2" id="address2" value=${dto.addr2}></td>
                        </tr>
                        <tr>
                            <td style="color: #ddd;">ㅇㅇ</td>
                            <td style="color: #ddd;">ㅇㅇ</td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div style="display: flex; justify-content: center; margin-top: 20px;">
            <button onclick="update()" style="margin-right: 15px; font-size: 14px;">등록하기</button>
            <button type="button" onclick="cancelEdit()" style="font-size: 14px;">취소</button>
        </div>
        <br><br><br>
    </div>
</body>
</html>
