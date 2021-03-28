package com.khushi.model;

public class Courier {

	private String username;
	private String password;
	private String courierCompanyName;
	private String email;
	private int status;
	private int orderId;

	public Courier() {

		// TODO Auto-generated constructor stub
	}

	public Courier(String username, String courierCompanyName, String email, int status, int orderId) {
		super();
		this.username = username;
		this.courierCompanyName = courierCompanyName;
		this.email = email;
		this.status = status;
		this.orderId = orderId;
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

	public String getCourierCompanyName() {
		return courierCompanyName;
	}

	public void setCourierCompanyName(String courierCompanyName) {
		this.courierCompanyName = courierCompanyName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	

}