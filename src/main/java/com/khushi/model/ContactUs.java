package com.khushi.model;

public class ContactUs {

	private int feedbackId;
	private String contactInfo;
	private String subject;
	private String details;
	private String reply;

	public ContactUs() {

		// TODO Auto-generated constructor stub
	}

	public ContactUs(String contactInfo, String subject, String details) {
		super();
		this.contactInfo = contactInfo;
		this.subject = subject;
		this.details = details;
	}

	public int getFeedbackId() {
		return feedbackId;
	}

	public void setFeedbackId(int feedbackId) {
		this.feedbackId = feedbackId;
	}

	public String getContactInfo() {
		return contactInfo;
	}

	public void setContactInfo(String contactInfo) {
		this.contactInfo = contactInfo;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public String getReply() {
		return reply;
	}

	public void setReply(String reply) {
		this.reply = reply;
	}

}