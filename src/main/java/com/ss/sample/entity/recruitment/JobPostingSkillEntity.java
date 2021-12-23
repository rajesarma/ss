package com.ss.sample.entity.recruitment;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder(toBuilder = true)
@Entity
@Table(name = "recruitment_job_post_skillset")
public class JobPostingSkillEntity implements Serializable {

    private static final long serialVersionUID = 8738703456498159331L;

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "post_job_skill_generator")
    @SequenceGenerator(name = "post_job_skill_generator", sequenceName = "recruitment_job_post_skillset_id_seq", allocationSize = 1)
    private Long id;

    @Column(name ="skill")
    private String skill;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "job_id", referencedColumnName = "job_id", nullable = false)
    private JobPostingEntity jobPosting;
}
