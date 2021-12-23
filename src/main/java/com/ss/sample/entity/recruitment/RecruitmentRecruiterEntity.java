package com.ss.sample.entity.recruitment;

import lombok.*;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Data
@SuperBuilder
@Entity
@Table(name = "recruitment_recruiter")
@AllArgsConstructor
@NoArgsConstructor
@ToString
@DynamicUpdate
@EqualsAndHashCode(callSuper=false)
public class RecruitmentRecruiterEntity extends RecruitmentEntity implements Serializable {
    private static final long serialVersionUID = 7859616847528882991L;

    @Column(name = "user_id")
    private String userId;

    @Column(name ="company_name")
    private String companyName;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "recruiter")
    @Fetch(value = FetchMode.SUBSELECT)
    private List<JobPostingEntity> jobPostings;
}