package com.ss.sample.model;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

@Data
public class JobSeekerDto implements Serializable {

	private static final long serialVersionUID = 5321331807936736479L;

	private long id;
	private String userId;

	@NotEmpty(message = "Password can not empty")
	private String password;

	@NotEmpty(message = "Confirm Password can not empty")
	private String confirmPassword;

	@NotBlank(message = "First Name cannot be empty")
	private String firstName;

	@NotBlank(message = "Last Name cannot be empty")
	private String lastName;

//	@NotBlank(message = "Father Name cannot be empty")
	private String fatherName;

	private Gender gender = Gender.MALE;

//	@Pattern(regexp="[\\d]{10}")
	private String mobile;

//	@Pattern(regexp="[\\d]{10}")
	private String alternateNo;

	@NotEmpty(message = "Email can not empty")
	@Email
	private String email;

//	@NotEmpty(message = "Aadhar can not empty")
	private String aadhar;

//	@NotEmpty(message = "Address can not empty")
	private String address;

//	@NotEmpty(message = "Postal Code can not empty")
	private String postalCode;

//	@DateTimeFormat(pattern = "dd/MM/yyyy")
//	@Past
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
}
