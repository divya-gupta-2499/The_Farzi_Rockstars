package com.khushi.dao;

import java.util.List;

import com.khushi.model.Bill;
import com.khushi.model.Order;

public interface OrderDAO {

	public void addOrder(String username);

	public void addOrderInfo(int orderId, String username);

	public List<Order> findAll(final String username);

	public List<Integer> getAllOrders(final String username);

	public void generateBill(int orderId, String shippingAddress);

	public Bill getBill(final int orderId);

	public List<Order> getAll();
	
	public String getUsernameFromOrderId(final int orderId); 
	
	public List<Order> findOrdersForOrderId(final int orderId);
	
	public List<Order> getPendingOrders();
	
	public boolean isProductInOrders(final String productId);
	
	public int getOrderId();

}

