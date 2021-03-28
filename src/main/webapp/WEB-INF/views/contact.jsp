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
						<span class="mr-2"><a href="/departmental/">Home</a></span> <span>Contact Us</span>
					</p>
					<h1 class="mb-0 bread">Feedback</h1>
				</div>
			</div>
		</div>
	</div>

	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-xl-7 ftco-animate">
					<form:form class="p-5 bg-light" method="POST"
						modelAttribute="contactUs" action="/departmental/contactUs">
						<h3 class="mb-4 billing-heading">Contact Us</h3>
						<div class="row align-items-end">
						<div class="form-group">
							<label>Subject</label>
							<form:input path="subject" type="text" required="true"
								class="form-control" placeholder="" maxlength="500"/>
						</div>
						</div>
						<div class="row align-items-end">
						<div class="form-group">
							<label for="message">Details</label>
							<form:textarea cols="30" rows="7" path="details" type="text"
								class="form-control" placeholder="" maxlength="1000" />
						</div>
						</div>
						
						<button type="submit" class="btn btn-primary py-3 px-4">
								Send</button>
				
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