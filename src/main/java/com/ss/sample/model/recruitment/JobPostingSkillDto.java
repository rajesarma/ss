package com.ss.sample.model.recruitment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;


@Data
@Builder(toBuilder = true)
@AllArgsConstructor
@NoArgsConstructor
public class JobPostingSkillDto implements Serializable {

	private static final long serialVersionUID = -1622176060985968305L;
	private Long id;
	private String skill;
	private Boolean deleteFlag;
}
