package com.ss.sample.entity.recruitment;

import lombok.Data;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name ="recruitment_skill")
@Data
public class SkillEntity {

    @Id
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "skill_type_id", referencedColumnName = "id", nullable = false)
    private SkillTypeEntity skillType;

    @Column(name = "skill")
    private String skill;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "skill")
    private List<RecruitmentUserSkillEntity> userSkills = new ArrayList<>();
}
