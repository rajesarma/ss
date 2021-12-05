package com.ss.sample.model;

import lombok.Data;

@Data
public class JobSeekerSkillDto {
    private long id;
    private int skillTypeId;
    private int skillId;
    private int skillLevel;
    private int expMonths;
}
