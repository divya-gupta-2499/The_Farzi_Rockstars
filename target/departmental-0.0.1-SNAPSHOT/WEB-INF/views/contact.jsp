<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form:form method="POST" modelAttribute="contactUs"
		action="/departmental/contactUs">
		<table>
			<%--sec:authorize access="!hasRole('ROLE_USER')">
				<tr>
					<td><form:label path="contactInfo">Email</form:label></td>
					<td><form:input path="contactInfo" type="text" required="true" /><font
						color='red'></font></td>
				</tr>


			</sec:authorize--%>
			<tr>
				<td><form:label path="subject">Subject</form:label></td>
				<td><form:input path="subject" type="text" required="true" /><font
					color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="details">Details</form:label></td>
				<td><form:input path="details" type="text" required="true" /><font
					color='red'></font></td>
			</tr>

			<tr>
				<td colspan="2"><input type="submit" value="Submit" /></td>
			</tr>
		</table>
	</form:form>
	
	
</body>
</html>