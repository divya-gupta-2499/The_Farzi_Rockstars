<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password</title>
</head>
<body>
<h2> Forgot Password </h2>
<p> ${msg } </p>
<form:form method="post" modelAttribute="customer" action="/departmental/forgotPassword">
	Enter your username: <form:input path="username" name="username" type="text" required="true" /> <br/>
	<p> A temporary password will be sent to your email. </p>
	<br/>
	<input type="submit" value="Submit" />
	<%--input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /--%>
</form:form>
</body>
</html>