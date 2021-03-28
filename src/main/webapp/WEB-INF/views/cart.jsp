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
            <p class="breadcrumbs"><span class="mr-2"><a href="/departmental/">Home</a></span> <span>Cart</span></p>
            <h1 class="mb-0 bread">My Cart</h1>
          </div>
        </div>
      </div>
    </div>

  <section class="ftco-section ftco-cart">
    <div class="container">
      <div class="row">
        <div class="col-md-12 ftco-animate">
          <div class="cart-list">
            <form method="post" action="/departmental/cart/update">
              <table class="table">
                <thead class="thead-primary">
                  <tr class="text-center">
                    <th>&nbsp;</th>
                    <th>&nbsp;</th>
                    <th>Product name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                  </tr>
                </thead>
                <tbody>
                  <c:set var="total" value="0"></c:set>
                  <c:forEach var="item" items="${cart}">
                    <c:set var="total"
                      value="${total + item.product.price * item.quantity }"></c:set>
                    <tr class="text-center">
                      <td class="product-remove"><a
                        href="${pageContext.request.contextPath }/cart/remove/${item.product.productId}"><span
                          class="ion-ios-close"></span></a></td>

                      <td class="image-prod"><div class="img"
                          style="background-image:url(<c:url value='${item.product.productUrl }' />);"></div></td>

                      <td class="product-name">
                        <h3>${item.product.productName }</h3>
                        <p>Far far away, behind the word mountains, far from the
                          countries</p>
                      </td>

                      <td class="price">Rs. ${item.product.price   }</td>

                      <td class="quantity">
                        <div class="input-group mb-3">
                          <input type="number" name="quantity"
                            class="quantity form-control input-number"
                            value="${item.quantity }" min="1">
                        </div>
                      </td>

                      <td class="total">${item.product.price * item.quantity }</td>
                    </tr>
                    <!-- END TR-->
                  </c:forEach>
                </tbody>
              </table>
              <center>
                <button class="btn btn-primary py-3 px-4" type="submit">Update
                  Quantity</button>
              </center>
              <br>
              <input type="hidden" name="${_csrf.parameterName}"
                value="${_csrf.token}" />   
            </form>
          </div>
        </div>
      </div>
      <br>
      <div class="row justify-content-end">
        <div class="col-lg-12 mt-5 cart-wrap ftco-animate">
          <div class="cart-total mb-3">
            <h3>Cart Totals</h3>
            <p class="d-flex">
              <span>Subtotal</span> <span>Rs. ${total }</span>
            </p>
            <p class="d-flex">
              <span>Delivery</span> <span>Rs. 0.00</span>
            </p>
            <hr>
            <p class="d-flex total-price">
              <span>Total</span> <span>Rs. ${total }</span>
            </p>
          </div>
          <p>
            <a href="${pageContext.request.contextPath }/addressConfirm" class="btn btn-primary py-3 px-4">Proceed
              to Checkout</a>
          </p>
        </div>
      </div>
    </div>
  </section>


    <%@include file='/WEB-INF/views/footer.jsp' %>
    
  </body>
</html>