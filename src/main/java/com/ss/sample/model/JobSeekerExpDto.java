package com.ss.sample.model;

import lombok.Data;
import org.apache.commons.lang3.StringUtils;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Past;
import java.util.Objects;

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

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public int getExpMonths() {
        return expMonths;
    }

    public void setExpMonths(int expMonths) {
        this.expMonths = expMonths;
    }

    public String getFromDate() {
        return fromDate;
    }

    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    public String getToDate() {
        return toDate;
    }

    public void setToDate(String toDate) {
        this.toDate = toDate;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getJobLocation() {
        return jobLocation;
    }

    public void setJobLocation(String jobLocation) {
        this.jobLocation = jobLocation;
    }

    public boolean getIsCurrentJob() {
        return isCurrentJob;
    }

    public void setIsCurrentJob(boolean isCurrentJob) {
        this.isCurrentJob = isCurrentJob;
    }
}
