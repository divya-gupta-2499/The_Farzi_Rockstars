<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products</title>
</head>
<body>
	<h3>Products Page for Category: ${categoryName }</h3>
	<sec:authorize access="hasRole('ROLE_USER')">
	<h3>
		<a href="/departmental/cart"> Go to cart </a>
	</h3>
	</sec:authorize>
	<table cellpadding="2" cellspacing="2" border="1">
		<tr>
			<th>ProductId</th>
			<th>Name</th>
			<th>Price</th>
			<th>Add to Cart</th>
		</tr>
		<c:forEach var="product" items="${products }">
			<tr>
				<td>${product.productId }</td>
				<td>${product.productName }</td>
				<td>${product.price }</td>
				<sec:authorize access="hasRole('ROLE_USER')">
					<td align="center"><a
						href="${pageContext.request.contextPath }/cart/buy/${product.productId}">Add
							to Cart</a></td>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<td align="center"><a
						href="${pageContext.request.contextPath }/updateProd/${product.productId}">
							Update Product </a></td>
				</sec:authorize>

			</tr>
		</c:forEach>
	</table>
</body>
</html>