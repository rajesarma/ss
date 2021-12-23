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
@Table(name = "recruitment_job_post_roles")
public class JobPostingRoleEntity implements Serializable {

    private static final long serialVersionUID = -7013517988963614288L;

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "post_job_role_generator")
    @SequenceGenerator(name = "post_job_role_generator", sequenceName = "recruitment_job_post_roles_id_seq", allocationSize = 1)
    private Long id;

    @Column(name ="role_responsibility")
    private String roleResponsibility;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "job_id", referencedColumnName = "job_id", nullable = false)
    private JobPostingEntity jobPosting;
}
