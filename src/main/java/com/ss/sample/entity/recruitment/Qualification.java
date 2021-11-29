package com.ss.sample.entity.recruitment;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

//@Entity
@Table(name = "recruitment_qualifications")
public class Qualification {

    @Id
    @Column(name = "qualification_id")
    private long qualificationId;

    @Column(name = "qualification")
    private String qualification;
}
