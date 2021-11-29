package com.ss.sample.entity.recruitment;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

//@Entity
@Table(name = "recruitment_experience_level")
public class ExperienceLevel {

    @Id
    @Column(name = "exp_id")
    private long expId;

    @Column(name = "experience")
    private String experience;
}
