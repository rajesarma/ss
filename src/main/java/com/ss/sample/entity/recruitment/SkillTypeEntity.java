package com.ss.sample.entity.recruitment;

import lombok.Data;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name ="recruitment_skill_type")
@Data
public class SkillTypeEntity implements Serializable {

    private static final long serialVersionUID = 6437714214012462078L;

    @Id
    @Column(name = "id")
    private Long id;

    @Column(name = "skill_type")
    private String skillType;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "skillType")
    @Fetch(value = FetchMode.SUBSELECT)
    private List<SkillEntity> skills;
}
