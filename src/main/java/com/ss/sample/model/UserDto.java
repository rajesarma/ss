package com.ss.sample.model;

import com.ss.sample.entity.RoleEntity;

import java.util.Date;
import java.util.List;

public class UserDto {

	public UserDto() {

	}

	public UserDto(final String username,
				   final String password,
				   final boolean disabled,
				   final String userDesc,
				   final String email,
				   final List<RoleEntity> roles) {
		this.username = username;
		this.password = password;
		this.disabled = disabled;
		this.userDesc = userDesc;
		this.email = email;
		this.roles = roles;
	}

	private long userId;

//	@NotEmpty(message = "{User Name can not be empty}")
	private String username;

//	@NotEmpty(message = "{Password can not be empty}")
	private String password;

	private String newPassword;

	private Boolean disabled;

//	@NotEmpty(message = "{Description can not be empty}")
	private String userDesc;

//	@NotEmpty(message = "{Email can not be empty}")
	private String email;
	private Date lastLogin;
	private Long failedLoginAttempts;
	private List<RoleEntity> roles;
	private Date lastPasswordChange;

	private String activeStatus;


	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Boolean getDisabled() {
		return disabled;
	}

	public void setDisabled(Boolean disabled) {
		this.disabled = disabled;
	}

	public String getUserDesc() {
		return userDesc;
	}

	public void setUserDesc(String userDesc) {
		this.userDesc = userDesc;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(Date lastLogin) {
		this.lastLogin = lastLogin;
	}

	public Long getFailedLoginAttempts() {
		return failedLoginAttempts;
	}

	public void setFailedLoginAttempts(Long failedLoginAttempts) {
		this.failedLoginAttempts = failedLoginAttempts;
	}

	public List<RoleEntity> getRoles() {
		return roles;
	}

	public void setRoles(List<RoleEntity> roles) {
		this.roles = roles;
	}

	public Date getLastPasswordChange() {
		return lastPasswordChange;
	}

	public void setLastPasswordChange(Date lastPasswordChange) {
		this.lastPasswordChange = lastPasswordChange;
	}

	public String getActiveStatus() {
		return activeStatus;
	}

	public void setActiveStatus(String activeStatus) {
		this.activeStatus = activeStatus;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
}
