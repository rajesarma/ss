package com.ss.sample.model.recruitment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Past;
import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder(toBuilder = true)
public class JobSeekerExpDto implements Serializable {

    private static final long serialVersionUID = 7869684385045512253L;

    private Long id;
    private String userId;

    private String company;
    private Integer expMonths;

    @DateTimeFormat(pattern = "dd/MM/yyyy")
    @Past
    private String fromDate;

    @DateTimeFormat(pattern = "dd/MM/yyyy")
    @Past
    private String toDate;

    @NotEmpty(message = "Designation can not empty")
    private String designation;

    @NotEmpty(message = "Job location can not empty")
    private String jobLocation;

    private Boolean isCurrentJob;
}
