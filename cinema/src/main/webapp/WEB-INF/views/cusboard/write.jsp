<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<script>



function register(){
	
	let subject=document.form1.subject.value;
	let type=document.form1.type.value;
	let contents=document.form1.contents.value;
	
	
	
	
	if(subject==""){
		alert("제목을 입력하세요.");
		document.form1.subject.focus();
		return;
	}
	if(type=="0"){
		alert("타입을 설정해주세요.");
		document.form1.type.focus();
		return;
	}
	if(contents==""){
		alert("내용을 입력하세요.");
		document.form1.contents.focus();
		return;
	}
	let filename=document.form1.file1.value;
	let start=filename.lastIndexOf(".")+1;
	if(start!=-1){
		let ext=filename.substring(start, filename.length);
		if(ext == "jsp" || ext == "exe" ){
			alert("업로드할 수 없는 파일입니다.");
			return;
		}
	}
	document.form1.action="/board/insert.do";
	document.form1.submit();
	}
	
</script>
</head>
<body>
<%@ include file="../include/admin_menu.jsp"%>
<h2>게시글 작성</h2>
<form name="form1" method="post" enctype="multipart/form-data">
<table border="1" width="900px">
<tr>
<td>
<select name = "type" id="type" >
<option value= "0">분류</option>
<option value= "1">공지사항</option>
<option value= "2">자주 묻는 질문</option>
</select>
<input type="text" id="subject" name="subject" placeholder="제목을 입력하세요">
</td>
</tr>
<tr>
<td><textarea rows="10" cols="100" name="contents" id="contents" placeholder="내용을 입력하세요">
</textarea>
</td>
</tr>
<tr>
<td align="center"><input type="button" value="등록" onclick="register()">
<td align="center"><input type="file" name="file1" value="사진업로드">
</td>
</tr>

</table>

</form>
</body>
</html>