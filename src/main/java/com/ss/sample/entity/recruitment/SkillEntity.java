package com.ss.sample.entity.recruitment;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name ="recruitment_skill")
@Data
public class SkillEntity implements Serializable {

    private static final long serialVersionUID = -7695321928663878424L;

    @Id
    @Column(name = "skill_id")
    private Long skillId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "skill_type_id", referencedColumnName = "skill_type_id", nullable = false)
    private SkillTypeEntity skillType;

    @Column(name = "skill")
    private String skill;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "skill")
    private List<RecruitmentUserSkillEntity> userSkills = new ArrayList<>();
}
