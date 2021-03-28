package com.khushi.model;

public class Product {

	private int productId;
	private String productName;
	
	private int price;
	private String categoryName;
	private String productUrl;

	public Product() {

		// TODO Auto-generated constructor stub
	}

	public Product(int productId, String productName, int price, String categoryName) {
		super();
		this.productId = productId;
		this.productName = productName;	
		this.price = price;
		this.categoryName = categoryName;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getProductUrl() {
		return productUrl;
	}

	public void setProductUrl(String productUrl) {
		this.productUrl = productUrl;
	}

}