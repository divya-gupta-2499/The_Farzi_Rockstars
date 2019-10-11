<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<sec:authorize access="hasRole('ROLE_ADMIN')">
<h2> Proposals by Vendors </h2>
</sec:authorize>

<sec:authorize access="hasRole('ROLE_VENDOR')">
<h2> Accepted Proposals </h2>
</sec:authorize>

<h1> ${msg }</h1>
<c:forEach var="proposal" items="${proposals }">
<sec:authorize access="hasRole('ROLE_ADMIN')">
<h3> Vendor: ${proposal.username }</h3>
</sec:authorize>
<h3> Product: ${proposal.productId }</h3>
<h3> Proposed Price: ${proposal.price }</h3>
<sec:authorize access="hasRole('ROLE_ADMIN')">
<h3><a href="/departmental/acceptProposal/${proposal.username }/${proposal.productId }"> Accept Proposal </a></h3>
</sec:authorize>
<hr>
</c:forEach>
</body>
</html>