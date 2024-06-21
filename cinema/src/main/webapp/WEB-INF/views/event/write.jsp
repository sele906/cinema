<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<meta charset="UTF-8">
<script>
$(function(){
$("#btnSave").click(function(){
let subjet=$("#subject").val();
let contents=$("#contents").val();
if(subjet==""){
alert("제목을입력하세요.");
$("#subjet").focus();
return;
}
if(contents==""){
alert("내용을입력하세요.");
$("#contents").focus();
return;
}
/* let filename1=document.form1.file1.value;
let filename2=document.form1.file2.value;
let start1=filename1.lastIndexOf(".")+1;
let start2=filename2.lastIndexOf(".")+1;
if(start1!=-1){
let ext=filename1.substring(start,filename1.length);
if(ext=="jsp"||ext=="exe"){
alert("업로드할수없는파일입니다.");
return;
}
}
if(start2!=-1){
	let ext=filename1.substring(start,filename2.length);
	if(ext=="jsp"||ext=="exe"){
	alert("업로드할수없는파일입니다.");
	return;
	}
	} */
document.form1.submit();
});
});
</script>
<title>Insert title here</title>
</head>
<body>
	<h2>이벤트 작성</h2>
	<form name="form1" method="post" action="/cinema/event_servlet/insert.do" enctype="multipart/form-data">
		<table border="1" width="700px">
			<tr>
				<td align="center">제목</td>
				<td><input name="subject" id="subject" size="60"></td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td><select id="type" name="type">
						<option value="영화">영화</option>
						<option value="할인">할인</option>
						<option value="굿즈">굿즈</option>
				</select></td>
			</tr>
			<tr>
				<td align="center">본문</td>
				<td><textarea rows="5" cols="60" name="contents" id="contents"></textarea>
				</td>
			</tr>
			<tr>
				<td align="center">대표이미지</td>
				<td><input type="file" name="file1"></td>
			</tr>
			<tr>
				<td align="center">상세 이미지</td>
				<td><input type="file" name="file2"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button" value="확인"
					id="btnSave"></td>
			</tr>
		</table>
	</form>





</body>
</html>