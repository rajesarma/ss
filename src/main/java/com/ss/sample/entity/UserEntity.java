package com.ss.sample.entity;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "users")
public class UserEntity implements Serializable {

	private static final long serialVersionUID = -6820586948643587814L;

	@Id
	@Column(name="id", updatable = false, nullable = false)
	@NotNull
	@GeneratedValue(strategy = GenerationType.SEQUENCE)
	private long userId;

	@Column(name="user_name")
	@NotNull
	private String username;

	@Column(name="password")
	@NotNull
	private String password;

	@Column(name="disabled")
	private Boolean disabled;

	/*@Column(name="role_id")
	@NotNull
	private int roleId;*/

	@Column(name="user_desc")
	private String userDesc;

	@Column(name="email")
	private String email;

	@Column(name="last_login")
	private Date lastLogin;

	@Column(name="failed_login_attempts")
	private Long failedLoginAttempts;

//	@OneToMany(fetch= FetchType.EAGER) //cascade= CascadeType.ALL,
	@ManyToMany(fetch= FetchType.EAGER)
	@Cascade({CascadeType.SAVE_UPDATE})
	@JoinTable(name="user_roles",
			joinColumns = {@JoinColumn(name="user_id", referencedColumnName="id")},
			inverseJoinColumns = {@JoinColumn(name="role_id", referencedColumnName=
					"role_id", unique = false)}
	)
	private List<RoleEntity> roles;

	@Column(name="last_password_change")
	private Date lastPasswordChange;

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

	public void setDisabled(boolean disabled) {
		this.disabled = disabled;
	}

	public Boolean getDisabled() {
		return disabled;
	}

	public Date getLastPasswordChange() {
		return lastPasswordChange;
	}

	public void setLastPasswordChange(Date lastPasswordChange) {
		this.lastPasswordChange = lastPasswordChange;
	}

	public UserEntity() {

	}

	public UserEntity(long userId, String userName, String email, boolean disabled,
                      String userDesc) {
		super();
		this.userId = userId;
		this.username = userName;
		this.email = email;
		this.disabled = disabled;
		this.userDesc = userDesc;
	}

	public UserEntity(UserEntity user) {
		this.userId = user.userId;
		this.username = user.username;
		this.password = user.password;
		this.email = user.email;
		this.disabled = user.disabled;
		this.userDesc = user.userDesc;
		this.lastLogin = user.lastLogin;
		this.failedLoginAttempts = user.failedLoginAttempts;
		this.roles = user.roles;
	}

	public UserEntity(long userId, String userName, String password) {
		super();
		this.userId = userId;
		this.username = userName;
		this.password = password;
	}
}
