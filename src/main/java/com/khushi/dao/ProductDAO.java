package com.khushi.dao;

import java.util.List;

import com.khushi.model.Category;
import com.khushi.model.Product;

public interface ProductDAO {

	public void addProduct(Product product);

	public List<Product> findAll(final String categoryName);

	public Product get(int productId);

	public List<Category> getCategory();
	
	public void addCategory(Category category);
	
	public List<Product> findAllProducts();
	
	public void deleteProduct(int productId);
}