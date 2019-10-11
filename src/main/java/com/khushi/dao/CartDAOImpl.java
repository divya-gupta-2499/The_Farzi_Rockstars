package com.khushi.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.ResultSetExtractor;

import com.khushi.model.Item;
import com.khushi.model.Product;

public class CartDAOImpl implements CartDAO {

	@Autowired
	DataSource dataSource;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private ProductDAO productdao;

	private List<Item> cart = new ArrayList<Item>();

	@Override
	public void addToCart(String productId, String username) {
		if (getItem(username, productId) == null) {
			String sql = "INSERT INTO cart VALUES (?, ?, ?)";
			jdbcTemplate.update(sql, new Object[] { username, productId, 1 });
		}

		else {
			String sql = "UPDATE cart SET quantity = ? + 1 WHERE productId = ? and username = ?";
			jdbcTemplate.update(sql,
					new Object[] { ((Item) getItem(username, productId)).getQuantity(), productId, username });
		}

	}

	@Override
	public void removeFromCart(String productId, String username) {
		String sql = "DELETE FROM cart WHERE productId = ? and username = ?";
		jdbcTemplate.update(sql, new Object[] { productId, username });
	}

	@Override
	public void updateCart(String username, String productId, int quantity) {
		String sql = "UPDATE cart SET quantity = ? WHERE username = ? AND productId = ?";
		jdbcTemplate.update(sql, new Object[] { quantity, username, productId });
	}

	@Override
	public List<Item> findAll(final String username) {
		cart = new ArrayList<Item>();
		String sql = "SELECT * FROM cart WHERE username = ?";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, username);
			}
		}, new ResultSetExtractor<List<Item>>() {

			@Override
			public List<Item> extractData(ResultSet rs) throws SQLException, DataAccessException {
				while (rs.next()) {
					Item item = new Item();
					item.setProduct(productdao.get(rs.getString("productId")));
					item.setQuantity(rs.getInt("quantity"));
					cart.add(item);
				}
				return cart;
			}

		});
	}

	@Override
	public Item getItem(final String username, final String productId) {

		String sql = "SELECT * FROM cart WHERE productId = ? and username = ?";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, productId);
				preparedStatement.setString(2, username);
			}
		}, new ResultSetExtractor<Item>() {

			@Override
			public Item extractData(ResultSet rs) throws SQLException, DataAccessException {
				if (rs.next()) {
					Item item = new Item();
					item.setProduct(productdao.get(rs.getString("productId")));
					item.setQuantity(rs.getInt("quantity"));
					return item;
				}
				return null;
			}

		});
	}

}