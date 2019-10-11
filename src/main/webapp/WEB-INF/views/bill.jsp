<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bill</title>
</head>
<body>
	<h3>Bill Page</h3>
	<%--form method="post" action = "/departmental/cart/update"--%>
	<h3>Order No: ${bill.orderId }</h3>
	<h3>Customer Name: ${customer.fName } ${customer.lName }</h3>
	<h3>Email: ${customer.email }</h3>
	<h3>Contact: ${customer.contact }</h3>
	<h3>Date: ${bill.date }</h3>

	<table cellpadding="2" cellspacing="2" border="1">
		<tr>

			<th>Id</th>
			<th>Name</th>
			<th>Price</th>
			<th>Quantity <%--input type="submit" name="Update"--%></th>
			<th>Sub Total</th>
		</tr>
		<c:set var="total" value="0"></c:set>
		<c:forEach var="order" items="${orders}">
			<c:set var="total"
				value="${total + order.item.product.price * order.item.quantity }"></c:set>
			<tr>
				<td>${order.item.product.productId }</td>
				<td>${order.item.product.productName }</td>
				<td>${order.item.product.price }</td>
				<td>${order.item.quantity }</td>
				<td>${order.item.product.price * order.item.quantity }</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="6" align="right">Sum</td>
			<td>${total }</td>
		</tr>
	</table>
	<%--form--%>

	<h3>Payment Info: ${bill.paymentMethod }</h3>
	<br/>
	<h3> Shipping Address: ${bill.shippingAddress } </h3>
	<br>
	<a href="${pageContext.request.contextPath }/viewOrders"> Go to
		Orders </a> <br/>
	<a href="${pageContext.request.contextPath }/">Go to Home</a>
</body>
</html>