package com.khushi.dao;

import java.util.List;
import com.khushi.model.Item;

public interface CartDAO {

	public void addToCart(String productId, String username);

	public void updateCart(String username, String productId, int quantity);

	public void removeFromCart(String productId, String username);

	public List<Item> findAll(final String username);

	public Item getItem(final String username, final String productId);

}