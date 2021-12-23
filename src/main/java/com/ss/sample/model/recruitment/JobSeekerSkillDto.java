package com.ss.sample.model.recruitment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.Past;
import java.io.Serializable;

@Data
@Builder(toBuilder = true)
@AllArgsConstructor
@NoArgsConstructor
public class JobSeekerSkillDto implements Serializable {

    private static final long serialVersionUID = 6309389030417901027L;

    private Long id;
    private String userId;
    private Integer expMonths;
    private Integer skillLevel;
    private Long skillTypeId;
    private Long skillId;
}
