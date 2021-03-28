package com.khushi.model;

import java.util.HashMap;
import java.util.Map;

public class Order {

	public static int noOfOrders = 0;
	private int orderId;
	private String username;
	private Item item;
	private String status;
	private String courierId; 
	private static Map<String, Integer> idStatus = new HashMap<String, Integer>();

	public Order() {

		// TODO Auto-generated constructor stub
	}

	public Order(int orderId, /*String username,*/ Item item) {
		super();
		this.orderId = orderId;
		//this.username = username;
		this.item = item;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	public static int orderIdForUser(String username) {
		idStatus.put(username, idStatus.get(username) + 1);
		return idStatus.get(username);
	}

	public static int incrementOrderId() {
		noOfOrders++;
		return noOfOrders;
	}

	public static int getNoOfOrders(String username) {
		return idStatus.get(username);
	}

	public static void setOrderId(String username) {
		idStatus.put(username, 0);
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCourierId() {
		return courierId;
	}

	public void setCourierId(String courierId) {
		this.courierId = courierId;
	}

}