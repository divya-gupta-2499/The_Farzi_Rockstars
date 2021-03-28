package com.khushi.model;

public class Customer {

	private String username;
	private String password;
	private String fName;
	private String lName;
	private String email;
	private long contact;
	private String houseNo;
	private String street;
	private String locality;
	private int age;

	public Customer() {
		// TODO Auto-generated constructor stub
	}

	public Customer(String username, String password, String fName, String lName, String email, long contact,
			String houseNo, String street, String locality, int age) {
		super();
		this.username = username;
		this.password = password;
		this.fName = fName;
		this.lName = lName;
		this.email = email;
		this.contact = contact;
		this.houseNo = houseNo;
		this.street = street;
		this.locality = locality;
		this.age = age;
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

	public String getfName() {
		return fName;
	}

	public void setfName(String fName) {
		this.fName = fName;
	}

	public String getlName() {
		return lName;
	}

	public void setlName(String lName) {
		this.lName = lName;
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

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}
	
	
}