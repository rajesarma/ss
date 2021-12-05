package com.ss.sample.model;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.Past;

@Data
public class JobSeekerQlyDto {
    private long id;
    private String userId;
    private String qualification;
    private double percentage;
    private String boardUniversity;
    private String specialization;
    private String instituteName;

    @DateTimeFormat(pattern = "dd/MM/yyyy")
    @Past
    private String startDate;

    @DateTimeFormat(pattern = "dd/MM/yyyy")
    @Past
    private String completionDate;
}
