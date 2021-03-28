package com.khushi.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.khushi.dao.UserDAO;
import com.khushi.dao.VendorDAO;
import com.khushi.model.User;
import com.khushi.model.VendorDetail;

@Controller
public class HomeController {

	@Autowired
	UserDAO userdao;
	@Autowired
	VendorDAO vendordao;
	@Autowired
	private JavaMailSender mailSender;

	@RequestMapping(value = "/")
	public ModelAndView hi() {
		return new ModelAndView("home");
	}
	
	@RequestMapping(value = "/error404")
	public ModelAndView error() {
		return new ModelAndView("home", "error", "No such page exists.");
	}

	@RequestMapping(value = { "/partner", "/addVendor" }, method = RequestMethod.GET)
	public ModelAndView partner() {
		ModelAndView model = new ModelAndView("partner");
		model.addObject("vendorDetails", new VendorDetail());
		return model;
	}

	@RequestMapping(value = "/accessDenied")
	public String accessDeny() {
		return "accessDenied";
	}

	@RequestMapping(value = "/partner", method = RequestMethod.POST)
	public ModelAndView partnerDet(@ModelAttribute("vendorDetails") VendorDetail vendorDetails) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			User user = userdao.get(userDetail.getUsername());
			if (user.getRole().equalsIgnoreCase("ROLE_ADMIN")) {
				if (userdao.get(vendorDetails.getUsername()) != null) {
					return new ModelAndView("home", "error", "UserID already exists.");
				}
				userdao.saveOrUpdate(vendorDetails.getUsername(), vendorDetails.getPassword(), "ROLE_VENDOR");
				vendordao.addOrUpdate(vendorDetails);
				mailSender.send(getEmailForProposal(vendorDetails));
				return new ModelAndView("home", "msg", "Vendor added.");
			} else if (user.getRole().equalsIgnoreCase("ROLE_VENDOR")) {
				vendorDetails.setUsername(userDetail.getUsername());
				vendordao.addOrUpdate(vendorDetails);
				return new ModelAndView("home", "msg", "Vendor Profile Updated.");
			} else if (user.getRole().equalsIgnoreCase("ROLE_USER")) {
				mailSender.send(getEmailForVendor(vendorDetails));
				return new ModelAndView("home", "msg", "Request sent to admin.");
			} else {
				return new ModelAndView("home", "error",
						"You cannot partner with us as a vendor as you are our delivery partner.");
			}
		} else {
			mailSender.send(getEmailForVendor(vendorDetails));
			return new ModelAndView("home", "msg", "Request sent to admin.");
		}
	}

	private SimpleMailMessage getEmailForVendor(VendorDetail vendorDetails) {
		SimpleMailMessage email = new SimpleMailMessage();
		email.setTo("khushiagrawal99@gmail.com"); // admin e-mail
		email.setSubject("Vendor Proposal");
		String emailText = "";
		emailText += vendorDetails.getProposal() + "\n";
		emailText += "Contact Details: \n";
		emailText += "Name: " + vendorDetails.getName() + "\n";
		emailText += "Company Name: " + vendorDetails.getCompanyName() + "\n";
		emailText += "Email: " + vendorDetails.getEmail() + "\n";
		emailText += "Contact: " + vendorDetails.getContact() + "\n";
		email.setText(emailText);
		return email;
	}
	
	private SimpleMailMessage getEmailForProposal(VendorDetail vendorDetails) {
		SimpleMailMessage email = new SimpleMailMessage();
		email.setTo(vendorDetails.getEmail());
		email.setSubject("Vendor Details for Tejumal Departmental Store");
		String emailText = "";
		emailText += "We feel delighted to partner with you as our vendor for the future endeavours. "
				+ "Here is your username and password for logging in for the first time. "
				+ "Your username cannot be changed, however, "
				+ "you can change your password anytime you wish to.\n";
		emailText += "Username: " + vendorDetails.getUsername() + "\n";
		emailText += "Password: " + vendorDetails.getPassword() + "\n";
		emailText += "Thank You!";
		email.setText(emailText);
		return email;
	}
	
	
}