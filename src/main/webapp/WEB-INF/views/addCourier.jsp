<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Delivery Partner</title>
</head>
<body>
	<form:form method="POST" modelAttribute="courier"
		action="/departmental/addDeliveryPartner">
		<table>
			<tr>
				<td><form:label path="username">Username</form:label></td>
				<td><form:input path="username" type="text" required="true" /><font
					color='red'></font></td>
			</tr>
			
			<tr>
				<td><form:label path="password">Password</form:label></td>
				<td><form:input path="password" type="password" required="true" /><font
					color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="courierCompanyName">Courier Company Name</form:label></td>
				<td><form:input path="courierCompanyName" type="text"
						required="true" /><font color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="email">Email</form:label></td>
				<td><form:input path="email" type="email" required="true" /><font
					color='red'></font></td>
			</tr>



			<tr>
				<td colspan="2"><input type="submit"
					value="Add Delivery Partner" /></td>
			</tr>
		</table>
	</form:form>

	<p>${msg }</p>
</body>
</html>