package com.khushi.controller;

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

import com.khushi.dao.CourierDAO;
import com.khushi.dao.CustomerDAO;
import com.khushi.dao.OrderDAO;
import com.khushi.dao.UserDAO;
import com.khushi.dao.VendorDAO;
import com.khushi.model.Courier;
import com.khushi.model.Order;

@Controller
public class CourierController {

	@Autowired
	CustomerDAO customerdao;
	@Autowired
	CourierDAO courierdao;
	@Autowired
	OrderDAO orderdao;
	@Autowired
	VendorDAO vendordao;
	@Autowired
	UserDAO userdao;

	@RequestMapping(value = "/pendingOrders")
	public ModelAndView pendingOrders() {
		List<Order> pendingOrders = orderdao.getPendingOrders();
		ModelAndView model = new ModelAndView("pending");
		if(pendingOrders.isEmpty()) {
			model.addObject("error", "No pending orders.");
		}
		model.addObject("pendingOrders", pendingOrders);
		return model;
	}
	
	@RequestMapping(value = "/addDeliveryPartner", method = RequestMethod.GET)
	public ModelAndView addCourier() {
		return new ModelAndView("addCourier", "courier", new Courier());
	}
	
	@RequestMapping(value = "/addDeliveryPartner", method = RequestMethod.POST)
	public ModelAndView addCourier(@ModelAttribute("courier") Courier courier) {
		if(userdao.get(courier.getUsername()) != null) {
			return new ModelAndView("addCourier", "error", "UserID already exists"); 
		}
		userdao.saveOrUpdate(courier.getUsername(), courier.getPassword(), "ROLE_COURIER");
		courierdao.addCourier(courier);
		return new ModelAndView("home", "msg", "Delivery Partner Added.");
	}
	
	@RequestMapping(value = "/acceptedOrders")
	public ModelAndView acceptedOrders() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		List<Order> acceptedOrders = courierdao.getAcceptedOrders(userDetail.getUsername());
		ModelAndView model = new ModelAndView("accepted");
		model.addObject("acceptedOrders", acceptedOrders);
		return model;
	}
	
	@RequestMapping(value = "/deliveredOrders")
	public ModelAndView deliveredOrders() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		List<Order> deliveredOrders = courierdao.getDeliveredOrders(userDetail.getUsername());
		ModelAndView model = new ModelAndView("delivered");
		model.addObject("deliveredOrders", deliveredOrders);
		return model;
	}
	
	@RequestMapping(value = "/accepted/{orderId}")
	public String accepted(@PathVariable("orderId") int orderId) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		courierdao.acceptOrder(orderId, userDetail.getUsername());
		return "redirect:/pendingOrders";
	}
	
	@RequestMapping(value = "/delivered/{orderId}")
	public String delivered(@PathVariable("orderId") int orderId) {
		/*Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();*/
		courierdao.deliverOrder(orderId);
		return "redirect:/pendingOrders";
	}
	

}