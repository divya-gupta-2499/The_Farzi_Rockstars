package com.khushi.model;

import java.sql.Date;

public class Bill{
	
	private int orderId;
	private Date date;
	private String paymentMethod;
	private String houseNo;
	private String street;
	private String shippingAddress;
	private String locality;

	public Bill() {	
		// TODO Auto-generated constructor stub
	}

	public Bill(int orderId, Date date, String paymentMethod, String houseNo, String street, String locality) {
		super();
		this.orderId = orderId;
		this.date = date;
		this.paymentMethod = paymentMethod;
		this.houseNo = houseNo;
		this.street = street;
		this.locality = locality;
	}



	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getShippingAddress() {
		return shippingAddress;
	}

	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}

	public String getHouseNo() {
		return houseNo;
	}

	public void setHouseNo(String houseNo) {
		this.houseNo = houseNo;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getLocality() {
		return locality;
	}

	public void setLocality(String locality) {
		this.locality = locality;
	}

	
}