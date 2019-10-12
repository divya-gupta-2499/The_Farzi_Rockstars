
<nav
	class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light"
	id="ftco-navbar">
	<div class="container">
		<a class="navbar-brand" href="/departmental/">Tejumal Departmental
			Store</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#ftco-nav" aria-controls="ftco-nav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="oi oi-menu"></span> Menu
		</button>

		<div class="collapse navbar-collapse" id="ftco-nav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a href="/departmental/products"
					class="nav-link">Products</a></li>
				<sec:authorize access="!hasRole('ROLE_ADMIN')">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="dropdown04"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Contact
							Us</a>


						<div class="dropdown-menu" aria-labelledby="dropdown04">
							<sec:authorize
								access="hasRole('ROLE_VENDOR') or hasRole('ROLE_USER') or hasRole('ROLE_COURIER')">
								<a class="dropdown-item" href="/departmental/contactUs">Report
									an issue</a>
							</sec:authorize>
							<sec:authorize
								access="!hasRole('ROLE_ADMIN') and !hasRole('ROLE_VENDOR')">
								<a class="dropdown-item" href="/departmental/partner">Partner
									with us</a>
							</sec:authorize></li>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_COURIER')">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="dropdown04"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Orders</a>


						<div class="dropdown-menu" aria-labelledby="dropdown04">

							<a class="dropdown-item" href="/departmental/pendingOrders">Pending
								Orders</a> <a class="dropdown-item"
								href="/departmental/acceptedOrders">Accepted Orders</a> <a
								class="dropdown-item" href="/departmental/deliveredOrders">Delivered
								Orders</a></li>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_USER')">
					<li class="nav-item cta cta-colored"><a
						href="/departmental/cart" class="nav-link"><span
							class="icon-shopping_cart"></span>Cart</a></li>
				</sec:authorize>
				<sec:authorize
					access="hasRole('ROLE_USER') or hasRole('ROLE_VENDOR')">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="dropdown04"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">My
							Profile</a>
						<div class="dropdown-menu" aria-labelledby="dropdown04">
							<a class="dropdown-item" href="/departmental/update">Update
								Profile</a><%--a class="dropdown-item" href="/departmental/viewReplies">View
								Replies</a--%>
							<sec:authorize access="hasRole('ROLE_VENDOR')">
								<a class="dropdown-item" href="/departmental/sendProposal">Send
									a Proposal</a>
								<a class="dropdown-item" href="/departmental/acceptedProposals">
									Accepted Proposals</a>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_USER')">
								<a class="dropdown-item" href="/departmental/viewOrders">My
									Orders</a>
							</sec:authorize>
							<a class="dropdown-item" href="/departmental/changePassword">Change
								password</a>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_ADMIN')">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="dropdown04"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Settings</a>
						<div class="dropdown-menu" aria-labelledby="dropdown04">
							<a class="dropdown-item" href="/departmental/addVendor">Add a
								Vendor</a> <a class="dropdown-item"
								href="/departmental/addDeliveryPartner">Add Delivery Partner</a>
							<a class="dropdown-item" href="/departmental/addProd">Add
								Product</a> <a class="dropdown-item"
								href="/departmental/viewAllOrders">All Orders</a> <a
								class="dropdown-item" href="/departmental/viewAllProposals">Proposals</a>
							<a class="dropdown-item" href="/departmental/viewAllFeedbacks">Feedbacks</a>
							<a class="dropdown-item" href="/departmental/changePassword">Change
								password</a>
						</div></li>
				</sec:authorize>
				<c:if test="${pageContext.request.userPrincipal.name == null}">
					<li class="nav-item cta cta-colored"><a
						href="/departmental/login" class="nav-link"><i
							class="fa fa-sign-in"></i> Login</a></li>
				</c:if>
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

					<li class="nav-item cta cta-colored"><a
						href="javascript:formSubmit()" class="nav-link"><i
							class="fa fa-sign-out"></i> Logout</a></li>


				</sec:authorize>
		</div>
		</li>








		</ul>
	</div>
	</div>
</nav>

<c:if test="${not empty error}">
	<div class="container" style="max-width: 400px">
		<div style="text-align: center" class="alert alert-danger">${error}</div>
	</div>
</c:if>


<c:if test="${not empty msg}">
	<div class="container" style="max-width: 400px">
		<div style="text-align: center" class="alert alert-success">${msg}</div>
	</div>
</c:if>


