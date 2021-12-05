package com.ss.sample.model;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.*;
import java.time.LocalDate;
import java.util.List;

@Data
public class JobSeekerDto {

	private long id;
	private String userId;

	@NotEmpty(message = "Password can not empty")
	private String password;

	@NotBlank(message = "Name cannot be empty")
	private String fullName;

	@NotBlank(message = "Father Name cannot be empty")
	private String fatherName;

	private Gender gender = Gender.MALE;

	@Pattern(regexp="[\\d]{10}")
	private String mobile;

	@Pattern(regexp="[\\d]{10}")
	private String alternateNo;

	@NotEmpty(message = "Email can not empty")
	@Email
	private String email;

	@NotEmpty(message = "Aadhar can not empty")
	private String aadhar;

	@NotEmpty(message = "Address can not empty")
	private String address;

	@NotEmpty(message = "Postal Code can not empty")
	private String postalCode;

	@DateTimeFormat(pattern = "dd/MM/yyyy")
	@Past
	private LocalDate dob;

	private String photoName=null;
	private String photoData;
	private MultipartFile photo;

	private String resumeName=null;
	private String resumeData;
	private MultipartFile resume;

	private String maritalStatus;

	private char isActive;
	private String createdOn;
	private String updatedOn;
	private String lastLogin;
//	private String shortlistedFlag;
//	private String shortlistedDate;
//	private String interviewScheduledDate;
//	private String interviewAttendedFlag;
//	private String selectedStatus;
//	private String selectedDate;
//	private String offerLetterGenerated;
//	private String offerLetterGeneratedDate;

	private List<JobSeekerExpDto> userExperiences;
	private List<JobSeekerQlyDto> userQualifications;
	private List<JobSeekerSkillDto> userSkills;
}
