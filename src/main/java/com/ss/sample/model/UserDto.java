package com.ss.sample.model;

import com.ss.sample.entity.RoleEntity;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Data
public class UserDto implements Serializable {

	private static final long serialVersionUID = -1170953597777516616L;

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
}
