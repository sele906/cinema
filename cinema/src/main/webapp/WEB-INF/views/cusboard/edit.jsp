<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.1.js"></script>


<script>
	function confirmDelete() {
		let num = document.form1.num.value;
		if (confirm("삭제하시겠습니까?")) {
			document.form1.action = "/board/delete.do";
			document.form1.submit();
		}
	}
	function update() {

		let num = document.form1.num.value;
		let subject = document.form1.subject.value;
		let contents = document.form1.contents.value;
		let type = document.form1.type.value;

		if (type == "0") {
			alert("타입을 설정해주세요.");
			return;
		}
		if (subject == "") {
			alert("제목을 입력하세요.");
			return;
		}

		let filename = document.form1.file1.value;
		let start = filename.lastIndexOf(".") + 1;
		if (start != -1) {
			let ext = filename.substring(start, filename.length);
			if (ext == "jsp" || ext == "exe") {
				alert("업로드할 수 없는 파일입니다.")
				return;
			}
		}

		document.form1.action = "/board/update.do"
		document.form1.submit();
	}
</script>
</head>
<body>

	<form name="form1" method="post" enctype="multipart/form-data">
		<table border="1" width="900px">
			<tr>
				<td><select name="type" id="type">
						<option value="0">분류</option>
						<option value="1">공지사항</option>
						<option value="2">자주 묻는 질문</option>
				</select> <script>
					document.getElementById("type").value = "${dto.type}";
				</script> <input type="text" id="subject" name="subject"
					placeholder="제목을 입력하세요" value="${dto.subject}"></td>

			</tr>

			<tr>
	<td>
    <textarea rows="10" cols="100" name="contents" id="contents" placeholder="내용을 입력하세요">${dto.contents}</textarea>
</td>
				
			</tr>
			<tr>
				<td align="center"><c:if test="${dto.filesize>0}">${dto.filename}(${dto.filesize} bytes)
<input type="checkbox" name="delete_file">첨부파일 삭제<br>
					</c:if> <input type="file" name="file1"></td>
			<tr>
				<td align="center"><input type="hidden" value="${dto.num}"
					name="num" id="num"> <input type="button" value="수정"
					onclick="update()"> <input type="button" value="삭제"
					onclick="confirmDelete()"></td>
			</tr>

		</table>

	</form>

</body>
</html>
