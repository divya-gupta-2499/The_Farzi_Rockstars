package com.khushi.controller;

import java.util.HashSet;
import java.util.Set;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.khushi.dao.CourierDAO;
import com.khushi.dao.CustomerDAO;
import com.khushi.dao.OrderDAO;
import com.khushi.dao.UserDAO;
import com.khushi.dao.VendorDAO;
import com.khushi.model.Customer;
import com.khushi.model.User;

@Controller
public class LoginController {

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
	@Autowired
	private JavaMailSender mailSender;
	
	Set<String> activationCodes = new HashSet<String>();

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public ModelAndView register() {
		ModelAndView model = new ModelAndView("registerForm");
		model.addObject("customer", new Customer());
		return model;
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public ModelAndView registers(@ModelAttribute("customer") Customer customer) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		// Updating Profile.
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			customer.setUsername(userDetail.getUsername());
			customerdao.updateCustomer(customer);
			return new ModelAndView("home", "msg", "Profile Updated.");
		}

		// Registering new profile.
		else {
			if (userdao.get(customer.getUsername()) != null) {
				return new ModelAndView("registerForm", "error", "UserID already exists.");
			}
			String activationCode = RandomStringUtils.randomAlphanumeric(15);
			while(activationCodes.contains(activationCode)) {
				activationCode = RandomStringUtils.randomAlphanumeric(15);
			}
			userdao.saveOrUpdate(customer.getUsername(), customer.getPassword(), "ROLE_USER");
			customerdao.addCustomer(customer);
			activationCodes.add(activationCode);
			userdao.addActivationCode(customer.getUsername(), activationCode);
			SimpleMailMessage email = new SimpleMailMessage();
			email.setTo(customer.getEmail());
			email.setSubject("Activation link.");
			String emailText = "";
			emailText += "Here is your activation link\n";
			emailText += "http://localhost:8080/departmental/activation?code=" + activationCode;
			email.setText(emailText);	
			mailSender.send(email);
			return new ModelAndView("home", "msg", "Customer Succesfully Registered. Please verify your account.");
		}
	}
	
	@RequestMapping(value="/activation", method=RequestMethod.GET) 
	public ModelAndView activate(@RequestParam(value= "code", required= true) String activationCode) {
		userdao.activateUser(activationCode);
		activationCodes.remove(activationCode);
		return new ModelAndView("home", "msg", "User Verified. Please log in to continue.");
	}

	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView registersx() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		String role = userdao.get(userDetail.getUsername()).getRole();
		if (role.equalsIgnoreCase("ROLE_USER")) {
			ModelAndView model = new ModelAndView("registerForm");
			model.addObject("customer", customerdao.getCustomer(userDetail.getUsername()));
			return model;
		} else {
			ModelAndView model = new ModelAndView("partner");
			model.addObject("vendorDetails", vendordao.getVendor(userDetail.getUsername()));
			return model;
		}

	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			return new ModelAndView("redirect:/");
		}
		ModelAndView model = new ModelAndView();
		if (error != null) {
			model.addObject("error", "Invalid username and password or User not Verified!");
		}

		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		}
		model.setViewName("login");
		return model;
	}
	
	@RequestMapping(value = "/forgotPassword", method = RequestMethod.GET)
	public ModelAndView fPass() {
		ModelAndView model = new ModelAndView("forgotPassword");
		model.addObject("customer", new User());
		return model;
	}
	
	@RequestMapping(value = "/forgotPassword", method = RequestMethod.POST)
	public ModelAndView fPass1(@ModelAttribute("customer") User user) {
		String randomPassword = RandomStringUtils.randomAlphanumeric(10);
		if(customerdao.getCustomer(user.getUsername()) == null) {
			return new ModelAndView("forgotPassword", "msg", "Incorrect username.");
		
		}
		SimpleMailMessage email = new SimpleMailMessage();
		email.setTo(customerdao.getCustomer(user.getUsername()).getEmail());
		email.setSubject("Temporary password");
		String emailText = "";
		emailText += "Username: " + user.getUsername() + "\n";
		emailText += "Temporary Password: " + randomPassword + "\n";
		emailText += "Please login with this password for now. You can change your password later on.\n";
		email.setText(emailText);
		mailSender.send(email);
		userdao.updatePassword(user.getUsername(), randomPassword);
		return new ModelAndView("home", "msg", "Password Mail Sent. Please login to continue");
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(@RequestParam("username") String username) {
		String role = userdao.get(username).getRole();
		if(role.equalsIgnoreCase("ROLE_COURIER")) {
			ModelAndView model = new ModelAndView("courierHome");
			return model;
		}
		return new ModelAndView("home");
	}

	@RequestMapping(value = "/changePassword", method = RequestMethod.GET)
	public ModelAndView pass1() {
		ModelAndView model = new ModelAndView("changePassword");
		return model;
	}

	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public ModelAndView pass2(@RequestParam("username") String username, @RequestParam("oldPass") String oldPass,
			@RequestParam("newPass") String newPass, @RequestParam("confirmNewPass") String confirmNewPass) {
		if (userdao.checkPassword(username, oldPass) && newPass != null && newPass != ""
				&& newPass.equals(confirmNewPass)) {
			userdao.updatePassword(username, newPass);
			return new ModelAndView("home", "msg", "Password Changed Successfully.");
		}
		return new ModelAndView("changePassword", "error", "Invalid information. Try again!");

	}

}