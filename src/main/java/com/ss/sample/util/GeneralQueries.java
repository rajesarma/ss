package com.ss.sample.util;

public class GeneralQueries {

	public static String getUserData(String userName, String password) {
		return "select u.id, user_name, user_desc, email, r.role_id, GROUP_CONCAT(role_name) as role_name  " +
				//" from users u join roles r on r.role_id = u.role_id " +
				" from users u " +
				" join user_roles ur on u.id = ur.user_id " +
				" join roles r on r.role_id = ur.role_id" +
				" where user_name = '"+userName+"'" +
				" and password ='"+password+"'";
	}

	public static String getUserData(String userName) {
		return "select u.id, real_password, user_name, email, r.role_id, GROUP_CONCAT" +
				"(role_name) as role_name " +
				" from users u " +
				" join user_roles ur on u.id = ur.user_id" +
				" join roles r on r.role_id = ur.role_id" +
				" where user_name='"+userName+"'";
	}

	public static String getUserData(long userId) {
		return "select u.id, user_name, email, r.role_id, GROUP_CONCAT(role_name) as role_name " +
//				" from users u join roles r on r.role_id = u.role_id" +
				" from users u " +
				" join user_roles ur on u.id = ur.user_id" +
				" join roles r on r.role_id = ur.role_id" +
				" where id="+userId;
	}

	public static String isUserExists(String userName) {
		String sql = "select count(*) as count from users where user_name ='"+userName+"' ";
		return sql;
	}

	public static String isValidUser(String userName, String password) {
		return " select count(*) as count from users " +
				" where user_name = '"+userName+ "'" +
				" and password = '"+password+"' ";
	}

	public static String updateUserLogin(long userId) {
		return "update users set last_login = now() where id = "+userId;
	}

	public static String getUserFailureLoginCount(String userName) {
		return "select case when failed_login_attempts is not null then " +
				"failed_login_attempts else 0 end as count from users where user_name ='"+userName+"'";
	}

	public static String resetUserFailureAttempt(long userId) {
		String sql = "update users set failed_login_attempts = 0 where id = " + userId;
		return sql;
	}

	public static String updateUserFailureAttempt(String userName) {
		return "update users set failed_login_attempts = (coalesce(failed_login_attempts,0) + 1) " +
				"where user_name = '" + userName+"'";
	}

	public static String getUsersByRole(long roleId) {
		return "select u.id, user_id, user_name, email, r.role_id, GROUP_CONCAT(role_name) as role_name " +
				" from users u " +
				" join roles r on r.role_id = u.role_id " +
				" join user_roles ur on u.id = ur.user_id" +
				" where r.role_id = "+roleId+ " " +
				"order by id";
	}

	public static String addUser()
	{
		return "insert into users(id, user_id, user_name, email,role_id) values (" +
				"(SELECT MAX( id )+1 FROM users user), ?, ?, ?,?)";
	}

	public static String getAllUsers = "select id, user_id, user_name, email, r.role_id, role_name from users u join roles r on r.role_id = u.role_id order by id";
	public static String getRoles = "select role_id, role_name from roles";
}
