package com.khushi.model;

public class User {

	private String username;
	private String password;
	private boolean enabled;
	private String role;

	public User() {
		// TODO Auto-generated constructor stub
	}

	public User(String username, String password, boolean enabled, String role) {
		super();
		this.username = username;
		this.password = password;
		this.enabled = enabled;
		this.role = role;
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

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
}