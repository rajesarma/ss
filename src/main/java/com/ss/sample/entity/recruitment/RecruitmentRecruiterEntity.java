package com.ss.sample.entity.recruitment;

import lombok.*;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;

@Data
@SuperBuilder
@Entity
@Table(name = "recruitment_recruiter")
@AllArgsConstructor
@NoArgsConstructor
@ToString
@DynamicUpdate
@EqualsAndHashCode(callSuper=false)
public class RecruitmentRecruiterEntity extends RecruitmentEntity implements Serializable {
    private static final long serialVersionUID = 7859616847528882991L;

    @Column(name = "user_id")
    private String userId;

    @Column(name ="company_name")
    private String companyName;
}