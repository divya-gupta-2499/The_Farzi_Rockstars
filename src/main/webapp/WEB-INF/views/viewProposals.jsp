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
						<span class="mr-2"><a href="/departmental/">Home</a></span> <span>Proposal</span>
					</p>
					<h1 class="mb-0 bread">Proposals</h1>
				</div>
			</div>
		</div>
	</div>

	<section class="ftco-section ftco-degree-bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 ftco-animate">
					<div class="row">
						<c:forEach var="proposal" items="${proposals }">
							<div class="col-md-12 d-flex ftco-animate">
								<div class="blog-entry align-self-stretch d-md-flex">
									<a href="blog-single.html" class="block-20"
										style="background-image: url(<c:url value='/resources/images/order.png' />);">
									</a>
									<div class="text d-block pl-md-4">
									<sec:authorize access="hasRole('ROLE_ADMIN')">
										<div class="meta mb-3">
											<br>
											<div>Vendor: ${proposal.username }</div>
										</div>
									</sec:authorize>
										
										<h3 class="heading">Product Id - ${proposal.productId }</h3>
										<p>Proposed Price: ${proposal.price }</p>
										<sec:authorize access="hasRole('ROLE_ADMIN')">
												<p>
													<a href="/departmental/acceptProposal/${proposal.username }/${proposal.productId }"
														class="btn btn-primary py-2 px-3">Accept Proposal</a>
												</p>
										</sec:authorize>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<%@include file='/WEB-INF/views/footer.jsp' %>

</body>
</html>