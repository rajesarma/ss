package com.ss.sample.model;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Past;

@Data
public class JobSeekerExpDto {
    private long id;
    private String userId;

    private String company;
    private int expMonths;

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

    private boolean isCurrentJob;

    public boolean isCurrentJob() {
        return isCurrentJob;
    }

    public void setCurrentJob(boolean currentJob) {
        isCurrentJob = currentJob;
    }
}
