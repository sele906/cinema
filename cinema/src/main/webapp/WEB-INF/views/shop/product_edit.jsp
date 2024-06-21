<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function update_product() {
		let product_name = document.form1.product_name.value;
		let price = document.form1.price.value;
		let description = document.form1.description.value;
		let product_type = document.form1.product_type.value;
		if (product_name == "") {
			alert("상품명을입력하세요");
			document.form1.product_name.focus();
			return;
		}
		if (product_type == "0") {
			alert("상품분류를 선택하세요");
			document.form1.product_type.focus();
			return;
		}
		if (price == "") {
			alert("가격을입력하세요");
			document.form1.price.focus();
			return;
		}
		if (description == "") {
			alert("상품설명을입력하세요");
			document.form1.description.focus();
			return;
		}
		document.form1.action = "/product/update.do";
		document.form1.submit();
	}
</script>
</head>
<body>
	<%@ include file="../include/admin_menu.jsp"%>
	<form name="form1" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>상품명</td>
				<td><input name="product_name" value="${dto.product_name}"></td>
			</tr>
			<tr>
				<td>상품분류</td>
				<td><select id="product_type" name="product_type">
						<option value="0" ${dto.product_type == 0 ? 'selected' : ''}>분류</option>
						<option value="4" ${dto.product_type == 4 ? 'selected' : ''}>스낵</option>
						<option value="1" ${dto.product_type == 1 ? 'selected' : ''}>팝콘</option>
						<option value="2" ${dto.product_type == 2 ? 'selected' : ''}>음료</option>
						<option value="3" ${dto.product_type == 3 ? 'selected' : ''}>스낵</option>
						<option value="5" ${dto.product_type == 5 ? 'selected' : ''}>굿즈</option>
				</select></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="text" name="price" value="${dto.price}"></td>
			</tr>
			<tr>
				<td>상품설명</td>
				<td><textarea rows="5" cols="60" name="description">${dto.description}</textarea></td>
			</tr>
			<tr>
				<td>상품이미지</td>
				<td><img src="/resources/images/store/${dto.filename}" width="300px"
					height="300px"> <br> <input type ="file"name="file1"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="hidden"
					name="product_code" value="${dto.product_code}"> <input
					type="button" value="수정" onclick="update_product()"> <input
					type="button" value="목록"
					onclick="location.href='/product/list.do'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>