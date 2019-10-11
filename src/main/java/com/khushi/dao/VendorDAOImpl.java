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

import com.khushi.model.Customer;
import com.khushi.model.Item;
import com.khushi.model.Order;
import com.khushi.model.VendorDetail;
import com.khushi.model.VendorProposal;

public class VendorDAOImpl implements VendorDAO {

	@Autowired
	DataSource dataSource;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	List<VendorProposal> proposals = new ArrayList<VendorProposal>();

	public VendorDAOImpl() {

		// TODO Auto-generated constructor stub
	}

	public VendorDAOImpl(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public void updateVendor(VendorDetail vendor) {
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
		String sql = "UPDATE vendor set name= ?, companyName = ?, email = ?, contact = ? where username = ?";
		jdbcTemplate.update(sql,
				new Object[] { vendor.getName(), vendor.getCompanyName(), vendor.getEmail(), vendor.getContact(),
						vendor.getUsername() });
	}

	@Override
	public void addOrUpdate(VendorDetail vendor) {
		// TODO Auto-generated method stub
		if(getVendor(vendor.getUsername()) == null) {
		String sql = "INSERT into vendor values(?, ?, ?, ?, ?)";
		jdbcTemplate.update(sql,
				new Object[] { vendor.getUsername(), vendor.getName(), vendor.getCompanyName(), vendor.getEmail(),
						vendor.getContact() });
		}
		
		else {
			String sql = "UPDATE vendor set name= ?, companyName = ?, email = ?, contact = ? where username = ?";
			jdbcTemplate.update(sql,
					new Object[] { vendor.getName(), vendor.getCompanyName(), vendor.getEmail(), vendor.getContact(),
							vendor.getUsername() });
		}

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
	public VendorDetail getVendor(final String username) {
		// TODO Auto-generated method stub

		String sql = "SELECT * FROM vendor WHERE username = ?";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, username);
			}
		}, new ResultSetExtractor<VendorDetail>() {

			@Override
			public VendorDetail extractData(ResultSet rs) throws SQLException, DataAccessException {
				if (rs.next()) {
					VendorDetail vendor = new VendorDetail();
					vendor.setUsername(rs.getString("username"));
					vendor.setName(rs.getString("name"));
					vendor.setCompanyName(rs.getString("companyName"));
					vendor.setContact(rs.getLong("contact"));
					vendor.setEmail(rs.getString("email"));
					return vendor;
				}
				return null;
			}

		});
	}
	
	@Override
	public boolean existsInProposal(final String username, final String productId) {
		// TODO Auto-generated method stub

		String sql = "SELECT username FROM vendor_proposal WHERE username = ? and productId = ?";
		String user = jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, username);
				preparedStatement.setString(2, productId);
			}
		}, new ResultSetExtractor<String>() {

			@Override
			public String extractData(ResultSet rs) throws SQLException, DataAccessException {
				if (rs.next()) {
					return rs.getString("username");
				}
				return null;
			}

		});
		
		return user == null ? false : true;
	}
	
	@Override
	public void addProposal(String username, String productId, int price) {
		// TODO Auto-generated method stub
		
		String sql = "INSERT into vendor_proposal(username,productId,price) values(?, ?, ?)";
		jdbcTemplate.update(sql,
				new Object[] { username, productId, price });

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
	public List<VendorProposal> getAllProposals() {
		proposals = new ArrayList<VendorProposal>();
		String sql = "SELECT * FROM vendor_proposal where status = ?";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setInt(1, 0);
			}
			
		}, new ResultSetExtractor<List<VendorProposal>>() {

			@Override
			public List<VendorProposal> extractData(ResultSet rs) throws SQLException, DataAccessException {
				while (rs.next()) {
					VendorProposal vendorProposal = new VendorProposal();
					vendorProposal.setUsername(rs.getString("username"));
					vendorProposal.setProductId(rs.getString("productId"));
					vendorProposal.setPrice(rs.getInt("price"));
					vendorProposal.setStatus(rs.getInt("status"));
					proposals.add(vendorProposal);
				}
				return proposals;
			}

		});
	}
	
	@Override
	public void acceptProposal(String username, String productId) {
		// TODO Auto-generated method stub
		
		String sql = "Update vendor_proposal set status = ? where username = ? and productId = ?";
		jdbcTemplate.update(sql,
				new Object[] { 1, username, productId });


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
	public List<VendorProposal> getAcceptedProposals(final String username) {
		proposals = new ArrayList<VendorProposal>();
		String sql = "SELECT * FROM vendor_proposal where status = ? and username = ?";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setInt(1, 1);
				preparedStatement.setString(2, username);
			}
			
		}, new ResultSetExtractor<List<VendorProposal>>() {

			@Override
			public List<VendorProposal> extractData(ResultSet rs) throws SQLException, DataAccessException {
				while (rs.next()) {
					VendorProposal vendorProposal = new VendorProposal();
					vendorProposal.setUsername(rs.getString("username"));
					vendorProposal.setProductId(rs.getString("productId"));
					vendorProposal.setPrice(rs.getInt("price"));
					vendorProposal.setStatus(rs.getInt("status"));
					proposals.add(vendorProposal);
				}
				return proposals;
			}

		});
	}

	/*@Override
	public String getLocality(final String username) {
		String sql = "select locality from customer,street_locality where customer.username = ? and "
				+ "customer.street = street_locality.street";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, username);
			}
		}, new ResultSetExtractor<String>() {

			@Override
			public String extractData(ResultSet rs) throws SQLException, DataAccessException {
				if (rs.next()) {
					String locality = rs.getString("locality");
					return locality;
				}
				return null;
			}

		});
	}*/

}
