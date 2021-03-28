<footer class="ftco-footer ftco-section">
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
	</script>