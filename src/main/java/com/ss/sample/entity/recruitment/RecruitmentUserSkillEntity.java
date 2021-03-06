package com.ss.sample.entity.recruitment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "recruitment_user_skills")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder(toBuilder = true)
public class RecruitmentUserSkillEntity implements Serializable {

    private static final long serialVersionUID = 8988800270453052642L;

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_skill_generator")
    @SequenceGenerator(name = "user_skill_generator", sequenceName = "recruitment_user_skills_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "exp_months")
    private Integer expMonths;

    @Column(name = "skill_level")
    private Integer skillLevel;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    private RecruitmentUserEntity recruitmentUser;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "skill_id", referencedColumnName = "skill_id", nullable = false)
    private SkillEntity skill;
}
