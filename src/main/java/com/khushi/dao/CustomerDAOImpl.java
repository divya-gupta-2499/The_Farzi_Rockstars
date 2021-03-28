package com.khushi.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.ResultSetExtractor;

import com.khushi.model.Customer;

public class CustomerDAOImpl implements CustomerDAO {

	@Autowired
	DataSource dataSource;
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public CustomerDAOImpl() {

		// TODO Auto-generated constructor stub
	}

	public CustomerDAOImpl(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public void updateCustomer(Customer customer) {
		/*
		 * // TODO Auto-generated method stub if (getCustomer(customer.getUsername()) ==
		 * null) { String sql = "INSERT into customer values(?,?,?,?,?,?,?,?,?,?)";
		 * jdbcTemplate.update(sql, new Object[] { customer.getUsername(),
		 * customer.getPassword(), customer.getFName(), customer.getLName(),
		 * customer.getEmail(), customer.getContact(), customer.getAge(),
		 * customer.getHouseNo(), customer.getStreet(), 1 }); sql =
		 * "INSERT into user_roles values(?,?)"; jdbcTemplate.update(sql, new Object[] {
		 * customer.getUsername(), "ROLE_CUSTOMER" }); } else {
		 */
		String sql = "UPDATE customer set fName= ?, lName = ?, email = ?, contact = ?, age = ?, houseNo = ?,"
				+ " street = ?, locality = ? where username = ?";
		jdbcTemplate.update(sql,
				new Object[] { customer.getfName(), customer.getlName(), customer.getEmail(), customer.getContact(),
						customer.getAge(), customer.getHouseNo(), customer.getStreet(), customer.getUsername() });
	}

	@Override
	public void addCustomer(Customer customer) {
		// TODO Auto-generated method stub
		String sql = "INSERT into customer values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		jdbcTemplate.update(sql,
				new Object[] { customer.getUsername(), customer.getfName(), customer.getlName(), customer.getEmail(),
						customer.getContact(), customer.getAge(), customer.getHouseNo(), customer.getStreet(), customer.getLocality() });

		/*sql = "Insert into street_locality values(?,?)";
		jdbcTemplate.update(sql, new Object[] { customer.getStreet(), customer.getLocality() });*/
		/*
		 * if (getCustomer(customer.getUsername()) == null) { String sql =
		 * "INSERT into customer values(?,?,?,?,?,?,?,?,?,?)"; jdbcTemplate.update(sql,
		 * new Object[] { customer.getUsername(), customer.getPassword(),
		 * customer.getFName(), customer.getLName(), customer.getEmail(),
		 * customer.getContact(), customer.getAge(), customer.getHouseNo(),
		 * customer.getStreet(), 1 }); sql = "INSERT into user_roles values(?,?)";
		 * jdbcTemplate.update(sql, new Object[] { customer.getUsername(),
		 * "ROLE_CUSTOMER" }); } else { String sql =
		 * "UPDATE customer set password = ?, fName = ?, lName = ?, email = ?, contact = ?, age = ?, houseNo = ?, street = ? where username = ?"
		 * ; jdbcTemplate.update(sql, new Object[] { customer.getPassword(),
		 * customer.getFName(), customer.getLName(), customer.getEmail(),
		 * customer.getContact(), customer.getAge(), customer.getHouseNo(),
		 * customer.getStreet(), customer.getUsername() }); }
		 */
	}

	@Override
	public Customer getCustomer(final String username) {
		// TODO Auto-generated method stub

		String sql = "SELECT * FROM customer WHERE username = ?";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, username);
			}
		}, new ResultSetExtractor<Customer>() {

			@Override
			public Customer extractData(ResultSet rs) throws SQLException, DataAccessException {
				if (rs.next()) {
					Customer customer = new Customer();
					customer.setUsername(rs.getString("username"));
					customer.setfName(rs.getString("fName"));
					customer.setlName(rs.getString("lName"));
					customer.setContact(rs.getLong("contact"));
					customer.setEmail(rs.getString("email"));
					customer.setAge(rs.getInt("age"));
					customer.setHouseNo(rs.getString("houseNo"));
					customer.setStreet(rs.getString("street"));
					customer.setLocality(rs.getString("locality"));
					return customer;
				}
				return null;
			}

		});
	}

}
