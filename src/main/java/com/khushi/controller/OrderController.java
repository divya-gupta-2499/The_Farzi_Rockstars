package com.khushi.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.khushi.dao.CartDAO;
import com.khushi.dao.CustomerDAO;
import com.khushi.dao.OrderDAO;
import com.khushi.model.Bill;
import com.khushi.model.Customer;
import com.khushi.model.Order;

@Controller
public class OrderController {

	@Autowired
	CartDAO cartdao;
	@Autowired
	OrderDAO orderdao;
	@Autowired
	CustomerDAO customerdao;

	@RequestMapping(value = "/placeOrder")
	public String orderSumm(Bill bill) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		String username = userDetail.getUsername();
		/*int orderId = */orderdao.addOrder(username);
		orderdao.addOrderInfo(orderdao.getOrderId(), username);
		String shippingAddress = bill.getHouseNo()+","+bill.getStreet()+","+bill.getLocality();
		orderdao.generateBill(orderdao.getOrderId(), shippingAddress);
		// return "/addressConfirm";
		// return new ModelAndView("orderSuccess");
		return "orderSuccess";
	}

	@RequestMapping(value = "/viewOrders")
	public ModelAndView allOrders() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		String username = userDetail.getUsername();
		List<Integer> allOrderIds = new ArrayList<Integer>();
		allOrderIds = orderdao.getAllOrders(username);
		List<Order> orders = orderdao.findAll(username);
		if(orders.isEmpty()) {
			return new ModelAndView("home", "msg", "No orders placed yet.");
		}
		ModelAndView model = new ModelAndView("viewOrder");
		model.addObject("noOfOrders", allOrderIds);
		model.addObject("allOrders", orders);
		return model;
	}
	
	@RequestMapping(value = "/viewAllOrders")
	public ModelAndView viewAllOrders() {
		List<Order> orders = orderdao.getAll();
		if(orders.isEmpty()) {
			return new ModelAndView("home", "msg", "No orders to display.");
		}
		ModelAndView model = new ModelAndView("viewAllOrders");
		model.addObject("totalOrders", /*Order.noOfOrders*/ orderdao.getOrderId());
		model.addObject("allOrders", orders);
		return model;
	}

	@RequestMapping(value = "/addressConfirm", method = RequestMethod.GET)
	public ModelAndView address() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		String username = userDetail.getUsername();
		if(cartdao.findAll(username).isEmpty()) {
			return new ModelAndView("home", "msg", "Cart is Empty! Please add products before checkout.");
		}
		Customer customer = customerdao.getCustomer(username);
		Bill bill = new Bill();
		bill.setHouseNo(customer.getHouseNo());
		bill.setStreet(customer.getStreet());
		bill.setLocality(customer.getLocality());
		ModelAndView model = new ModelAndView("address");
		model.addObject("bill", bill);
		return model;
	}
	
	@RequestMapping(value = "/addressConfirm", method = RequestMethod.POST)
	public String addressx(@ModelAttribute("bill") Bill bill) {
		return orderSumm(bill);
	}

	@RequestMapping(value = "/bill/{orderId}", method = RequestMethod.GET)
	public ModelAndView getBill(@PathVariable("orderId") int orderId) {
		String username = orderdao.getUsernameFromOrderId(orderId);
		List<Order> allOrders = orderdao.findOrdersForOrderId(orderId);
		// Customer customer = customerdao.getCustomer(username);
		Customer customer = customerdao.getCustomer(username);
		ModelAndView model = new ModelAndView("bill");
		model.addObject("customer", customer);
		model.addObject("bill", orderdao.getBill(orderId));
		model.addObject("orders", allOrders);
		return model;
	}

}