package com.ss.sample.util;

import com.ss.sample.entity.UserEntity;
import com.ss.sample.model.UserDto;

public class UserConverter {

	public static UserEntity convert(final UserDto userDto) {

		UserEntity userEntity = new UserEntity();
		userEntity.setUserId(userDto.getUserId());
		userEntity.setUsername(userDto.getUsername());
		userEntity.setPassword(userDto.getPassword());
		userEntity.setDisabled(userDto.getDisabled() != null ? userDto.getDisabled() : true);
		userEntity.setUserDesc(userDto.getUserDesc());
		userEntity.setEmail(userDto.getEmail());
//		userEntity.setLastLogin(user.getLastLogin() != null ? user.getLastLogin() :
//				null );
//		userEntity.setFailedLoginAttempts(user.getFailedLoginAttempts()!=null ?
//				user.getFailedLoginAttempts() : null );
		userEntity.setRoles(userDto.getRoles());
//		userEntity.setLastPasswordChange(user.getLastPasswordChange() != null ?
//				user.getLastPasswordChange() : null);
		
		return userEntity;
	}

	public static UserDto convert(final UserEntity userEntity) {

		UserDto userDto = new UserDto();
		userDto.setUserId(userEntity.getUserId());
		userDto.setUsername(userEntity.getUsername());
		userDto.setPassword(userEntity.getPassword());
		userDto.setDisabled(userEntity.getDisabled());
		userDto.setActiveStatus(userEntity.getDisabled() ? "Disabled" : "Active" );
		userDto.setUserDesc(userEntity.getUserDesc());
		userDto.setEmail(userEntity.getEmail());
		userDto.setLastLogin(userEntity.getLastLogin());
		userDto.setFailedLoginAttempts(userEntity.getFailedLoginAttempts());
		userDto.setRoles(userEntity.getRoles());
		userDto.setLastPasswordChange(userEntity.getLastPasswordChange());

		return userDto;
	}
}
