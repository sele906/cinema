<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="No-Cache" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="viewport" content="width=1024" />
<meta name="keywords"
	content="CGV, 시지브이, 영화관, 극장, 영화, 티켓, 박스오피스, 극장, Movie, Theater, Cinema, Cgv, cgv, 예매, 상영작" />
<meta name="description"
	content="영화 그 이상의 다양하고 즐거운 몰입의 경험을 만듭니다. 라이프스타일 플랫폼 CGV" />
<meta property="og:site_name" content="영화 그 이상의 감동. CGV" />
<meta id="ctl00_og_title" property="og:title"
	content="기프트샵 &lt; 기프트샵 | 영화 그 이상의 감동. CGV"></meta>
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../include/admin_menu.jsp"%>
	<form name="form1" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>상품분류</td>
				<td><select id="type" name="type">
						<option value="0" ${dto.type == '' ? 'selected' : ''}>분류</option>
						<option value="1" ${dto.type == '할인' ? 'selected' : ''}>할인</option>
						<option value="2" ${dto.type == '영화' ? 'selected' : ''}>영화</option>
						<option value="3" ${dto.type == '굿즈' ? 'selected' : ''}>굿즈</option>
				</select></td>
			</tr>
			<tr>
				<td>설명</td>
				<td><textarea rows="5" cols="60" name="subject">${dto.subject}</textarea></td>
			</tr>
			<tr>
				<td>상품이미지</td>
				<td><img src="/resources/images/store/${dto.filename1}" width="300px"
					height="300px"> <br> <input type="file" name="file1"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="hidden"
					name="num" value="${dto.num}"> <input
					type="button" value="수정" onclick="update_product()"> <input
					type="button" value="목록"
					onclick="location.href='/product/list.do'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>