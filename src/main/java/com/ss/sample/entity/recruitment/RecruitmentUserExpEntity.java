package com.ss.sample.entity.recruitment;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;

@Entity
@Table(name = "recruitment_user_experiences")
@Data
public class RecruitmentUserExpEntity implements Serializable {

    private static final long serialVersionUID = -1030806438316186436L;

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
}
