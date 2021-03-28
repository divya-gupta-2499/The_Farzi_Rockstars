package com.khushi.dao;

import com.khushi.model.Customer;

public interface CustomerDAO {

	public Customer getCustomer(final String username);

	void addCustomer(Customer customer);

	void updateCustomer(Customer customer);
}