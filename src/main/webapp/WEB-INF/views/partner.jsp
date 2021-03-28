<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<%@include file="/WEB-INF/views/header.jsp"%>
<body class="goto-here">
	<%@include file="/WEB-INF/views/navbar.jsp"%>
	<div class="hero-wrap hero-bread"
		style="background-image: url(<c:url value='/resources/images/bg_1.jpg' />);">
		<div class="container">
			<div
				class="row no-gutters slider-text align-items-center justify-content-center">
				<div class="col-md-9 ftco-animate text-center">
					<p class="breadcrumbs">
						<span class="mr-2"><a href="/departmental/">Home</a></span> <span>Vendor</span>
					</p>
					<h1 class="mb-0 bread">Vendor</h1>
				</div>
			</div>
		</div>
	</div>

	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-xl-7 ftco-animate">
					<form:form class="billing-form" name="Form1" method="POST"
						modelAttribute="vendorDetails" action="/departmental/partner">
						<h3 class="mb-4 billing-heading">Vendor</h3>
						<div class="row align-items-end">
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<div class="col-md-6">
									<div class="form-group">
										<form:label path="username">Username</form:label>
										<form:input name="username" path="username" type="text"
											required="true" class="form-control" placeholder="" maxlength="50"/>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<form:label path="password">Password</form:label>
										<form:input path="password" type="password" required="true"
											class="form-control" placeholder="" maxlength="100"/>
									</div>
								</div>
							</sec:authorize>
							<div class="col-md-6">
								<div class="form-group">
									<form:label path="name">Name</form:label>
									<form:input path="name" type="text"
										value="${vendorDetails.name }" required="true"
										class="form-control" placeholder="" maxlength="100"/>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<form:label path="companyName">Company Name</form:label>
									<form:input path="companyName" type="text"
										value="${vendorDetails.companyName }" required="true"
										class="form-control" placeholder="" maxlength="80"/>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<form:label path="email">Email</form:label>
									<form:input path="email" type="email"
										value="${vendorDetails.email }" required="true"
										class="form-control" placeholder="" maxlength="100"/>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<form:label path="contact">Contact</form:label>
									<form:input path="contact" type="number"
										value="${vendorDetails.contact }" required="true"
										class="form-control" placeholder="" />
								</div>
								</div>
								<sec:authorize
									access="!hasRole('ROLE_ADMIN') and !hasRole('ROLE_VENDOR')">
									<div class="col-md-6">
										<div class="form-group">
											<form:label path="proposal">Proposal</form:label>
											<form:textarea path="proposal" type="text" class="form-control"
												placeholder="" rows="7" cols="30" />
										</div>
									</div>
								</sec:authorize>
							</div>
							<button type="submit" class="btn btn-primary py-3 px-4">
								Submit</button>
					</form:form>
					<!-- END -->
				</div>
			</div>
		</div>
	</section>
	<!-- .section -->

	<%@include file='/WEB-INF/views/footer.jsp' %>

</body>
</html>