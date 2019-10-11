package com.khushi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.khushi.dao.UserDAO;
import com.khushi.model.ContactUs;

@Controller
public class FeedbackController {

	@Autowired
	UserDAO userdao;
	
	@RequestMapping(value = "/contactUs", method = RequestMethod.GET)
	public ModelAndView contact() {
		ModelAndView model = new ModelAndView("contact");
		model.addObject("contactUs", new ContactUs());
		return model;
	}

	@RequestMapping(value = "/replyFeedback/{feedbackId}", method = RequestMethod.GET)
	public ModelAndView f1(@PathVariable("feedbackId") int feedbackId) {
		ModelAndView model = new ModelAndView("feedbackReply");
		model.addObject("feedbackId", feedbackId);
		ContactUs feedback = new ContactUs();
		feedback.setFeedbackId(feedbackId);
		model.addObject("feedback", feedback);
		return model;
	}

	@RequestMapping(value = "/replyFeedback/{feedbackId}", method = RequestMethod.POST)
	public String f2(@ModelAttribute("feedback") ContactUs feedback) {
		userdao.updateFeedback(feedback.getFeedbackId(), feedback.getReply());
		return "redirect:/viewAllFeedbacks";
	}

	@RequestMapping(value = "/contactUs", method = RequestMethod.POST)
	public ModelAndView contact(@ModelAttribute("contactUs") ContactUs contactUs) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			UserDetails userDetail = (UserDetails) auth.getPrincipal();
			contactUs.setContactInfo(userDetail.getUsername());
		}
		userdao.addFeedback(contactUs);
		return new ModelAndView("home", "msg", "Your query will be resolved shortly. Thank you!");
	}

	@RequestMapping(value = "/viewAllFeedbacks")
	public ModelAndView feedbacks() {
		List<ContactUs> feedbacks = userdao.getAllFeedbacks();
		if(feedbacks.isEmpty()) {
			return new ModelAndView("home", "msg", "No feedbacks to display.");
		}
		return new ModelAndView("allFeedback", "feedbacks", feedbacks);
	}

	@RequestMapping(value = "/viewReplies")
	public ModelAndView r1() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserDetails userDetail = (UserDetails) auth.getPrincipal();
		List<ContactUs> feedbacks = userdao.getFeedbacksWithReplies(userDetail.getUsername());
		if(feedbacks.isEmpty()) {
			return new ModelAndView("home", "msg", "No feedbacks sent by you have received replies yet.");
		}
		return new ModelAndView("allFeedback", "feedbacks", feedbacks);
	}
	
}