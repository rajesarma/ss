package com.ss.sample.entity.recruitment;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;

@Entity
@Table(name = "recruitment_user_experiences")
public class RecruitmentUserExpEntity implements Serializable {

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_exp_generator")
    @SequenceGenerator(name = "user_exp_generator", sequenceName = "recruitment_user_experiences_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "company")
    private String company;

    @Column(name = "exp_months")
    private Integer expMonths;

    @Column(name = "from_date")
    private LocalDate fromDate;

    @Column(name = "to_date")
    private LocalDate toDate;

    @Column(name = "designation")
    private String designation;

    @Column(name = "job_location")
    private String jobLocation;

    @Column(name ="is_current_job")
    private Character isCurrentJob = 'N';

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    private RecruitmentUserEntity recruitmentUser;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public Integer getExpMonths() {
        return expMonths;
    }

    public void setExpMonths(Integer expMonths) {
        this.expMonths = expMonths;
    }

    public LocalDate getFromDate() {
        return fromDate;
    }

    public void setFromDate(LocalDate fromDate) {
        this.fromDate = fromDate;
    }

    public LocalDate getToDate() {
        return toDate;
    }

    public void setToDate(LocalDate toDate) {
        this.toDate = toDate;
    }

    public RecruitmentUserEntity getRecruitmentUser() {
        return recruitmentUser;
    }

    public void setRecruitmentUser(RecruitmentUserEntity recruitmentUser) {
        this.recruitmentUser = recruitmentUser;
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

    public Character getIsCurrentJob() {
        return isCurrentJob;
    }

    public void setIsCurrentJob(Character isCurrentJob) {
        this.isCurrentJob = isCurrentJob;
    }
}
