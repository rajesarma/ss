package com.ss.sample.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.springframework.web.multipart.MultipartFile;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;


@Data
@SuperBuilder(toBuilder = true)
@AllArgsConstructor
@NoArgsConstructor
public class JobSeekerDto extends RegisterDto implements Serializable {

	private static final long serialVersionUID = 5321331807936736479L;

	//	@NotBlank(message = "Father Name cannot be empty")
	private String fatherName;

	private Gender gender = Gender.MALE;

	//	@Pattern(regexp="[\\d]{10}")
	private String alternateNo;

	//	@NotEmpty(message = "Aadhar can not empty")
	private String aadhar;

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
	private List<JobSeekerSkillDto> userSkills;
}
