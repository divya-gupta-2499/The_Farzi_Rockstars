<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Product</title>
</head>
<body>
	<form:form method="POST" modelAttribute="product"
		action="/departmental/updateProd/${product.productId }">
		<table>
			<tr>
				<td><form:label path="productId">Product Id</form:label></td>
				<td><form:input path="productId" type="text" required="true"
						value="${product.productId }" readOnly="readOnly" /><font
					color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="productName">Product Name</form:label></td>
				<td><form:input path="productName" type="text" required="true"
						value="${product.productName }" /><font color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="price">Price</form:label></td>
				<td><form:input path="price" type="number" required="true"
						value="${product.price }" /><font color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="quantity">Quantity</form:label></td>
				<td><form:input path="quantity" type="number" required="true"
						value="${product.quantity }" /><font color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="categoryName">Category Name</form:label></td>
				<td><form:input path="categoryName" type="text" required="true"
						value="${product.categoryName }" /><font color='red'></font></td>
			</tr>

			<tr>
				<td colspan="2"><input type="submit" value="Update Product" /></td>
			</tr>
		</table>
	</form:form>

	<p>${msg }</p>
</body>
</html>