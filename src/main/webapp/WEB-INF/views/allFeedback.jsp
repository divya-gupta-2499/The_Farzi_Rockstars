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
    <div class="hero-wrap hero-bread" style="background-image: url(<c:url value='/resources/images/bg_1.jpg' />);">
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
            <p class="breadcrumbs"><span class="mr-2"><a href="/departmental/">Home</a></span> <span>Feedback</span></p>
            <h1 class="mb-0 bread">All Feedbacks</h1>
          </div>
        </div>
      </div>
    </div>

                <div class="pt-5 mt-5">
              <ul class="comment-list">
                <c:forEach var="feedback" items="${feedbacks }">
                <li class="comment">
                  <div class="comment-body">
                    <h3>${feedback.subject }</h3>
                    <div class="meta">${feedback.contactInfo}</div>
                    <p>${feedback.details}</p>
                  </div>
                </li>
              </c:forEach>
              </ul>
            </div>

    <%@include file='/WEB-INF/views/footer.jsp' %>
    
  </body>
</html>	