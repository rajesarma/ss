package com.ss.sample.entity.recruitment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.*;

import javax.persistence.*;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder(toBuilder = true)
@Entity
@Table(name = "recruitment_users_jobs")
public class RecruitmentUserJobEntity implements Serializable {

    private static final long serialVersionUID = 8923945593411984806L;

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_job_generator")
    @SequenceGenerator(name = "user_job_generator", sequenceName = "recruitment_users_jobs_id_seq", allocationSize = 1)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    private RecruitmentUserEntity recruitmentUser;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "job_id", referencedColumnName = "job_id", nullable = false)
    private JobPostingEntity jobPosting;

    @Column(name ="applied_date")
    @CreationTimestamp
    private LocalDate appliedDate;

    @Column(name ="applied_flag")
    @ColumnDefault("true")
    @Builder.Default
    private Boolean appliedFlag = true;
}