package com.ss.sample.entity.recruitment;

import javax.persistence.*;

//@Entity
@Table(name = "recruitment_district_master")
public class District {

    @Id
    @Column(name = "district_id")
    private long districtId;

    @Column(name = "districtName")
    private String districtName;

    @ManyToOne
    @JoinColumn(name = "state_id")
    private State state;
}
