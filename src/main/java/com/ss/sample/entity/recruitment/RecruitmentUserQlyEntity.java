package com.ss.sample.entity.recruitment;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;

@Entity
@Table(name = "recruitment_user_qualifications")
@Data
public class RecruitmentUserQlyEntity implements Serializable {

    private static final long serialVersionUID = -2703999005416483065L;

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_qly_generator")
    @SequenceGenerator(name = "user_qly_generator", sequenceName = "recruitment_user_qualifications_id_seq", allocationSize = 1)
    private Long id;

    @Column(name = "qualification")
    private String qualification;

    @Column(name = "percentage")
    private Double percentage;

    @Column(name = "board_university")
    private String boardUniversity;

    @Column(name = "specialization")
    private String specialization;

    @Column(name = "institute_name")
    private String instituteName;

    @Column(name = "start_date")
    private LocalDate startDate;

    @Column(name = "completion_date")
    private LocalDate completionDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    private RecruitmentUserEntity recruitmentUser;
}
