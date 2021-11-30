package com.ss.sample.model;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.Past;
import java.time.LocalDate;

@Data
public class JobSeekerExpDto {
    private long id;
    private String userId;

    private String company;
    private int expMonths;

    @DateTimeFormat(pattern = "dd/MM/yyyy")
    @Past
    private String fromDate;

    /*@DateTimeFormat(pattern = "dd/MM/yyyy")
    @Past
    private LocalDate fromDate;*/

    @DateTimeFormat(pattern = "dd/MM/yyyy")
    @Past
    private String toDate;

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
}
