<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function product_write() {
		let product_name = document.form1.product_name.value;
		let product_type = document.form1.product_type.value;
		let price = document.form1.price.value;
		let description = document.form1.description.value;
		if (product_name == "") {
			alert("상품명을입력하세요");
			document.form1.product_name.focus();
			return;
		}
		if (product_type == "" ||product_type == "0" ) {
			alert("상품분류를 입력해주세요")
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
		document.form1.action = "/product/insert_product.do";
		document.form1.submit();
	}
</script>
</head>
<body>
	<%@ include file="../include/admin_menu.jsp"%>
	<h2>상품등록</h2>
	<form name="form1" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>상품명</td>
				<td><input name="product_name"></td>
			</tr>
			<tr>
				<td>상품분류</td>
				<td><select id="product_type" name="product_type">
				        <option value="0">분류</option>
				        <option value="4">콤보</option>
						<option value="1">팝콘</option>
						<option value="2">음료</option>
						<option value="3">스낵</option>
						<option value="5">굿즈</option>
						</select>
						</td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="text" name="price"></td>
			</tr>
			<tr>
				<td>상품설명</td>
				<td><textarea rows="5" cols="60" name="description"></textarea></td>
			</tr>
			<tr>
				<td>상품이미지</td>
				<td><input type="file" name="file1"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="button" value="등록"
					onclick="product_write()"> <input type="button" value="목록"
					onclick="location.href='/product/list.do'"></td>
			</tr>
		</table>
	</form>
</body>
</html>