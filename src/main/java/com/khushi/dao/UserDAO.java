package com.khushi.dao;

import java.util.List;

import com.khushi.model.ContactUs;
import com.khushi.model.User;

public interface UserDAO {

	public User get(final String username);

	void addFeedback(ContactUs contactUs);

	void saveOrUpdate(String username, String password, String role);
	
	public List<ContactUs> getAllFeedbacks();
	
	public List<ContactUs> getFeedbacksWithReplies(final String username);
	
	public void updateFeedback(int feedbackId, String reply);
	
	public boolean checkPassword(final String username, final String password);
	
	public void updatePassword(final String username, final String password);
	
	public void addActivationCode(String username, String activationCode);
	
	public void activateUser(final String activationCode);
}