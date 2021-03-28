package com.khushi.model;

public class VendorProposal {

	private String username;
	private int productId;
	private int price;
	private int status;

	public VendorProposal() {
		// TODO Auto-generated constructor stub
	}

	public VendorProposal(String username, int productId, int price) {
		super();
		this.username = username;
		this.productId = productId;
		this.price = price;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}