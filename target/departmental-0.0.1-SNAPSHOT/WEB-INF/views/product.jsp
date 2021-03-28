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
						<span class="mr-2"><a href="/departmental/">Home</a></span> <span>Products</span>
					</p>
					<h1 class="mb-0 bread">Products</h1>
				</div>
			</div>
		</div>
	</div>
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-10 mb-5 text-center">
					<ul class="product-category">
						<li><a href="/departmental/products">All</a></li>
						<c:forEach var="category" items="${categories }">
							<li><a
								href="${pageContext.request.contextPath }/products/${category.categoryName}">${category.categoryName}</a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="row">
				<c:forEach var="product" items="${products }">
					<div class="col-md-6 col-lg-3 ftco-animate">
						<div class="product">
							<img class="img-fluid"
								src="<c:url value='${product.productUrl }' />"
								alt="Product Image"> <%--width="1000px" height="800px"--%>
								<div class="overlay"></div>

							<div class="text py-3 pb-4 px-3 text-center">
								<h3>
									${product.productName }
								</h3>
								<div class="d-flex">
									<div class="pricing">
										<p class="price">
											<span class="price-sale">Rs. ${product.price}</span>
										</p>
									</div>
								</div>
								<sec:authorize access="hasRole('ROLE_USER')">
									<div class="bottom-area d-flex px-3">
										<div class="m-auto d-flex">
											<%--a href="#"
												class="add-to-cart d-flex justify-content-center align-items-center text-center">
												<span><i class="ion-ios-menu"></i></span>
											</a--%> <a
												href="${pageContext.request.contextPath }/cart/buy/${product.productId}"
												class="buy-now d-flex justify-content-center align-items-center mx-1">
												<span><i class="ion-ios-cart"></i></span>
											</a> <%--a href="#"
												class="heart d-flex justify-content-center align-items-center ">
												<span><i class="ion-ios-heart"></i></span>
											</a--%>
										</div>
									</div>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_ADMIN')">
									<div class="bottom-area d-flex px-3">
										<div class="m-auto d-flex">
											<a
												href="${pageContext.request.contextPath }/deleteProd/${product.productId}"
												class="buy-now d-flex justify-content-center align-items-center mx-1">
												<span><i class="fa fa-trash"></i></span>
											</a>
										</div>
									</div>
								</sec:authorize>
								<sec:authorize access="hasRole('ROLE_VENDOR')">
									<div class="bottom-area d-flex px-3">
										<div class="m-auto d-flex">
											<a
												href="${pageContext.request.contextPath }/sendProposal/${product.productId}"
												class="buy-now d-flex justify-content-center align-items-center mx-1">
												<span><i class="fa fa-comment"></i></span>
											</a>
										</div>
									</div>
								</sec:authorize>
							</div>
						</div>
					</div>
				</c:forEach>

			</div>
		</div>

	</section>
	<%@include file='/WEB-INF/views/footer.jsp' %>

</body>
</html>