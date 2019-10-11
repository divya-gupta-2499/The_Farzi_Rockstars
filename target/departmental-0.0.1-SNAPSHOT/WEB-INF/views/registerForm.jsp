<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<style>
#login-box {
	width: 600px;
	padding: 20px;
	margin: 100px auto;
	background: #fff;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border: 1px solid #000;
}
input[type=text],input[type=number],input[type=email],input[type=password], select, textarea{
  width: 200%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  resize: vertical;
}

label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}

input[type=submit] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  float: right;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}

.col-25 {
  float: left;
  width: 25%;
  margin-top: 6px;
}

.col-75 {
  float: left;
  width: 75%;
  margin-top: 6px;
}

.row:after {
  content: "";
  display: table;
  clear: both;
}
</style>
<head>
<meta charset="UTF-8">
<title>Registration - Customer</title>
</head>
<body>
	<div id="login-box">
	<h3 align = "center"> Registration Form </h3>
	<form:form name="Form1" method="POST" modelAttribute="customer"
		action="/departmental/register">
		<table>
		<sec:authorize access="!hasRole('ROLE_USER') and !hasRole('ROLE_VENDOR')">
			<tr>
				<td><form:label path="username">Username</form:label></td>
				<td><form:input name="username" path="username" type="text"
						required="true" /><font color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="password">Password</form:label></td>
				<td><form:input path="password" type="password" required="true" /><font
					color='red'></font></td>
			</tr>
		</sec:authorize>
			<tr>
				<td><form:label path="fName">First Name</form:label></td>
				<td><form:input path="fName" type="text" required="true" value="${customer.fName }"/><font
					color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="lName">Last Name</form:label></td>
				<td><form:input path="lName" type="text" required="true" value="${customer.lName }"/><font
					color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="email">Email</form:label></td>
				<td><form:input path="email" type="email" required="true" value="${customer.email }"/><font
					color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="contact">Contact</form:label></td>
				<td><form:input path="contact" type="number" required="true" value="${customer.contact }"/><font
					color='red'></font></td>
			</tr>
			
			<tr>
				<td><form:label path="age">Age</form:label></td>
				<td><form:input path="age" type="number" required="true"
						min="1" max="100" value="${customer.age }"/><font color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="houseNo">House No</form:label></td>
				<td><form:input path="houseNo" type="text" required="true" value="${customer.houseNo }"/><font
					color='red'></font></td>
			</tr>

			<tr>
				<td><form:label path="street">Street</form:label></td>
				<td><form:input path="street" type="text" required="true" value="${customer.street }"/><font
					color='red'></font></td>
			</tr>
			
			<tr>
				<td><form:label path="locality">Locality</form:label></td>
				<td><form:input path="locality" type="text" required="true" value="${customer.locality }"/><font
					color='red'></font></td>
			</tr>

			<tr>
				<td colspan="2"><input type="submit" value="Submit" /></td>
			</tr>
		</table>
	</form:form>
	</div>

	<p>${msg }</p>
</body>
</html>