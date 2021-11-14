package com.ss.sample.entity.recruitment;

import javax.persistence.*;

//@Entity
@Table(name = "recruitment_state_master")
public class State {

    @Id
    @Column(name = "state_id")
    private long stateId;

    @Column(name = "state_name")
    private String stateName;
}
