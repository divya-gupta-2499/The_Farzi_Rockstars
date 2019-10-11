<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<style><%@include file="/WEB-INF/views/smallForm.css"%></style>
<head>
<%--spring:url value="/resources/css/smallForm.css" var="smallFormCss" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/smallForm.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script--%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form:form name="Form1" method="POST" modelAttribute="vendorDetails"
		action="/departmental/partner">
		<table>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<tr>
					<td><form:label path="username">Username</form:label></td>
					<td><form:input name="username" path="username" type="text"
							required="true" /><font color='red'></font></td>
				</tr>

				<tr>
					<td><form:label path="password">Password</form:label></td>
					<td><form:input path="password" type="password"
							required="true" /><font color='red'></font></td>
				</tr>
			</sec:authorize>
			<tr>
				<td><form:label path="name">Name</form:label></td>
				<td><form:input path="name" type="text" required="true"
						value="${vendorDetails.name }" /><font color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="companyName">Company Name</form:label></td>
				<td><form:input path="companyName" type="text" required="true"
						value="${vendorDetails.companyName }" /><font color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="email">Email</form:label></td>
				<td><form:input path="email" type="email" required="true"
						value="${vendorDetails.email }" /><font color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="contact">Contact</form:label></td>
				<td><form:input path="contact" type="number" required="true"
						value="${vendorDetails.contact }" /><font color='red'></font></td>
			</tr>
			<sec:authorize
				access="!hasRole('ROLE_ADMIN') and !hasRole('ROLE_VENDOR')">
				<tr>
					<td><form:label path="proposal">Proposal</form:label></td>
					<td><form:input path="proposal" type="text" required="true" /><font
						color='red'></font></td>
				</tr>
			</sec:authorize>
			<tr>
				<td colspan="2"><input type="submit" value="Submit" /></td>
			</tr>
		</table>
	</form:form>
</body>
</html>