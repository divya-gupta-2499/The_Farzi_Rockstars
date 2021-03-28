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
						<span class="mr-2"><a href="/departmental/">Home</a></span> <span>Add Category</span>
					</p>
					<h1 class="mb-0 bread">Add Category</h1>
				</div>
			</div>
		</div>
	</div>

	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-xl-7 ftco-animate">
					<form:form class="billing-form" method="POST"
						modelAttribute="category" action="/departmental/addCategory">
						<h3 class="mb-4 billing-heading">Add Category</h3>
						<div class="row align-items-end">

							<div class="col-md-6">
								<div class="form-group">
									<form:label path="categoryName">Category Name</form:label>
									<form:input name="categoryName" path="categoryName" type="text"
										required="true" class="form-control" placeholder="" maxlength="50" />
								</div>
							</div>


							<div class="col-md-6">
								<div class="form-group">
									<form:label path="description">Description</form:label>
									<form:input path="description" type="text" required="true"
										class="form-control" placeholder="" maxlength="1000" />
								</div>
							</div>

						</div>
						<button type="submit" class="btn btn-primary py-3 px-4">
							Submit</button>
					</form:form>
					<!-- END -->
				</div>
			</div>
		</div>
	</section>
	<%@include file='/WEB-INF/views/footer.jsp' %>
	<!-- .section -->

	<%--footer class="ftco-footer ftco-section">
		<div class="row">
			<div class="col-md-12 text-center">

				<p>
					<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
					Copyright &copy;
					<script>
						document.write(new Date().getFullYear());
					</script>
					All rights reserved | 
					<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
				</p>
			</div>
		</div>
	</footer>





	<script src="<c:url value='/resources/js/jquery.min.js' />"></script>
	<script
		src="<c:url value='/resources/js/jquery-migrate-3.0.1.min.js' />"></script>
	<script src="<c:url value='/resources/js/popper.min.js' />"></script>
	<script src="<c:url value='/resources/js/bootstrap.min.js' />"></script>
	<script src="<c:url value='/resources/js/jquery.easing.1.3.js' />"></script>
	<script src="<c:url value='/resources/js/jquery.waypoints.min.js' />"></script>
	<script src="<c:url value='/resources/js/jquery.stellar.min.js' />"></script>
	<script src="<c:url value='/resources/js/owl.carousel.min.js' />"></script>
	<script
		src="<c:url value='/resources/js/jquery.magnific-popup.min.js' />"></script>
	<script src="<c:url value='/resources/js/aos.js' />"></script>
	<script
		src="<c:url value='/resources/js/jquery.animateNumber.min.js' />"></script>
	<script src="<c:url value='/resources/js/bootstrap-datepicker.js' />"></script>
	<script src="<c:url value='/resources/js/scrollax.min.js' />"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<script src="<c:url value='/resources/js/google-map.js' />"></script>
	<script src="<c:url value='/resources/js/main.js' />"></script>

	<script>
		$(document).ready(function() {

			var quantitiy = 0;
			$('.quantity-right-plus').click(function(e) {

				// Stop acting like a button
				e.preventDefault();
				// Get the field name
				var quantity = parseInt($('#quantity').val());

				// If is not undefined

				$('#quantity').val(quantity + 1);

				// Increment

			});

			$('.quantity-left-minus').click(function(e) {
				// Stop acting like a button
				e.preventDefault();
				// Get the field name
				var quantity = parseInt($('#quantity').val());

				// If is not undefined

				// Increment
				if (quantity > 0) {
					$('#quantity').val(quantity - 1);
				}
			});

		});
	</script--%>

</body>
</html>