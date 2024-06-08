<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<meta charset="UTF-8">
<title>정보 수정</title>
<script>

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
</head>
<body>
    <h1>정보 수정</h1>
    <form id="form1" method="post" action="/mypage/update.do">
    <table border="1">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="userid" id="userid"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="passwd1" id="passwd1"></td>
			</tr>	
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" name="passwd2" id="passwd2"></td>
			</tr>			
			<tr>
				<td>이름</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="tel" name="tel"
					pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" title="###-####-####"
					placeholder="예) 010-1234-5678"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input name="email"></td>
			</tr>		
			<tr>
				<td>주소</td>
				<td><input name="address1" id="address1"></td>
				<td><button type="button" onclick="showPostcode()">주소
						찾기</button></td>

			</tr>
			<tr>
				<td>상세주소</td>
				<td><input name="address2" id="address2"></td>
			</tr>			
		</table>
    
        
        <button type="submit">저장</button>
    </form>
</body>
</html>
