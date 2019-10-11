<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Address</title>
</head>
<body>
<h2> Confirm Address </h2>
	<form:form method="POST" modelAttribute="bill"
		action="/departmental/addressConfirm">
		<table>
			<tr>
				<td><form:label path="houseNo">House No</form:label></td>
				<td><form:input value="${bill.houseNo }"
						path="houseNo" type="text" required="true" /><font color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="street">Street</form:label></td>
				<td><form:input path="street" value="${bill.street }"
						type="text" required="true" /><font color='red'></font></td>
			</tr>
			
			<tr>
				<td><form:label path="locality">Locality</form:label></td>
				<td><form:input path="locality" value="${locality.street }"
						type="text" required="true" /><font color='red'></font></td>
			</tr>

			<tr>
				<td colspan="2"><input type="submit"
					value="Proceed to Checkout" /></td>
			</tr>
		</table>
	</form:form>

	<p>${msg }</p>
</body>
</html>