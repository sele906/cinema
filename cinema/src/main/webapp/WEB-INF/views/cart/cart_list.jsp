<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
body {
	font-family: Arial, sans-serif;
}

@media ( max-width : 1600px) {
	body {
		margin: 0;
	}
}

.section1 {
	margin: 0 10%; /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	padding: 0px;
	width: auto;
}

.section2 {
	margin: 0 10%; /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	padding: 0px;
	width: auto;
}

.moviesection {
	background-color: #333;
	padding: 40px 330px 10px 330px; /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
}

.foot {
	margin: 0 10%;
}

.like-button {
	background: none;
	border: none;
	cursor: pointer;
	outline: none;
}

.like-button img {
	width: 30px;
	height: auto;
	transition: transform 0.3s ease;
}

.poster img {
	margin: 30px;
}

.titleword {
	padding-top: 20px;
	font-weight: bold;
	font-size: 24px;
}

.contents {
	margin: 0 330px; /* 왼쪽과 오른쪽 양쪽에 여백 추가 */
	padding: 0px;
	width: auto;
}

.container {
	max-width: 800px; /* 컨테이너의 최대 너비를 지정합니다. */
	margin: 0 auto; /* 가운데 정렬을 수행합니다. */
	padding: 0 20px; /* 양쪽에 20px의 여백을 추가합니다. */
}

.movie-item {
	display: inline-block;
}

.movie-item img {
	width: 150px; /* 이미지 너비를 150px로 설정합니다. */
	height: auto; /* 이미지 높이를 자동으로 설정합니다. */
	vertical-align: middle; /* 이미지를 수직으로 중앙 정렬합니다. */
}

.cart-container {
	display: flex; /* 플렉스 컨테이너로 설정하여 내부 아이템을 가로로 배치합니다. */
	align-items: center; /* 아이템을 수직으로 정렬합니다. */
}

.cart-text {
	font-size: 36px; /* 글꼴 크기를 36px로 설정합니다. */
	font-weight: bold; /* 글꼴을 굵게 설정합니다. */
	margin-left: 10px; /* 왼쪽 여백을 설정합니다. */
}

table {
	width: 100%; /* 테이블의 최대 너비를 부모 컨테이너의 너비에 맞춥니다. */
}
</style>
</head>
<body>

	<%@ include file="../menu/menu.jsp" %>

	<div class="container">
		<!-- 본문을 감싸는 컨테이너를 생성합니다. -->
		<a href="/store/list.do" style="text-decoration: none;"><h1 style="color: black;">스토어</h1></a>
		<hr style="border-top: 5px solid black;">
		<a href="/product/category.do?product_type=4"style="text-decoration: none;color: black;"> 콤보</a> <a
			href="/product/category.do?product_type=1"style="text-decoration: none;color: black;">팝콘</a> <a
			href="/product/category.do?product_type=2"style="text-decoration: none;color: black;">음료</a> <a
			href="/product/category.do?product_type=3"style="text-decoration: none;color: black;">스낵</a> <a
			href="/product/category.do?product_type=5"style="text-decoration: none;color: black;">굿즈</a> <a
			href="/cart/list.do" style="float: right; text-decoration: none;color: black;">장바구니</a>
		<hr style="border-top: 2px solid black;">
		<br> <br>
		<div class="cart-container">
			<img src="/resources/images/cart.jpg" style="width: 150px;">
			<!-- 이미지 크기를 150px로 설정 -->
			<span class="cart-text">장바구니</span>
			<!-- 장바구니 텍스트 -->
		</div>
		<hr style="border-top: 5px solid black;">
		<table>
			<tr style="background-color: #eee">
				<th>상품명</th>
				<th>판매금액</th>
				<th>수량</th>
				<th>구매금액</th>
				<th></th>
			</tr>
			<c:forEach var="row" items="${list}">
				<tr align="center">
					<td><img src="/resources/images/store/${row.filename}" width="100px"
						height="100px" style="vertical-align: middle;">
						${row.product_name}</td>
					<td><span id="price_${row.cart_id}"> <fmt:formatNumber
								value="${row.price}" pattern="#,###" />원
					</span></td>
					<td>
						<button onclick="decreaseAmount('${row.cart_id}')">-</button> <!-- 수량 -->
						<span id="amount_${row.cart_id}">${row.amount}</span> <!-- 수량 증가 버튼 -->
						<button onclick="increaseAmount('${row.cart_id}')">+</button>
					</td>
					<td><span id="totalPrice_${row.cart_id}"> <fmt:formatNumber
								value="${row.price * row.amount}" pattern="#,###" />원
					</span></td>
					<td><a
						href="/cart/delete.do?cart_id=${row.cart_id}"><img
							src="/resources/images/xbutton.jpg" width="50px" height="50px"></a></td>
				</tr>
			</c:forEach>
		</table>
		<br> <br> <br>
		<table border="1">
			<tr>
				<td align="center">총 결제금액</td>
				<td id="totalAmount" align="center"><fmt:formatNumber
						value="${sum}" pattern="#,###" />원</td>
			</tr>
		</table>

		<button onclick="requestPay()"
			style="padding: 15px 30px; background-color: gray; color: white; border: none; border-radius: 10px; font-size: 16px; cursor: pointer;">
			구매하기</button>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<script>
		function requestPay() {
			var totalAmountText = document.getElementById('totalAmount').textContent;
			var amount = parseInt(totalAmountText.replace(/[^\d]/g, ''), 10);
			IMP.init('imp42661322'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
			IMP.request_pay({
				pg : "kakaopay",
				pay_method : "card",
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : "쌍용시네마",
				amount : amount,
				buyer_name : '${sessionScope.name}'
			}, function(rsp) { // callback
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					alert(msg);

					savePayment(amount); // savePayment 함수 호출 --%>
					cartdelete();

				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
					alert(msg);
				}
			});
		}
		function cartdelete() {
			location.href = "/cart/delete_all.do"
		}

		function savePayment(amount) {
			location.href = "/member/buy.do?amount=" + amount;
		}

		function increaseAmount(cartId) {
			var amountElement = document.getElementById('amount_' + cartId);
			var amount = parseInt(amountElement.innerText);
			amount++;
			amountElement.innerText = amount;
			updateTotalPrice(cartId);
		}

		function decreaseAmount(cartId) {
			var amountElement = document.getElementById('amount_' + cartId);
			var amount = parseInt(amountElement.innerText);
			if (amount > 1) {
				amount--;
				amountElement.innerText = amount;
				updateTotalPrice(cartId);
			}
		}

		function updateTotalPrice(cartId) {
			var priceText = document.getElementById('price_' + cartId).innerText;
			var price = parseInt(priceText.replace(/[^\d]/g, ''), 10);
			var amount = parseInt(document.getElementById('amount_' + cartId).innerText);
			var totalPrice = price * amount;
			document.getElementById('totalPrice_' + cartId).innerText = totalPrice
					.toLocaleString()
					+ '원';
			updateTotalAmount();
		}
		function updateTotalAmount() {
			var totalAmount = 0;
			var totalPriceElements = document
					.querySelectorAll('[id^="totalPrice_"]');
			totalPriceElements.forEach(function(element) {
				totalAmount += parseInt(
						element.innerText.replace(/[^\d]/g, ''), 10);
			});
			document.getElementById('totalAmount').innerText = totalAmount
					.toLocaleString()
					+ '원';
		}
	</script>
</body>
</html>
