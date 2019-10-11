<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<style>
#feedback-box {
	width: 800px;
	padding: 20px;
	margin: 10px auto;
	background: #fff;
	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border: 1px solid #000;
}
</style>
<head>
<meta charset="UTF-8">
<title>Feedbacks</title>
</head>
<body>
	<h1>Feedback Page</h1>
	<c:forEach var="feedback" items="${feedbacks }">
	<div id="feedback-box">
		<h3>${feedback.subject }</h3>
		<p>${feedback.details }</p>
		<br />
		<p>Reply: ${feedback.reply }</p>
		<br />
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<a href="/departmental/replyFeedback/${feedback.feedbackId }">
				Reply </a>
		</sec:authorize>
	</div>
	</c:forEach>

</body>
</html>