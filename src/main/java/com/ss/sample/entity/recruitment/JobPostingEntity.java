package com.ss.sample.entity.recruitment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import javax.persistence.CascadeType;
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
@Table(name = "recruitment_job_post_master")
public class JobPostingEntity implements Serializable {

    private static final long serialVersionUID = 8923945593411984806L;

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "post_job_generator")
    @SequenceGenerator(name = "post_job_generator", sequenceName = "recruitment_job_post_master_id_seq", allocationSize = 1)
    private Long id;

    @Column(name ="job_id")
    private String jobId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    private RecruitmentRecruiterEntity recruiter;

    @Column(name ="experience_level")
    private Integer experience;

    @Column(name ="location")
    private String location;

    @Column(name ="title")
    private String title;

    @Column(name ="description")
    private String description;

    @Column(name ="last_date_to_apply")
    private LocalDate lastDateToApply;

    @Column(name ="mail_to")
    private String mailTo;

    @Column(name ="company")
    private String company;

    @Column(name ="qualifications")
    private String qualifications;

    @Column(name ="other_details")
    private String otherDetails;

    @Column(name ="salary")
    private Double salary;

    @Column(name ="created_on")
    @CreationTimestamp
    private LocalDateTime createdOn;

    @Column(name ="updated_on")
    @UpdateTimestamp
    private LocalDateTime updatedOn;

    @Column(name ="is_active")
    @Builder.Default
    private Character isActive = 'A';

    @Column(name ="deactivated_on")
    private LocalDateTime deactivatedOn;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "jobPosting")
    @Fetch(value = FetchMode.SUBSELECT)
    private List<JobPostingRoleEntity> jobPostingRoles;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "jobPosting")
    @Fetch(value = FetchMode.SUBSELECT)
    private List<JobPostingSkillEntity> jobPostingSkills;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "jobPosting")
    @Fetch(value = FetchMode.SUBSELECT)
    private List<RecruitmentUserJobEntity> jobAppliedUsers;
}