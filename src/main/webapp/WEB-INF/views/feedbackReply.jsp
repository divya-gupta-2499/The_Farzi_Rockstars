<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2> Feedback Id: ${feedbackId }</h2>
<form:form method="post" modelAttribute="feedback" action="/departmental/replyFeedback/${feedbackId }">
	<form:input type="hidden" path="feedbackId" name="feedbackId" value="${feedbackId }" />
	Reply: <form:input name="reply" path="reply" type="text" />
	<br/>
	<input type="submit" value="Reply" />
</form:form>
</body>
</html>