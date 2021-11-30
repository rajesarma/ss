package com.ss.sample.util;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCrypt;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class Util {

	/**
	 * Formats given date to LocalDateTime default string format
	 *
	 * @return Eg: '2011-12-03T10:15:30+01:00'
	 * */
	public static String formatDate(Date date, ZoneId zone){

		if(date == null){
			throw new IllegalArgumentException("Date cannot be null.");
		}

		LocalDateTime timestampLocalDateTime = LocalDateTime.ofInstant(date.toInstant(), zone);

		return DateTimeFormatter.ISO_DATE_TIME.format(timestampLocalDateTime);
	}

	public static boolean isProfileDev(String[] activeProfiles) {
		return activeProfiles != null && activeProfiles.length == 1 && activeProfiles[0].equals(Constants.Profiles.dev);
	}

	public static String getBcryptPassword(String password) {

		return BCrypt.hashpw(password, BCrypt.gensalt(11));
	}

	public static boolean isAuthenticatedJobSeeker () {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		 return (auth != null &&
				auth.getPrincipal() != null &&
				auth.getAuthorities().stream().anyMatch(a ->
						a.getAuthority().equals("ROLE_" + Constants.Roles.JOB_SEEKER_ROLE.toUpperCase()) ||
						a.getAuthority().equals("ROLE_" + Constants.Roles.ADMIN_ROLE.toUpperCase())
				)
		);
	}
}
