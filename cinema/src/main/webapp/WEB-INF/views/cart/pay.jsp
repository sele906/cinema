<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"
	type="text/javascript"></script>
	
<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<meta charset="UTF-8">
<title>결제 페이지</title>
</head>
<body>
	<%
	String product_code = request.getParameter("product_code");
	int price = Integer.parseInt(request.getParameter("price"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	String total = request.getParameter("total");
	String name=request.getParameter("name");
	%>
	<button onclick="requestPay()">결제하기</button>
	<table border="1">
		<tr>
			<td>구매 할 상품</td>
			<td><%=product_code%></td>
		</tr>
		<tr>
			<td>가격</td>
			<td><%=price%></td>
		</tr>
		<tr>
			<td>수량</td>
			<td><%=amount%></td>
		</tr>
		<tr>
			<td>총결제금액</td>
			<td><%=total%></td>
		</tr>
	</table>

	<!-- <script>
// JavaScript 코드
// 서블릿으로부터 전달받은 데이터를 이곳에 출력하여 JavaScript에서 사용할 수 있도록 합니다.
var product_name = "${product.product_name}";
var price = parseInt("${product.price}");
window.location.href = "../product_servlet/select.do?product_name=" + product_name + "&price=" + price; 
</script> -->
	<script>
		function requestPay() {
			IMP.init('imp42661322'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
			IMP.request_pay({
				pg : "kakaopay",
				pay_method : "card",
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : "쌍용시네마",
				amount :<%=price%>	*<%=amount%>,
				buyer_name :'<%=name%>'
			}, function(rsp) { // callback
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					alert(msg);
				 	savePayment(<%=price%> * <%=amount%>); // savePayment 함수 호출 --%>
				
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
					alert(msg);
				}
			});
			}
			
		 	function savePayment(amount) {
			    location.href = "../member_servlet/buy.do?amount=" + amount;
			}
		
	</script>
</body>
</html>