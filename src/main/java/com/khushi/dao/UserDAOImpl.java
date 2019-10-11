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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.khushi.model.ContactUs;
import com.khushi.model.Item;
import com.khushi.model.Order;
import com.khushi.model.Product;
import com.khushi.model.User;

public class UserDAOImpl implements UserDAO {

	@Autowired
	DataSource dataSource;
	@Autowired
	private JdbcTemplate jdbcTemplate;

	BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

	List<ContactUs> feedbacks = new ArrayList<ContactUs>();

	public UserDAOImpl() {

		// TODO Auto-generated constructor stub
	}

	public UserDAOImpl(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public void saveOrUpdate(String username, String password, String role) {
		// TODO Auto-generated method stub
		if (get(username) == null) {
			if (role.equals("ROLE_USER")) {
				String sql = "INSERT into users(username,password,user_role) values(?,?,?)";
				String hashedPassword = passwordEncoder.encode(password);
				jdbcTemplate.update(sql, new Object[] { username, hashedPassword, role });
			} else {
				String sql = "INSERT into users(username,password,enabled, user_role) values(?,?,?,?)";
				String hashedPassword = passwordEncoder.encode(password);
				jdbcTemplate.update(sql, new Object[] { username, hashedPassword, 1, role });

			}

		}
		/*
		 * else { String sql =
		 * "UPDATE users set password = ?, age = ?, email = ?, contact = ? where username = ?"
		 * ; jdbcTemplate.update(sql,new Object[]
		 * {user.getUsername(),user.getPassword(),user.getAge(),user.getEmail(),user.
		 * getContact(), user.getUserid()}); }
		 */

	}

	@Override
	public void addActivationCode(String username, String activationCode) {
		// TODO Auto-generated method stub

		String sql = "INSERT into activation_codes values(?,?)";
		jdbcTemplate.update(sql, new Object[] { username, activationCode });

		/*
		 * else { String sql =
		 * "UPDATE users set password = ?, age = ?, email = ?, contact = ? where username = ?"
		 * ; jdbcTemplate.update(sql,new Object[]
		 * {user.getUsername(),user.getPassword(),user.getAge(),user.getEmail(),user.
		 * getContact(), user.getUserid()}); }
		 */

	}

	@Override
	public void addFeedback(ContactUs contactUs) {
		// TODO Auto-generated method stub

		String sql = "INSERT into feedback(contact_info, subject, details) values(?,?,?)";
		jdbcTemplate.update(sql,
				new Object[] { contactUs.getContactInfo(), contactUs.getSubject(), contactUs.getDetails() });

		/*
		 * else { String sql =
		 * "UPDATE users set password = ?, age = ?, email = ?, contact = ? where username = ?"
		 * ; jdbcTemplate.update(sql,new Object[]
		 * {user.getUsername(),user.getPassword(),user.getAge(),user.getEmail(),user.
		 * getContact(), user.getUserid()}); }
		 */

	}

	@Override
	public void activateUser(final String activationCode) {
		// TODO Auto-generated method stub

		String sql = "Select username from activation_codes where code = ?";
		String username = jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, activationCode);
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

		sql = "Update users set enabled = ? where username = ?";
		jdbcTemplate.update(sql, new Object[] { 1, username });

		sql = "Delete from activation_codes where code = ?";
		jdbcTemplate.update(sql, new Object[] { activationCode });

		/*
		 * else { String sql =
		 * "UPDATE users set password = ?, age = ?, email = ?, contact = ? where username = ?"
		 * ; jdbcTemplate.update(sql,new Object[]
		 * {user.getUsername(),user.getPassword(),user.getAge(),user.getEmail(),user.
		 * getContact(), user.getUserid()}); }
		 */

	}

	@Override
	public void updateFeedback(int feedbackId, String reply) {
		// TODO Auto-generated method stub

		String sql = "UPDATE feedback set reply = ? where feedbackId = ?";
		jdbcTemplate.update(sql, new Object[] { reply, feedbackId });

		/*
		 * else { String sql =
		 * "UPDATE users set password = ?, age = ?, email = ?, contact = ? where username = ?"
		 * ; jdbcTemplate.update(sql,new Object[]
		 * {user.getUsername(),user.getPassword(),user.getAge(),user.getEmail(),user.
		 * getContact(), user.getUserid()}); }
		 */

	}

	@Override
	public List<ContactUs> getAllFeedbacks() {
		feedbacks = new ArrayList<ContactUs>();
		String sql = "SELECT * FROM feedback";
		return jdbcTemplate.query(sql, new ResultSetExtractor<List<ContactUs>>() {

			@Override
			public List<ContactUs> extractData(ResultSet rs) throws SQLException, DataAccessException {
				while (rs.next()) {
					ContactUs feedback = new ContactUs();
					feedback.setFeedbackId(rs.getInt("feedbackId"));
					feedback.setContactInfo(rs.getString("contact_info"));
					feedback.setSubject(rs.getString("subject"));
					feedback.setDetails(rs.getString("details"));
					feedback.setReply(rs.getString("reply"));
					feedbacks.add(feedback);
				}
				return feedbacks;
			}

		});
	}

	@Override
	public List<ContactUs> getFeedbacksWithReplies(final String username) {
		feedbacks = new ArrayList<ContactUs>();
		return jdbcTemplate.query("SELECT * FROM feedback WHERE contact_info = ? and reply is not null",
				new PreparedStatementSetter() {

					public void setValues(PreparedStatement preparedStatement) throws SQLException {
						preparedStatement.setString(1, username);
					}
				}, new ResultSetExtractor<List<ContactUs>>() {

					@Override
					public List<ContactUs> extractData(ResultSet rs) throws SQLException, DataAccessException {
						while (rs.next()) {
							ContactUs feedback = new ContactUs();
							feedback.setFeedbackId(rs.getInt("feedbackId"));
							feedback.setContactInfo(rs.getString("contact_info"));
							feedback.setSubject(rs.getString("subject"));
							feedback.setDetails(rs.getString("details"));
							feedback.setReply(rs.getString("reply"));
							feedbacks.add(feedback);
						}
						return feedbacks;
					}

				});
	}

	@Override
	public User get(final String username) {
		// TODO Auto-generated method stub

		String sql = "SELECT * FROM users WHERE username = ?";
		return jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, username);
			}

		}, new ResultSetExtractor<User>() {

			@Override
			public User extractData(ResultSet rs) throws SQLException, DataAccessException {
				if (rs.next()) {
					User user = new User();
					user.setUsername(rs.getString("username"));
					user.setPassword(rs.getString("password"));
					user.setRole(rs.getString("user_role"));
					user.setEnabled(true);
					return user;
				}
				return null;
			}

		});
	}

	@Override
	public boolean checkPassword(final String username, final String password) {
		String sql = "SELECT password FROM users WHERE username = ?";
		String correctPassword = (jdbcTemplate.query(sql, new PreparedStatementSetter() {

			public void setValues(PreparedStatement preparedStatement) throws SQLException {
				preparedStatement.setString(1, username);
			}

		}, new ResultSetExtractor<String>() {

			@Override
			public String extractData(ResultSet rs) throws SQLException, DataAccessException {
				if (rs.next()) {
					return rs.getString("password");
				}
				return null;
			}
		}));

		return passwordEncoder.matches(password, correctPassword) ? true : false;
	}

	@Override
	public void updatePassword(final String username, final String password) {
		String hashedPassword = passwordEncoder.encode(password);
		String sql = "Update users set password = ? WHERE username = ?";
		jdbcTemplate.update(sql, new Object[] { hashedPassword, username });
	}

}
