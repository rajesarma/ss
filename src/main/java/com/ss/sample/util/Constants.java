package com.ss.sample.util;

public class Constants {

	public static final class Urls {
		public static final String APPLICATION_ROOT = "/";

		public static final String CSS = "/css";
		public static final String JS = "/js";
		public static final String IMAGES = "/js";
		public static final String FAVICON = "/favicon.ico";

		public static final String ROOT = "/";
		public static final String HOME = "/home";
		public static final String LOGIN = "/login";
		public static final String LOGOUT = "/logout";
		public static final String ACCESS_DENIED = "/login";
		public static final String SESSION_TIMEOUT = "/sessionTimeout";

		public static final String ADMIN = "/admin/";
		public static final String MANAGEMENT = "/management/";
		public static final String SUPERVIZOR = "/super/";

		public static final String CSS_ALL = "/css/*.css";
		public static final String JS_ALL = "/js/*.js";
		public static final String IMAGES_ALL = "/*.js";
		public static final String FAVICON_ALL = "/*.ico";
	}

	public static final class Roles {
		public static final String ADMIN_ROLE = "ADMIN";
		public static final String MANAGEMENT_ROLE = "MANAGEMENT";
		public static final String SUPERVIZOR_ROLE = "SUPERVIZOR";
		public static final String JOB_SEEKER_ROLE = "Job Seeker";

		public static final int ADMIN_ROLE_ID = 1;
		public static final int MANAGEMENT_ROLE_ID = 4;
		public static final int SUPERVIZOR_ROLE_ID = 5;
		public static final int JOB_SEEKER_ROLE_ID = 9;
	}

	public static final class Profiles {
		public static final String dev = "dev";
		public static final String test = "test";
		public static final String prod = "prod";
	}

	public static final class StrConstants {
		public static final String SESSION_USER_NAME = "username";
		public static final String APP_NAME = "SAMPLE";
		public static final String MOBILE = "mobileNo.";
		public static final String EMAIL = "email";
		public static final String AADHAR = "aadhar";
	}

	public static final class Conditions {

		public static final String LT = "<";
		public static final String LE = "<=";
		public static final String EQ = "=";
		public static final String GE = ">=";
		public static final String GT = ">";
	}


}
