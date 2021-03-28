package com.khushi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.khushi.dao.CartDAO;
import com.khushi.dao.OrderDAO;
import com.khushi.dao.ProductDAO;
import java.util.List;
import com.khushi.model.Item;

@Controller
public class CartController {

	@Autowired
	ProductDAO productdao;
	@Autowired
	CartDAO cartdao;
	@Autowired
	OrderDAO orderdao;

	@RequestMapping(value = "/cart/buy/{productId}", method = RequestMethod.GET)
	public String buy(@PathVariable("productId") int productId) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		cartdao.addToCart(productId, userDetail.getUsername());
		return "redirect:/products?msg=" + "Product Added to cart!";
		// return new ModelAndView("product", "categories", productdao.getCategory());
	}

	@RequestMapping(value = "/cart/remove/{productId}", method = RequestMethod.GET)
	public String remove(@PathVariable("productId") int productId) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		cartdao.removeFromCart(productId, userDetail.getUsername());
		return "redirect:/cart";
	}

	@RequestMapping(value = "/cart/update", method = RequestMethod.POST)
	public ModelAndView update(@RequestParam(value = "quantity", required = false) String[] quantity) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		List<Item> cart = cartdao.findAll(userDetail.getUsername());
		for (int i = 0; i < cart.size(); i++) {
			cart.get(i).setQuantity(Integer.parseInt(quantity[i]));
			cartdao.updateCart(userDetail.getUsername(), cart.get(i).getProduct().getProductId(),
					Integer.parseInt(quantity[i]));
		}
		return new ModelAndView("cart", "cart", cartdao.findAll(userDetail.getUsername()));
	}

	@RequestMapping(value = "/cart")
	public ModelAndView viewCart() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		List<Item> cart = cartdao.findAll(userDetail.getUsername());
		if(cart.isEmpty()) {
			ModelAndView model = new ModelAndView("product");
			model.addObject("categories", productdao.getCategory());
			model.addObject("products", productdao.findAllProducts());
			model.addObject("error", "No items in cart.");
			return model;
		}
		return new ModelAndView("cart", "cart", cartdao.findAll(userDetail.getUsername()));
	}
}