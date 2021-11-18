package com.ss.sample.model;

import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.*;

public class JobSeekerDto {

	public JobSeekerDto() {

	}

	public JobSeekerDto(long id, @NotBlank(message = "User ID cannot be empty") String userId, @NotEmpty(message = "Password can not empty") String password, String fullName, String isActive, String createdOn, String gender, String mobile, String alternateNo, @NotEmpty(message = "Email can not empty") @Email String email, String address, String dob, String photo, String resume, String fatherName, String maritalStatus, String updtedOn, String lastLogin) {
		this.id = id;
		this.userId = userId;
		this.password = password;
		this.fullName = fullName;
		this.isActive = isActive;
		this.createdOn = createdOn;
		this.gender = gender;
		this.mobile = mobile;
		this.alternateNo = alternateNo;
		this.email = email;
		this.address = address;
		this.dob = dob;
		this.photo = photo;
		this.resume = resume;
		this.fatherName = fatherName;
		this.maritalStatus = maritalStatus;
		this.updtedOn = updtedOn;
		this.lastLogin = lastLogin;
	}

	private long id;
	private String userId;

	@NotEmpty(message = "Password can not empty")
	private String password;

	@NotBlank(message = "Name cannot be empty")
	private String fullName;

	@NotBlank(message = "Father Name cannot be empty")
	private String fatherName;

	private String isActive;
	private String createdOn;

	private String gender;

	@Pattern(regexp="[\\d]{10}")
	private String mobile;

	@Pattern(regexp="[\\d]{10}")
	private String alternateNo;

	@NotEmpty(message = "Email can not empty")
	@Email
	private String email;
	private String address;

//	@DateTimeFormat(pattern="MM/dd/yyyy")
	private String dob;
	private String photo;
	private String resume;

	private String maritalStatus;
	private String updtedOn;
	private String lastLogin;
//	private String shortlistedFlag;
//	private String shortlistedDate;
//	private String interviewScheduledDate;
//	private String interviewAttendedFlag;
//	private String selectedStatus;
//	private String selectedDate;
//	private String offerLetterGenerated;
//	private String offerLetterGeneratedDate;


	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getIsActive() {
		return isActive;
	}

	public void setIsActive(String isActive) {
		this.isActive = isActive;
	}

	public String getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(String createdOn) {
		this.createdOn = createdOn;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getAlternateNo() {
		return alternateNo;
	}

	public void setAlternateNo(String alternateNo) {
		this.alternateNo = alternateNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getResume() {
		return resume;
	}

	public void setResume(String resume) {
		this.resume = resume;
	}

	public String getFatherName() {
		return fatherName;
	}

	public void setFatherName(String fatherName) {
		this.fatherName = fatherName;
	}

	public String getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getUpdtedOn() {
		return updtedOn;
	}

	public void setUpdtedOn(String updtedOn) {
		this.updtedOn = updtedOn;
	}

	public String getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(String lastLogin) {
		this.lastLogin = lastLogin;
	}
}
