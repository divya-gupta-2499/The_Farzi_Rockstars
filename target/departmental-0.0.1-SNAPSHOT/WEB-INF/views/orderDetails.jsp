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
	<div class="hero-wrap hero-bread" style = "background-image: url(<c:url value='/resources/images/bg_1.jpg' />);">
		<div class="container">
			<div
				class="row no-gutters slider-text align-items-center justify-content-center">
				<div class="col-md-9 ftco-animate text-center">
					<p class="breadcrumbs">
						<span class="mr-2"><a href="/departmental/">Home</a></span> <span>Orders</span>
					</p>
					<h1 class="mb-0 bread">Order Details</h1>
				</div>
			</div>
		</div>
	</div>

	<section class="ftco-section ftco-cart">
		<div class="container">
			<div class="row">
				<div class="col-md-12 ftco-animate">
					<div class="cart-list">
						<table class="table">
							<thead class="thead-primary">
								<tr class="text-center">
									<th>&nbsp;</th>
									<th>Product name</th>
									<th>Price</th>
									<th>Quantity</th>
									<th>Total</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="total" value="0"></c:set>
								<c:forEach var="order" items="${orders }">
									<c:set var="total"
										value="${total + order.item.product.price * order.item.quantity }"></c:set>

									<tr class="text-center">

										<td class="image-prod"><div class="img"
												style="background-image:url(<c:url value='${order.item.product.productUrl }'/>;"></div></td>

										<td class="product-name">
											<h3>${order.item.product.productName }</h3>
										</td>

										<td class="price">${order.item.product.price }</td>

										<td class="quantity">
											${order.item.quantity }
											
										</td>

										<td class="total">${order.item.product.price * order.item.quantity}</td>
									</tr>
									</c:forEach>
									<!-- END TR-->
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<br>
			<div class="row justify-content-end">
				<div class="col-lg-12 mt-5 cart-wrap ftco-animate">
					<div class="cart-total mb-3">
						<h3>Billing Details</h3>
						<p class="d-flex">
							<span>Date</span> <span>${bill.date }</span>
						</p>
						<p class="d-flex">
							<span>Total</span> <span>Rs. ${total }</span>
						</p>
						<p class="d-flex">
							<span>Shipping Address</span> <span>${bill.shippingAddress }</span>
						</p>
						<p class="d-flex">
							<span>Courier Company</span> <span>${courier.courierCompanyName }</span>
						</p>
						<p class="d-flex">
							<span>Courier Email</span> <span>${courier.email }</span>
						</p>
						<hr>
						<p class="d-flex total-price">
							<span>Payment Method</span> <span>${bill.paymentMethod }</span>
						</p>
					</div>
					<sec:authorize access="hasRole('ROLE_USER')">
					<p>
						<a href="/departmental/viewOrders" class="btn btn-primary py-3 px-4">Return
							to all orders</a>
					</p>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
					<p>
						<a href="/departmental/viewAllOrders" class="btn btn-primary py-3 px-4">Return
							to all orders</a>
					</p>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_VENDOR')">
					<p>
						<a href="/departmental/deliveredOrders" class="btn btn-primary py-3 px-4">Return
							to orders</a>
					</p>
					</sec:authorize>
				</div>
			</div>
		</div>
	</section>
	
	<%@include file='/WEB-INF/views/footer.jsp' %>

</body>
</html>