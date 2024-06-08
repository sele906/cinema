<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>

<script>
	function back() { 
		let userid = document.getElementById("userid").value;
		let passwd1 = document.getElementById("passwd1").value;
		let passwd2 = document.getElementById("passwd2").value;
		let name = document.getElementsByName("name")[0].value;
		let tel = document.getElementsByName("tel")[0].value;
		let email = document.getElementsByName("email")[0].value;
		let birth = document.getElementsByName("birth")[0].value;
		let gender = document.getElementsByName("gender")[0].value;
		let address1 = document.getElementById("address1").value;
		let address2 = document.getElementById("address2").value;

		let resultMessage = document.getElementById("result").innerText;
		if (userid == "") {
			alert("아이디를 입력하세요");
			document.form1.userid.focus();
			return;
		}
		if (userid.length<4 || userid.length>12) {
			alert("아이디는 4자에서 12자 사이여야 합니다");
			document.form1.userid.focus();
			return;
		}
		if(resultMessage =="중복된 아이디입니다."){
			alert("중복된 아이디입니다.");
			document.getElementById("userid").focus();
			return;
		}
		 if (passwd1 == "") {
			alert("비밀번호를 입력하세요");
			document.form1.passwd1.focus();
			return;
		}
		if (passwd2 == "") {
			alert("비밀번호를 확인해주세요");
			document.form1.passwd2.focus();
			return;
		}
		if (name == "") {
			alert("이름을 입력하세요");
			document.form1.name.focus();
			return;
		}
		if (tel == "") {
			alert("전화번호를 입력하세요");
			document.form1.tel.focus();
			return;
		}
		if(tel.indexOf("-")==-1){
			alert("하이픈을 넣어주세요");
			document.form1.tel.focus();
			return;
		}
		if(email.indexOf("@")==-1){
			alert("@를 붙여주세요");
			document.form1.email.focus();
			return;
		}
		if (birth == "") {
			alert("생년월일을 입력해주세요");
			document.form1.birth.focus();
			return;
		}
		if (birth.length != 6) {
			alert("생년월일은 6개의 숫자로 입력해주세요");
			document.form1.birth.focus();
			return;
		}
		if (gender == "") {
			alert("성별을 선택해주세요.");
			document.form1.gender.focus();
			return;
		}
		if(address1 ==""){
			alert("주소를 입력해주세요.");
			document.form1.address1.focus();
			return;
		}
		if(address2==""){
			alert("상세주소를 입력해주세요.");
			document.form1.address2.focus();
			return;
		}

			alert("회원가입이 완료되었습니다.");
			document.getElementById("form1").action="/member/insert.do";
	        document.getElementById("form1").submit();
	}

	function check() {

		let userid = document.getElementById("userid").value;
		$.ajax({
			url : "/member/check.do",
			type : "POST",
			data : {
				userid : userid
			},
			success : function(txt) {
				$("#result").html(txt);
				if$("#userid").prop('readonly', true); 
			}

		});
	}
	function checkpwd() {
		let password1 = document.getElementById("passwd1").value;
		let password2 = document.getElementById("passwd2").value;
		let passwordresult = document.getElementById("passwordresult");
		if (password1 != password2) {
			passwordresult.innerHTML = "비밀번호가 일치하지 않습니다";
		} else {
			passwordresult.innerHTML = "비밀번호가 일치합니다.";
		}
	}

	function showPostcode() {
		new daum.Postcode(
				{
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
								extraAddr += (extraAddr !== "" ? ", "
										+ data.buildingName : data.buildingName);
							}
							fullAddr += (extraAddr !== "" ? "(" + extraAddr
									+ ")" : "");
						}
						document.getElementById("address1").value = fullAddr;
						document.getElementById("address2").focus();
					}
				}).open();
	}
</script>
<style>
.main-menu a:hover {
	color: #ffcc00;
}
.container a:hover{
   color:red;
}


   body {
	margin: 0; /* body의 기본 여백을 제거합니다. */
}
    form {
        max-width: 700px;
        margin: 20px auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
       /*  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); */
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    table td {
        padding: 10px;
        border-bottom: 1px solid #ddd;
    }
    table td:first-child {
        width: 150px;
        font-weight: bold;
    }
    input[type="text"],
    input[type="password"],
    input[type="tel"],
    input[type="email"],
    input[type="date"] {
        width: calc(100% - 10px);
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }
    input[type="button"] {
        width: 100%;
        padding: 10px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    input[type="button"]:hover {
        background-color: #0056b3;
    }
    
    button {
    /* 주소 찾기 버튼에 대한 스타일 */
    width: 200px;
    font-weight: bold;
    font-size: 15px;
    background-color: #007bff; /* 원하는 색상으로 변경 */
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }

  button:hover {
    background-color: #0056b3; /* hover 상태일 때의 색상 변경 */
  }
    
    input[type="radio"] {
        margin-right: 10px;
    }
    #address1 {
        width: calc(100% - 80px);
    }
    #address2 {
        width: calc(100% - 30px);
    }
    a {
	display: inline-block; /* 링크를 인라인 블록 요소로 만듭니다. */
	margin-right: 20px; /* 링크 사이의 간격을 설정합니다. */
	font-size: 20px; /* 링크의 글꼴 크기를 설정합니다. */
	color: gray; /* 링크의 글꼴 색상을 회색으로 설정합니다. */
	text-decoration: none; /* 밑줄 제거 */
}
</style>
</head>
<body>
<%@include file="../menu/menu.jsp"%>

	<img src="/resources/images/adver/welcome.png" style="width: 808px; height: 448px; margin: 0 510px">
	<form name="form1" id="form1" method="post">

	
		<p style="font-size: 18px; font-weight:bold; margin: 0;">회원 정보 입력</p>
		<hr style="border: 1px solid #444; margin: 5px 0 20px 0;">
			
			<div style="display: flex; align-items: center; margin-left: 20px; ">
				<p style="width:200px; font-size: 16px; font-weight: bold; color: #777;">아이디</p><input type="text" name="userid" id="userid"; style="width: 500px; margin: 2px 50px 0 0;">
				
				<input type="button" value="중복확인" onclick="check()"; style="width: 200px; font-weight: bold; font-size: 15px;">
				</div>
				<div id="result" style= "margin:0 0 0 156px;"></div>
				<hr style="border: 1px solid #bbb; margin: 20px 0 25px 0;">
			
			
			<div style="display: flex; align-items: center; margin-left: 20px; ">
				<p style="width:200px; font-size: 16px; font-weight: bold; color: #777;">비밀번호</p><input type="password" name="passwd1" id="passwd1"; style="width: 500px; margin: 2px 50px 0 0;">
				<p style="width: 200px; font-weight: bold; font-size: 15px;"></p>
				</div>
				<div style="display: flex; align-items: center; margin-left: 20px; ">
				<p style="width:200px; font-size: 16px; font-weight: bold; color: #777;">비밀번호 확인</p><input type="password" name="passwd2" id="passwd2"
					oninput="checkpwd()"; style="width: 500px; margin: 2px 50px 0 0;">
					<p style="width: 200px; font-weight: bold; font-size: 15px;"></p>
				
				</div>
				<div id="passwordresult" style= "margin:0 0 0 156px;"></div>
				<hr style="border: 1px solid #bbb; margin: 20px 0 25px 0;">
			
				<div style="display: flex; align-items: center; margin-left: 20px; ">
				<p style="width:200px; font-size: 16px; font-weight: bold; color: #777;">이름</p><input type="text" name="name"; style="width: 500px; margin: 2px 50px 0 0;">
				<p style="width: 200px; font-weight: bold; font-size: 15px;"></p>
				</div>
			<hr style="border: 1px solid #bbb; margin: 20px 0 25px 0;">
		
				<div style="display: flex; align-items: center; margin-left: 20px; ">
				<p style="width:200px; font-size: 16px; font-weight: bold; color: #777;">전화번호</p><input type="tel" name="tel"
					pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" title="###-####-####"
					placeholder="예) 010-1234-5678"; style="width: 500px; margin: 2px 50px 0 0;">
				<p style="width: 200px; font-weight: bold; font-size: 15px;"></p>
				</div>
			<hr style="border: 1px solid #bbb; margin: 20px 0 25px 0;">
			
				<div style="display: flex; align-items: center; margin-left: 20px; ">
				<p style="width:200px; font-size: 16px; font-weight: bold; color: #777;">이메일</p><input name="email"; style="width: 500px; margin: 1px 50px 0 0;  border: 1px solid #999; border-radius: 3px; border-color: #ccc; height: 28px">
				<p style="width: 200px; font-weight: bold; font-size: 15px;"></p>
				</div>
			<hr style="border: 1px solid #bbb; margin: 20px 0 25px 0;">
		
			<div style="display: flex; align-items: center; margin-left: 20px; ">
				<p style="width:200px; font-size: 16px; font-weight: bold; color: #777;">생년월일</p><input name="birth" placeholder="예)980426"; style="width: 500px; margin: 1px 50px 0 0;  border: 1px solid #999; border-radius: 3px; border-color: #ccc; height: 28px">
				<p style="width: 200px; font-weight: bold; font-size: 15px;"></p>
				</div>
			<hr style="border: 1px solid #bbb; margin: 20px 0 25px 0;">
			
			<div style="display: flex; align-items: center; margin-left: 20px; ">
				<p style="width:3000px; font-size: 16px; font-weight: bold; color: #777;">성별</p><input type="radio" name="gender" value="남자"; style="width: 10px; margin: 2px 50px 0 0;">남
				<input type="radio" name="gender" value="여자"; style="width: 10px; margin: 2px 50px 0 80px;">여
				<p style="width: 5000px; font-weight: bold; font-size: 15px;"></p>
				</div>
			<hr style="border: 1px solid #bbb; margin: 20px 0 25px 0;">

			<div style="display: flex; align-items: center; margin-left: 20px; ">
				<p style="width:200px; font-size: 16px; font-weight: bold; color: #777;">주소</p><input name="address1" id="address1"; style="width: 500px; margin: 1px 50px 0 0;  border: 1px solid #999; border-radius: 3px; border-color: #ccc; height: 28px;">
				<button type="button" onclick="showPostcode()" style="width: 200px; font-weight: bold; font-size: 15px; height: 40px;">주소 찾기</button>
				</div>
				<div style="display: flex; align-items: center; margin-left: 20px; ">
				<p style="width:200px; font-size: 16px; font-weight: bold; color: #777;">상세주소</p><input name="address2" id="address2"; style="width: 500px; margin: 1px 50px 0 0;  border: 1px solid #999; border-radius: 3px; border-color: #ccc; height: 28px;">
				<p style="width: 200px; font-weight: bold; font-size: 15px;"></p>
				</div>
			<hr style="border: 1px solid #bbb; margin: 20px 0 25px 0;">

		
			
				<div><input type="button" value="회원가입" onclick="back()" style="width: 250px; margin-left: 230px; font-size: 16px; font-weight: bold;"></div>
			
	</form>
</body>
</html>
