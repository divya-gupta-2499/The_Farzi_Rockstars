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
import org.springframework.web.bind.annotation.RequestParam;
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
	public ModelAndView orderSumm(Bill bill) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		String username = userDetail.getUsername();
		/* int orderId = */orderdao.addOrder(username);
		orderdao.addOrderInfo(orderdao.getOrderId(), username);
		String shippingAddress = bill.getHouseNo() + "," + bill.getStreet() + "," + bill.getLocality();
		orderdao.generateBill(orderdao.getOrderId(), shippingAddress);
		// return "/addressConfirm";
		// return new ModelAndView("orderSuccess");
		ModelAndView model = new ModelAndView("orderDetails");
		model.addObject("orders", orderdao.findOrdersForOrderId(orderdao.getOrderId()));
		model.addObject("bill", orderdao.getBill(orderdao.getOrderId()));
		return model;

	}

	@RequestMapping(value = "/viewOrders")
	public ModelAndView allOrders() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		String username = userDetail.getUsername();
		List<Integer> allOrderIds = new ArrayList<Integer>();
		allOrderIds = orderdao.getAllOrders(username);
		List<Order> orders = orderdao.findAll(username);
		if (orders.isEmpty()) {
			return new ModelAndView("home", "error", "No orders placed yet.");
		}
		ModelAndView model = new ModelAndView("viewOrder");
		model.addObject("orders", orderdao.findAll(username));
		return model;
	}

	@RequestMapping(value = "/viewAllOrders", method = RequestMethod.GET)
	public ModelAndView viewAllOrders(@RequestParam(value = "error", required = false) String error) {
		List<Order> orders = orderdao.getAll();
		if (orders.isEmpty()) {
			return new ModelAndView("home", "error", "No orders to display.");
		}
		ModelAndView model = new ModelAndView("viewAllOrders");
		if (error != null) {
			model.addObject("error", error);
		}
		model.addObject("allOrders", orders);
		return model;
	}

	@RequestMapping(value = "/addressConfirm", method = RequestMethod.GET)
	public ModelAndView address() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		String username = userDetail.getUsername();
		if (cartdao.findAll(username).isEmpty()) {
			return new ModelAndView("home", "error", "Cart is Empty! Please add products before checkout.");
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
	public ModelAndView addressx(@ModelAttribute("bill") Bill bill) {
		return orderSumm(bill);
	}

	@RequestMapping(value = "/orderDetails/{orderId}", method = RequestMethod.GET)
	public ModelAndView orderDetails(@PathVariable("orderId") int orderId) {
		// Customer customer = customerdao.getCustomer(username);
		if (orderdao.findOrdersForOrderId(orderId).isEmpty()) {
			return new ModelAndView("redirect:/viewAllOrders?error=" + "No such order exists");
		}
		ModelAndView model = new ModelAndView("orderDetails");
		model.addObject("orders", orderdao.findOrdersForOrderId(orderId));
		model.addObject("bill", orderdao.getBill(orderId));
		if (orderdao.getCourierInfo(orderId) != null) {
			model.addObject("courier", orderdao.getCourierInfo(orderId));
		}
		return model;
	}
	

}