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
	<h3>Products Page</h3>
	<h3><font color="red">${msg }</font></h3>
	
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<h3><a href="/departmental/addProd"> Add a Product </a></h3>

	</sec:authorize>

	<sec:authorize access="hasRole('ROLE_VENDOR')">
		<h3><a href="/departmental/sendProposal"> Send Proposal for a Product
		</a></h3>

	</sec:authorize>
	
	<sec:authorize access="hasRole('ROLE_USER')">
		<h3>
			<a href="/departmental/cart"> Go to cart </a>
		</h3>
	</sec:authorize>
	<c:forEach var="item" items="${categories }">
		<c:set var="flag" value="0"></c:set>
		<h4>
			<a
				href="${pageContext.request.contextPath }/products/${item.categoryName}">${item.categoryName }</a>
		</h4>
		<h4>${item.description }</h4>
		<table cellpadding="2" cellspacing="2" border="1">
			<c:forEach var="product" items="${products }">
				<c:if test="${product.categoryName eq item.categoryName }">
					<c:if test="${flag == '0'}">
						<tr>
							<th>ProductId</th>
							<th>Name</th>
							<th>Price</th>
						</tr>
						<c:set var="flag" value="1"></c:set>
					</c:if>
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
							<td align="center"><a
								href="${pageContext.request.contextPath }/deleteProd/${product.productId}">
									Delete Product </a></td>
						</sec:authorize>

					</tr>
				</c:if>
			</c:forEach>
		</table>
		<c:if test="${flag == '0'}">
			<h3>
				<font color="red"> Sorry, currently there are no products in
					this category. </font>
			</h3>
		</c:if>
	</c:forEach>

	

</body>
</html>