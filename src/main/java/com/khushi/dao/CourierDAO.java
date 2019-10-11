package com.khushi.dao;

import java.util.List;

import com.khushi.model.Courier;
import com.khushi.model.Order;

public interface CourierDAO {

	public void addCourier(Courier courier);
	
	public List<Order> getDeliveredOrders(final String username);
	
	public List<Order> getAcceptedOrders(final String username);
	
	public void acceptOrder(final int orderId, final String username);
	
	public void deliverOrder(final int orderId);

}