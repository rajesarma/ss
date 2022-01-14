package com.ss.sample.entity.recruitment;

import com.ss.sample.model.Gender;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Data
@SuperBuilder
@Entity
@Table(name = "recruitment_user")
@AllArgsConstructor
@NoArgsConstructor
@ToString
@DynamicUpdate
@EqualsAndHashCode(callSuper=false)
public class RecruitmentUserEntity extends RecruitmentEntity implements Serializable {

    private static final long serialVersionUID = 7859616847528882991L;

    @Column(name = "user_id")
//    @GeneratedValue(strategy=GenerationType.AUTO)
    /*@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "recruitment_user_id_seq")
    @GenericGenerator(
            name = "recruitment_user_id_seq",
            strategy = "com.ss.sample.util.StringPrefixedSequenceIdGenerator",
            parameters = {
                    @org.hibernate.annotations.Parameter(name = StringPrefixedSequenceIdGenerator.INCREMENT_PARAM, value = "50"),
                    @org.hibernate.annotations.Parameter(name = StringPrefixedSequenceIdGenerator.VALUE_PREFIX_PARAMETER, value = "SAMPLE_"),
                    @org.hibernate.annotations.Parameter(name = StringPrefixedSequenceIdGenerator.NUMBER_FORMAT_PARAMETER, value = "%06d") })*/

    private String userId;

    @Column(name ="father_name")
    private String fatherName;

    @Column(name ="gender")
    @Builder.Default
    private Character gender = Gender.MALE.getGender();

    @Column(name ="alternate_no")
    private String alternateNo;

    @Column(name ="aadhar")
    private String aadhar;

    @Column(name ="dob")
    private LocalDate dob;

    @Column(name ="photo")
    @Lob
    @Type(type="org.hibernate.type.BinaryType")
    private byte[] photo;

    @Column(name = "photo_name")
    @Builder.Default
    private String photoName=null;

    @Column(name ="resume")
    @Lob
    @Type(type="org.hibernate.type.BinaryType")
    private byte[] resume;

    @Column(name = "resume_name")
    @Builder.Default
    private String resumeName=null;

    @Column(name ="marital_status")
    private String maritalStatus;

    @Column(name ="stage")
    private Integer stage;

    @Column(name ="sms_notification_active")
    @Builder.Default
    private Character smsNotificationActive = 'A';  // TODO Requirement Pending for this

    @Column(name ="email_notification_active")
    @Builder.Default
    private Character emailNotificationActive = 'A'; // TODO Requirement Pending for this

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "recruitmentUser")
    @Fetch(value = FetchMode.SUBSELECT)
    private List<RecruitmentUserExpEntity> userExperiences;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "recruitmentUser")
    @Fetch(value = FetchMode.SUBSELECT)
    private List<RecruitmentUserQlyEntity> userQualifications;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "recruitmentUser")
    @Fetch(value = FetchMode.SUBSELECT)
    private List<RecruitmentUserSkillEntity> userSkills;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "recruitmentUser")
    @Fetch(value = FetchMode.SUBSELECT)
    private List<RecruitmentUserJobEntity> userJobs;
}