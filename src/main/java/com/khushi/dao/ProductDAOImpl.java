package com.khushi.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.ResultSetExtractor;

import com.khushi.model.Category;
import com.khushi.model.Product;

public class ProductDAOImpl implements ProductDAO {

	@Autowired
	DataSource dataSource;
	@Autowired
	private JdbcTemplate jdbcTemplate;

	private List<Product> products = new ArrayList<Product>();
	private List<Category> categories = new ArrayList<Category>();

	@Override
	public void addProduct(Product product) {
		if (get(product.getProductId()) == null) {
			String sql = "INSERT INTO product(productId, productName, price, categoryName) VALUES (?, ?, ?, ?)";
			jdbcTemplate.update(sql, new Object[] { product.getProductId(), product.getProductName(),
					 product.getPrice(), product.getCategoryName() });
		}

		else {
			String sql = "UPDATE product SET productName = ?, price = ?, categoryName = ? WHERE productId = ?";
			jdbcTemplate.update(sql, new Object[] { product.getProductName(), product.getPrice(),
					product.getCategoryName(), product.getProductId() });
		}

	}
	
	@Override
	public void deleteProduct(String productId) {
		String sql = "delete from product where productId = ?";
		jdbcTemplate.update(sql, new Object[] { productId });

	}
	
	@Override
	public void addCategory(Category category) {		
			String sql = "INSERT INTO category values(?, ?)";
			jdbcTemplate.update(sql, new Object[] { category.getCategoryName(), category.getDescription() });	
	}

	
	@Override
	public List<Product> findAll(final String categoryName) {
		products = new ArrayList<Product>();
		return jdbcTemplate.query("SELECT * FROM product WHERE categoryName = ?", new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, categoryName);
			}
		}, new ResultSetExtractor<List<Product>>() {

			@Override
			public List<Product> extractData(ResultSet rs) throws SQLException, DataAccessException {
				while (rs.next()) {
					Product product = new Product();
					product.setProductId(rs.getString("productId"));
					product.setProductName(rs.getString("productName"));
					product.setPrice(rs.getInt("price"));
					product.setCategoryName(rs.getString("categoryName"));
					product.setProductUrl(rs.getString("product_url"));
					products.add(product);
				}
				return products;
			}

		});
	}
	
	@Override
	public List<Product> findAllProducts() {
		products = new ArrayList<Product>();
		return jdbcTemplate.query("SELECT * FROM product", 
			new ResultSetExtractor<List<Product>>() {

			@Override
			public List<Product> extractData(ResultSet rs) throws SQLException, DataAccessException {
				while (rs.next()) {
					Product product = new Product();
					product.setProductId(rs.getString("productId"));
					product.setProductName(rs.getString("productName"));
					product.setPrice(rs.getInt("price"));
					product.setCategoryName(rs.getString("categoryName"));
					product.setProductUrl(rs.getString("product_url"));
					products.add(product);
				}
				return products;
			}

		});
	}

	@Override
	public List<Category> getCategory() {
		categories = new ArrayList<Category>();
		return jdbcTemplate.query("select * from category", new ResultSetExtractor<List<Category>>() {
			@Override
			public List<Category> extractData(ResultSet rs) throws SQLException, DataAccessException {
				while (rs.next()) {
					Category category = new Category();
					category.setCategoryName(rs.getString("categoryName"));
					category.setDescription(rs.getString("description"));
					categories.add(category);
				}
				return categories;
			}
		});
	}

	@Override
	public Product get(final String productId) {
		// TODO Auto-generated method stub

		String sql = "SELECT * FROM product WHERE productId = ?";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, productId);
			}
		}, new ResultSetExtractor<Product>() {

			@Override
			public Product extractData(ResultSet rs) throws SQLException, DataAccessException {
				if (rs.next()) {
					Product product = new Product();
					product.setProductId(rs.getString("productId"));
					product.setProductName(rs.getString("productName"));
					product.setPrice(rs.getInt("price"));
					product.setCategoryName(rs.getString("categoryName"));
					product.setProductUrl(rs.getString("product_url"));
					return product;
				}
				return null;
			}

		});
	}
}