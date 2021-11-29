package com.ss.sample.entity.recruitment;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

//@Entity
@Table(name = "recruitment_designation_mst")
public class Designation {

    @Id
    @Column(name = "designation_id")
    private long designationId;

    @Column(name = "designation_name")
    private String designationName;
}
