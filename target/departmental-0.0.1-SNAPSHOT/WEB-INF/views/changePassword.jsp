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
            <p class="breadcrumbs"><span class="mr-2"><a href="/departmental/">Home</a></span> <span>Password</span></p>
            <h1 class="mb-0 bread">Change Password</h1>
          </div>
        </div>
      </div>
    </div>

    <section class="ftco-section">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-xl-7 ftco-animate">
          <form class="billing-form"
			action="/departmental/changePassword" method='POST'>
              <h3 class="mb-4 billing-heading">Change Password</h3>
              <div class="row align-items-end">
                <div class="col-md-6">
                  <div class="form-group">
                    <label>User Name</label>
                    <input type="text" name="username" class="form-control" placeholder="" value="${pageContext.request.userPrincipal.name }"
						readonly="readonly">
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label>Current Password</label>
                    <input required="true" type="password" name="oldPass" class="form-control" placeholder="" maxlength="100">
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label>New Password</label>
                    <input required="true" type="password" name="newPass" class="form-control" placeholder="" maxlength="100">
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="form-group">
                    <label>Confirm New Password</label>
                    <input required="true" type="password" name="confirmNewPass" class="form-control" placeholder="" maxlength="100">
                  </div>
                </div>
              </div>
              <button type="submit" class="btn btn-primary py-3 px-4"> Change Password </button>
              <input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
            </form><!-- END -->
          </div>
        </div>
      </div>
    </section> <!-- .section -->

    <%@include file='/WEB-INF/views/footer.jsp' %>
    
  </body>
</html>