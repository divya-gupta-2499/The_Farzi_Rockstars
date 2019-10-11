<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>
</head>
<body>
	<h3>Cart Page</h3>
	<form method="post" action = "/departmental/cart/update">
	<table cellpadding="2" cellspacing="2" border="1">
		<tr>

			<th>Id</th>
			<th>Name</th>
			<th>Price</th>
			<th>Quantity <input type="submit" value="Update"></th>
			<th>Sub Total</th>
		</tr>
		<c:set var="total" value="0"></c:set>
		<c:forEach var="item" items="${cart}">
			<c:set var="total"
				value="${total + item.product.price * item.quantity }"></c:set>
			<tr>
				<td>${item.product.productId }</td>
				<td>${item.product.productName }</td>
				<td>${item.product.price }</td>
				<td>
					<input type="number" name="quantity" value="${item.quantity }" style="width: 60px"></td>
				<td>${item.product.price * item.quantity }</td>
				<td><a
					href="${pageContext.request.contextPath }/cart/remove/${item.product.productId}">Remove
						Item</a></td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="6" align="right">Sum</td>
			<td>${total }</td>
		</tr>
	</table>
	<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
	</form>
	<br>
	<a href="${pageContext.request.contextPath }/addressConfirm"> Proceed
		to Checkout </a> <br/>
	<a href="${pageContext.request.contextPath }/products">Continue
		Shopping</a>
</body>
</html>