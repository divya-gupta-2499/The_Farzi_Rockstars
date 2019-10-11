package com.khushi.controller;

import java.util.List;

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

import com.khushi.dao.OrderDAO;
import com.khushi.dao.ProductDAO;
import com.khushi.dao.VendorDAO;
import com.khushi.model.VendorProposal;

@Controller
public class ProposalController {

	@Autowired
	ProductDAO productdao;
	@Autowired
	OrderDAO orderdao;
	@Autowired
	VendorDAO vendordao;

	@RequestMapping(value = "/sendProposal", method = RequestMethod.GET)
	public ModelAndView sendProposal1() {
		ModelAndView model = new ModelAndView("sendProposal");
		return model;
	}

	@RequestMapping(value = "/sendProposal", method = RequestMethod.POST)
	public ModelAndView sendProposal2(@RequestParam(value = "productId") String productId,
			@RequestParam("price") int price) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		if (vendordao.existsInProposal(userDetail.getUsername(), productId)) {
			return new ModelAndView("sendProposal", "msg", "Proposal for this product already sent.");
		} else if (productdao.get(productId) == null) {
			return new ModelAndView("sendProposal", "msg", "Product does not exist.");
		}
		vendordao.addProposal(userDetail.getUsername(), productId, price);
		return new ModelAndView("product", "msg", "Proposal added.");
	}

	@RequestMapping(value = "/viewAllProposals", method = RequestMethod.GET)
	public ModelAndView viewAll(@RequestParam(value = "msg", required = false) String msg) {
		ModelAndView model = new ModelAndView("viewProposals");
		if (msg != null) {
			model.addObject("msg", "Proposal Accepted");
		}
		model.addObject("proposals", vendordao.getAllProposals());
		return model;
	}

	@RequestMapping(value = "/acceptProposal/{username}/{productId}", method = RequestMethod.GET)
	public String accept(@PathVariable("username") String username, @PathVariable("productId") String productId) {
		vendordao.acceptProposal(username, productId);
		return "redirect:/viewAllProposals?msg";
	}

	@RequestMapping(value = "/acceptedProposals")
	public ModelAndView accepted() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		List<VendorProposal> proposals = vendordao.getAcceptedProposals(userDetail.getUsername());
		if (proposals.isEmpty()) {
			return new ModelAndView("home", "msg", "No accepted proposals to display.");
		}
		return new ModelAndView("viewProposals", "proposals", proposals);
	}

}