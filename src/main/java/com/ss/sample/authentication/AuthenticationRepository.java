package com.ss.sample.authentication;

import com.ss.sample.entity.UserEntity;
import com.ss.sample.exception.AuthenticationException;
import com.ss.sample.util.DBUtils;
import com.ss.sample.util.GeneralQueries;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

//@Repository("jdbc")
public class AuthenticationRepository {

//	@Autowired
	private DBUtils dbUtils;

	@Autowired
	AuthenticationRepository(DBUtils dbUtils) {
		this.dbUtils = dbUtils;
	}

	UserEntity authenticateUser(String userName, String password) throws AuthenticationException {

		try {
			Statement statement = dbUtils.getDBStatement();

			// If User Exists
			if(dbUtils.recordExists(GeneralQueries.isUserExists(userName))) {

				// If User and Password Matches
				if(dbUtils.recordExists(GeneralQueries.isValidUser(userName,password))) {

					UserEntity user = getUserData(GeneralQueries.getUserData(userName
							, password));

					statement.execute(GeneralQueries.updateUserLogin(user.getUserId()));	// Update User Last Login
					statement.executeUpdate(GeneralQueries.resetUserFailureAttempt(user.getUserId()));	// Update User Last Login

					return user;
				} else {
					// Update user failure login attempt
					statement.executeUpdate(GeneralQueries.updateUserFailureAttempt(userName));
					throw new AuthenticationException("Username and Password does not match");
				}
			} else {
				throw new AuthenticationException("Username does not exists");
			}

		} catch (SQLException e) {

			throw new AuthenticationException("Something went wrong !!!");
		}
	}

	public UserEntity authenticateUser(String userName) throws AuthenticationException {

		// If User Exists
		if(dbUtils.recordExists(GeneralQueries.isUserExists(userName))) {
			UserEntity user = getUserData(GeneralQueries.getUserData(userName));

			return user;
		}

		return null;
	}

	private UserEntity getUserData(String sql) throws AuthenticationException {
		ResultSet rs = null;
		UserEntity user = null;
		try
		{
			rs = dbUtils.getDBStatement().executeQuery(sql);

			if(rs.next()) {
				user = new UserEntity(rs.getLong("id"), rs.getString("user_name"),
						rs.getString("real_password")
//						, rs.getString("role_name")
				);
				// rs.getLong("role_id"), rs.getString("user_desc"),

			}
		} catch (SQLException e) {
			throw new AuthenticationException("Something went Wrong");

		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return user;
	}

	ArrayList getServices(String userName, String password)
	{
		ResultSet rs;
		ArrayList<HashMap<String, String>> services = new ArrayList<>();
		HashMap<String, String> serviceMap;

		try
		{
			/*String sql = "select s.service_id, s.service_url, s.service_name,s" +
					".parent_id, s.display_order, s.menu_display" +
					" from users u" +
					" join role_services rs on(u.role_id = rs.role_id )" +
					" join services s on (s.service_id = rs.service_id)" +
					" where user_name = '"+userName+ "' " +
					" and password = '"+password+"'" +
					" order by parent_id, service_id";*/

			String sql = "select s.service_id, s.service_url, s.service_name, " +
					" s.parent_id, s.display_order, s.menu_display, s.has_childs" +
					" from users u" +
					" join user_roles ur on (u.id = ur.user_id)" +
					" join roles r on (r.role_id = ur.role_id)" +
					" join role_services rs on (r.role_id = rs.role_id )" +
					" join services s on (s.service_id = rs.service_id)" +
					" where user_name = '"+userName+ "' " +
					" and password = '"+password+"'" +
					" order by parent_id, service_id";


			rs = dbUtils.getDBStatement().executeQuery(sql);
			while (rs.next())
			{
				serviceMap = new HashMap<>();

				serviceMap.put("serviceId", rs.getString("service_id"));
				serviceMap.put("serviceUrl", rs.getString("service_url"));
				serviceMap.put("serviceName", rs.getString("service_name"));
				serviceMap.put("parentId", rs.getString("parent_id"));
				serviceMap.put("displayOrder", rs.getString("display_order"));
				serviceMap.put("menuDisplay", rs.getString("menu_display"));
				serviceMap.put("hasChilds", rs.getString("has_childs"));
				services.add(serviceMap);
			}
		}
		catch(SQLException sqle)
		{
			return null;
		}

		return services;
	}

	ArrayList getServices(String userName)
	{
		ResultSet rs;
		ArrayList<HashMap<String, String>> services = new ArrayList<>();
		HashMap<String, String> serviceMap;

		try
		{
			/*String sql = "select s.service_id, s.service_url, s.service_name,s" +
					".parent_id, s.display_order, s.menu_display" +
					" from users u" +
					" join role_services rs on(u.role_id = rs.role_id )" +
					" join services s on (s.service_id = rs.service_id)" +
					" where user_name = '"+userName+ "' " +
					" order by parent_id, service_id";*/

			String sql = "select s.service_id, s.service_url, s.service_name, " +
					" s.parent_id, s.display_order, s.menu_display, s.has_childs" +
					" from users u" +
					" join user_roles ur on (u.id = ur.user_id)" +
					" join roles r on (r.role_id = ur.role_id)" +
					" join role_services rs on (r.role_id = rs.role_id )" +
					" join services s on (s.service_id = rs.service_id)" +
					" where user_name = '"+userName+ "' " +
					" order by parent_id, service_id";


			rs = dbUtils.getDBStatement().executeQuery(sql);
			while (rs.next())
			{
				serviceMap = new HashMap<>();

				serviceMap.put("serviceId", rs.getString("service_id"));
				serviceMap.put("serviceUrl", rs.getString("service_url"));
				serviceMap.put("serviceName", rs.getString("service_name"));
				serviceMap.put("parentId", rs.getString("parent_id"));
				serviceMap.put("displayOrder", rs.getString("display_order"));
				serviceMap.put("menuDisplay", rs.getString("menu_display"));
				serviceMap.put("hasChilds", rs.getString("has_childs"));

				services.add(serviceMap);
			}
		}
		catch(SQLException sqle)
		{
			return null;
		}

		return services;
	}
}
