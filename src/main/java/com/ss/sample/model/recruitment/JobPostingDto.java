package com.ss.sample.model.recruitment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.List;


@Data
@Builder(toBuilder = true)
@AllArgsConstructor
@NoArgsConstructor
public class JobPostingDto implements Serializable {
	private static final long serialVersionUID = -2818057768981272295L;
	private long id;
	private String jobId;
	private String userId;
	private String title;
	private Integer experience; //
	private String location; //
	private String description;
	@DateTimeFormat(pattern = "dd/MM/yyyy")
	private String lastDateToApply;

	private String mailTo; //
	private String qualifications; //
	private String otherDetails;
	private Double salary; //
	private String company;

	@DateTimeFormat(pattern = "dd/MM/yyyy")
	private String postedOn;
	private List<JobPostingRoleDto> jobPostingRoles;
	private List<JobPostingSkillDto> jobPostingSkills;
}
