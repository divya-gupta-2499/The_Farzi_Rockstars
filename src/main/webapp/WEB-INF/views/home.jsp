<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<style>
ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
	background-color: #333;
}

li {
	float: left;
}

li a, .dropbtn {
	display: inline-block;
	color: white;
	text-align: center;
	padding: 14px 16px;
	text-decoration: none;
}

li a:hover, .dropdown:hover .dropbtn {
	background-color: #111;
}

li.dropdown {
	display: inline-block;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f9f9f9;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
	text-align: left;
}

.dropdown-content a:hover {
	background-color: #f1f1f1;
}

.dropdown:hover .dropdown-content {
	display: block;
}
</style>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>
	<h1 align="center">Tejumal Departmental Store</h1>
	<h3><font color="red">${msg }</font></h3>
	<ul>
		<c:if test="${pageContext.request.userPrincipal.name == null}">
			<li><a href="/departmental/register"> Register here </a></li>
			<li><a href="/departmental/login">Login Here!</a>
			<li>
		</c:if>

		<li><a href="/departmental/products">Products </a></li>

		<sec:authorize access="hasRole('ROLE_USER')">
			<li><a href="/departmental/cart"> View Cart </a></li>
		</sec:authorize>
		
		<sec:authorize access="hasRole('ROLE_VENDOR')">
			<li><a href="/departmental/acceptedProposals"> View Accepted Proposals </a></li>
		</sec:authorize>



		<sec:authorize
			access="!hasRole('ROLE_ADMIN') and !hasRole('ROLE_VENDOR')">
			<li><a href="/departmental/partner"> Partner with Us </a></li>
		</sec:authorize>

		<sec:authorize access="hasRole('ROLE_USER') or hasRole('ROLE_VENDOR')">
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn">Settings</a>
				<div class="dropdown-content">
					<a href="/departmental/update"> Update Profile </a> <a
						href="/departmental/contactUs">Contact Us</a> <a
						href="/departmental/viewReplies/"> View Replies </a> <a
						href="/departmental/changePassword"> Change password </a>
				</div></li>
		</sec:authorize>

		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<li class="dropdown"><a href="javascript:void(0)"
				class="dropbtn"> Settings </a>
				<div class="dropdown-content">
					<a href="/departmental/addVendor"> Add a Vendor </a>
					<a href="/departmental/addDeliveryPartner"> Add Delivery Partner </a> <a
						href="/departmental/addProd"> Add a Product </a> <a
						href="/departmental/viewAllOrders"> View All Orders </a>
						<a
						href="/departmental/viewAllProposals"> View All Proposals </a> <a
						href="/departmental/viewAllFeedbacks">Feedbacks</a> <a
						href="/departmental/changePassword"> Change password </a>
				</div></li>
		</sec:authorize>

		<sec:authorize
			access="hasRole('ROLE_ADMIN') or hasRole('ROLE_USER') or hasRole('ROLE_VENDOR') or hasRole('ROLE_COURIER')">
			<!-- For login user -->
			<c:url value="/j_spring_security_logout" var="logoutUrl" />
			<form action="${logoutUrl}" method="post" id="logoutForm">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</form>
			<script>
				function formSubmit() {
					document.getElementById("logoutForm").submit();
				}
			</script>

			<c:if test="${pageContext.request.userPrincipal.name != null}">
				<li><a href="javascript:formSubmit()"> Logout</a></li>
			</c:if>


		</sec:authorize>

	</ul>

	<sec:authorize access="hasRole('ROLE_COURIER')">
		<a href="/departmental/pendingOrders"> Pending Orders </a> <br/>
		<a href="/departmental/acceptedOrders"> Accepted Orders </a> <br/>
		<a href="/departmental/deliveredOrders"> Delivered Orders </a> <br/>
	</sec:authorize>
</body>
</html>