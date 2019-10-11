<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Category</title>
</head>
<body>
	<form:form method="POST" modelAttribute="category"
		action="/departmental/addCategory">
		<table>
			<tr>
				<td><form:label path="categoryName">Category Name</form:label></td>
				<td><form:input path="categoryName" type="text" required="true" /><font
					color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="description">Description</form:label></td>
				<td><form:input path="description" type="text" required="true" /><font
					color='red'></font></td>
			</tr>

			<tr>
				<td colspan="2"><input type="submit" value="Add Category" /></td>
			</tr>
		</table>
	</form:form>
	
	<a href="/departmental/addProd"> Add Product </a>
	
	<p> ${msg } </p>
</body>
</html>