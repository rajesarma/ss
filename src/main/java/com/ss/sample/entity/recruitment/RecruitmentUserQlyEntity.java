package com.ss.sample.entity.recruitment;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "recruitment_user_qualifications")
public class RecruitmentUserQlyEntity implements Serializable {

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

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    private RecruitmentUserEntity recruitmentUser;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public Double getPercentage() {
        return percentage;
    }

    public void setPercentage(Double percentage) {
        this.percentage = percentage;
    }

    public String getBoardUniversity() {
        return boardUniversity;
    }

    public void setBoardUniversity(String boardUniversity) {
        this.boardUniversity = boardUniversity;
    }

    public RecruitmentUserEntity getRecruitmentUser() {
        return recruitmentUser;
    }

    public void setRecruitmentUser(RecruitmentUserEntity recruitmentUser) {
        this.recruitmentUser = recruitmentUser;
    }
}
