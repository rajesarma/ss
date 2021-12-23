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
public class JobPostingRoleDto implements Serializable {

	private static final long serialVersionUID = 7283820179161735251L;
	private Long id;
	private String roleResponsibility;
	private Boolean deleteFlag;
}
