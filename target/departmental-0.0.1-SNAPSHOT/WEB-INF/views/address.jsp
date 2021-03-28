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
						<span class="mr-2"><a href="/departmental/">Home</a></span> <span>Confirm Address</span>
					</p>
					<h1 class="mb-0 bread">Confirm Address</h1>
				</div>
			</div>
		</div>
	</div>

	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-xl-7 ftco-animate">
					<form:form class="billing-form" method="POST" modelAttribute="bill"
						action="/departmental/addressConfirm">
						<h3 class="mb-4 billing-heading">Confirm Address</h3>
						<div class="row align-items-end">

							<div class="col-md-6">
								<div class="form-group">
									<form:label path="houseNo">House No</form:label>
									<form:input path="houseNo" value="${bill.houseNo }" type="text"
										required="true" class="form-control" placeholder="" maxlength="50"/>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<form:label path="street">Street</form:label>
									<form:input path="street" value="${bill.street }" type="text"
										required="true" class="form-control" placeholder="" maxlength="50"/>
								</div>
							</div>

							<div class="col-md-6">
								<div class="form-group">
									<form:label path="locality">Locality</form:label>
									<form:input path="locality" value="${locality.street }"
										type="text" required="true" class="form-control"
										placeholder="" maxlength="50" />
								</div>
							</div>

						</div>
						<button type="submit" class="btn btn-primary py-3 px-4">
							Proceed to Checkout</button>
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