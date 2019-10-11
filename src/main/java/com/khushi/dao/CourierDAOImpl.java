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

import com.khushi.model.Courier;
import com.khushi.model.Item;
import com.khushi.model.Order;
import com.khushi.model.Product;

public class CourierDAOImpl implements CourierDAO {

	@Autowired
	DataSource dataSource;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private ProductDAO productdao;

	List<Order> orders = new ArrayList<Order>();

	@Override
	public void addCourier(Courier courier) {
		String sql = "insert into courier values (?,?,?)";
		jdbcTemplate.update(sql,
				new Object[] { courier.getUsername(), courier.getCourierCompanyName(), courier.getEmail() });
	}

	@Override
	public List<Order> getAcceptedOrders(final String username) {
		orders = new ArrayList<Order>();
		String sql = "SELECT order_info.orderId, productId, quantity, status FROM courier_status, order_info WHERE "
				+ "status = ? and username = ? and courier_status.orderId = order_info.orderId";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setInt(1, 0);
				preparedStatement.setString(2, username);
			}
		}, new ResultSetExtractor<List<Order>>() {

			@Override
			public List<Order> extractData(ResultSet rs) throws SQLException, DataAccessException {
				while (rs.next()) {
					Order order = new Order();
					order.setOrderId(rs.getInt("orderId"));
					// order.setUsername(getUsernameFromOrderId(orderId));
					Item item = new Item();
					item.setProduct(productdao.get(rs.getString("productId")));
					item.setQuantity(rs.getInt("quantity"));
					order.setItem(item);
					order.setStatus("Accepted");
					orders.add(order);
				}
				return orders;
			}

		});
	}

	@Override
	public List<Order> getDeliveredOrders(final String username) {
		orders = new ArrayList<Order>();
		String sql = "SELECT order_info.orderId, productId, quantity, status FROM courier_status, order_info WHERE "
				+ "status = ? and username = ? and courier_status.orderId = order_info.orderId";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setInt(1, 1);
				preparedStatement.setString(2, username);
			}
		}, new ResultSetExtractor<List<Order>>() {

			@Override
			public List<Order> extractData(ResultSet rs) throws SQLException, DataAccessException {
				while (rs.next()) {
					Order order = new Order();
					order.setOrderId(rs.getInt("orderId"));
					// order.setUsername(getUsernameFromOrderId(orderId));
					Item item = new Item();
					item.setProduct(productdao.get(rs.getString("productId")));
					item.setQuantity(rs.getInt("quantity"));
					order.setItem(item);
					order.setStatus("Delivered");
					orders.add(order);
				}
				return orders;
			}

		});
	}

	@Override
	public void acceptOrder(final int orderId, final String username) {
		String sql = "Insert into courier_status values(?,?,?)";
		jdbcTemplate.update(sql, new Object[] { username, 0, orderId });
		sql = "Update all_orders set status = ? where orderId = ?";
		jdbcTemplate.update(sql, new Object[] { "Accepted", orderId });
	}

	@Override
	public void deliverOrder(final int orderId) {
		String sql = "Update courier_status set status = ? where orderId = ?";
		jdbcTemplate.update(sql, new Object[] { 1, orderId });
		sql = "Update all_orders set status = ? where orderId = ?";
		jdbcTemplate.update(sql, new Object[] { "Delivered", orderId });
	}

}