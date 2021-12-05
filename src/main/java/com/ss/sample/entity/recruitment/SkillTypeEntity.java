package com.ss.sample.entity.recruitment;

import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name ="recruitment_skill_type")
@Data
public class SkillTypeEntity {

    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "skill_type")
    private String skillType;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "skillType")
    @Fetch(value = FetchMode.SUBSELECT)
    private List<SkillEntity> skills;
}
