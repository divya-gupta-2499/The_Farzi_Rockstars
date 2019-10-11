<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orders</title>
</head>
<body>
	<c:forEach var="i" items="${noOfOrders }">
	
		<h2>Order No: ${i}</h2>
		<h2>
			<a href="/departmental/bill/${i }"> See your bill </a>
		</h2>
		<c:set var="flag" value="0"></c:set>
		<table cellpadding="2" cellspacing="2" border="1">
			<tr>

				<th>ProductId</th>
				<th>Name</th>
				<th>Price</th>
				<th>Quantity</th>

			</tr>
			<c:forEach var="order" items="${allOrders }">
				<c:if test="${order.orderId eq i}">
				<c:if test="${flag == '0'}">
					<h2> Status: ${order.status }</h2>
					<c:set var="flag" value="1"></c:set>
				</c:if>
					<tr>
						<td>${order.item.product.productId }</td>
						<td>${order.item.product.productName }</td>
						<td>${order.item.product.price }</td>
						<td>${order.item.quantity }</td>
						
					</tr>
				</c:if>
			</c:forEach>
		</table>
	</c:forEach>

</body>
</html>