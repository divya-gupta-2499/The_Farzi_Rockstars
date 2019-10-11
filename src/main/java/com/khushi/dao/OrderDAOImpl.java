package com.khushi.dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.ResultSetExtractor;

import com.khushi.model.Bill;
import com.khushi.model.Category;
import com.khushi.model.Item;
import com.khushi.model.Order;
import com.khushi.model.Product;

public class OrderDAOImpl implements OrderDAO {

	@Autowired
	DataSource dataSource;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	CartDAO cartdao;
	@Autowired
	ProductDAO productdao;

	List<Order> orders = new ArrayList<Order>();
	List<Integer> allOrderIds = new ArrayList<Integer>();

	@Override
	public void addOrder(String username) {
		int orderId = /*Order.incrementOrderId()*/ getOrderId() + 1;
		String sql = "insert into all_orders(orderId, username) values(?, ?)";
		jdbcTemplate.update(sql, new Object[] { orderId, username });
		//return orderId;
	}

	@Override
	public void addOrderInfo(int orderId, String username) {
		List<Item> orderInfo = cartdao.findAll(username);
		for (int i = 0; i < orderInfo.size(); i++) {
			String sql = "insert into order_info values(?, ?, ?)";
			jdbcTemplate.update(sql, new Object[] { orderId, orderInfo.get(i).getProduct().getProductId(),
					orderInfo.get(i).getQuantity() });
		}

		String sql = "delete from cart where username = ?";
		jdbcTemplate.update(sql, new Object[] { username });

	}

	@Override
	public List<Order> findAll(final String username) {
		orders = new ArrayList<Order>();
		String sql = "SELECT * FROM order_info, all_orders WHERE username = ? and "
				+ "order_info.orderId = all_orders.orderId";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, username);
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
					order.setStatus(rs.getString("status"));
					orders.add(order);
				}
				return orders;
			}

		});
	}

	@Override
	public List<Order> getAll() {
		orders = new ArrayList<Order>();
		String sql = "SELECT * FROM order_info";
		return jdbcTemplate.query(sql, new ResultSetExtractor<List<Order>>() {

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
					orders.add(order);
				}
				return orders;
			}

		});
	}

	@Override
	public List<Order> findOrdersForOrderId(final int orderId) {
		orders = new ArrayList<Order>();
		String sql = "SELECT * FROM order_info WHERE orderId = ?";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setInt(1, orderId);
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
					orders.add(order);
				}
				return orders;
			}

		});
	}

	@Override
	public List<Integer> getAllOrders(final String username) {
		allOrderIds = new ArrayList<Integer>();
		String sql = "SELECT orderId FROM all_orders WHERE username = ?";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, username);
			}
		}, new ResultSetExtractor<List<Integer>>() {

			@Override
			public List<Integer> extractData(ResultSet rs) throws SQLException, DataAccessException {
				while (rs.next()) {
					int orderId = rs.getInt("orderId");
					allOrderIds.add(orderId);
				}
				return allOrderIds;
			}

		});
	}

	@Override
	public List<Order> getPendingOrders() {
		orders = new ArrayList<Order>();
		String sql = "SELECT all_orders.orderId, productId, quantity FROM all_orders, order_info WHERE "
				+ "status = ? and all_orders.orderId = order_info.orderId";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, "Packaging");
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
					order.setStatus("Packaging");
					orders.add(order);
				}
				return orders;
			}

		});
	}

	@Override
	public void generateBill(int orderId, String shippingAddress) {
		String sql = "insert into bill values(?, ?, ?, ?)";
		// SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss");
		java.util.Date tDate = new java.util.Date();

//		String str = dtf.format(localDate); 
//		java.util.Date utilDate = new SimpleDateFormat("yyyy-MM-dd").parse(str);
		Date date = new Date(tDate.getTime());
		jdbcTemplate.update(sql, new Object[] { orderId, date, "Cash on delivery", shippingAddress });
	}

	@Override
	public Bill getBill(final int orderId) {
		String sql = "SELECT * FROM bill WHERE orderId = ?";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setInt(1, orderId);
			}
		}, new ResultSetExtractor<Bill>() {

			@Override
			public Bill extractData(ResultSet rs) throws SQLException, DataAccessException {
				if (rs.next()) {
					Bill bill = new Bill();
					bill.setOrderId(orderId);
					bill.setDate(rs.getDate("dateOfIssue"));
					bill.setPaymentMethod(rs.getString("paymentMethod"));
					bill.setShippingAddress(rs.getString("shipping_address"));
					return bill;
				}
				return null;
			}

		});
	}

	@Override
	public String getUsernameFromOrderId(final int orderId) {
		String sql = "SELECT username FROM all_orders WHERE orderId = ?";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setInt(1, orderId);
			}
		}, new ResultSetExtractor<String>() {

			@Override
			public String extractData(ResultSet rs) throws SQLException, DataAccessException {
				if (rs.next()) {
					String username = rs.getString("username");
					return username;
				}
				return null;
			}

		});
	}

	@Override
	public int getOrderId() {
		String sql = "Select max(orderId) as orderId from all_orders";
		return jdbcTemplate.query(sql,

				new ResultSetExtractor<Integer>() {

					@Override
					public Integer extractData(ResultSet rs) throws SQLException, DataAccessException {
						if (rs.next()) {
							int orderId = rs.getInt("orderId");
							return orderId;
						}
						return 0;
					}

				});
	}

	@Override
	public boolean isProductInOrders(final String productId) {
		String sql = "SELECT orderId FROM order_info WHERE productId = ?";
		allOrderIds = new ArrayList<Integer>();
		return (jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, productId);
			}
		}, new ResultSetExtractor<List<Integer>>() {

			@Override
			public List<Integer> extractData(ResultSet rs) throws SQLException, DataAccessException {
				while (rs.next()) {
					allOrderIds.add(rs.getInt("orderId"));
				}
				return allOrderIds;
			}

		})).isEmpty() ? false : true;
	}
}