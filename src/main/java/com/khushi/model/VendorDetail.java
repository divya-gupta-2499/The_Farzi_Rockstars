package com.khushi.model;

public class VendorDetail {

	private String username;
	private String password;
	private String name;
	private String companyName;
	private String email;
	private long contact;
	private String proposal;

	public VendorDetail() {
		// TODO Auto-generated constructor stub
	}

	public VendorDetail(String username, String password, String name, String companyName, String email, long contact,
			String proposal) {
		super();
		this.username = username;
		this.password = password;
		this.name = name;
		this.companyName = companyName;
		this.email = email;
		this.contact = contact;
		this.proposal = proposal;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public long getContact() {
		return contact;
	}

	public void setContact(long contact) {
		this.contact = contact;
	}

	public String getProposal() {
		return proposal;
	}

	public void setProposal(String proposal) {
		this.proposal = proposal;
	}

	
}