package com.ss.sample.entity.recruitment;

import com.ss.sample.model.Gender;
import lombok.Data;
import org.hibernate.annotations.*;

import javax.persistence.*;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "recruitment_user")
@Data
public class RecruitmentUserEntity implements Serializable {

    private static final long serialVersionUID = -466027596676587395L;

    @Id
    @Column(name = "id")
    private Long id;

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

    @Column(name ="full_name")
    private String fullName;

    @Column(name ="father_name")
    private String fatherName;

    @Column(name ="gender")
    private Character gender = Gender.MALE.getGender();

    @Column(name ="mobile")
    private String mobile;

    @Column(name ="alternate_no")
    private String alternateNo;

    @Column(name ="email")
    private String email;

    @Column(name ="aadhar")
    private String aadhar;

    @Column(name ="address")
    private String address;

    @Column(name ="postal_code")
    private String postalCode;

    @Column(name ="dob")
    private LocalDate dob;

    @Column(name ="photo")
    @Lob
    @Type(type="org.hibernate.type.BinaryType")
    private byte[] photo;

    @Column(name = "photo_name")
    private String photoName=null;

    @Column(name ="resume")
    @Lob
    @Type(type="org.hibernate.type.BinaryType")
    private byte[] resume;

    @Column(name = "resume_name")
    private String resumeName=null;

    @Column(name ="marital_status")
    private String maritalStatus;

    @Column(name ="is_active")
    private Character isActive = 'A';

    @Column(name ="created_on")
    @CreationTimestamp
    private LocalDateTime createdOn;

    @Column(name ="updated_on")
    @UpdateTimestamp
    private LocalDateTime updatedOn;

    @Column(name ="last_login")
    @UpdateTimestamp
    private LocalDateTime lastLogin;

    @Column(name ="sms_notification_active")
    private Character smsNotificationActive = 'A';  // TODO Requirement Pending for this

    @Column(name ="email_notification_active")
    private Character emailNotificationActive = 'A'; // TODO Requirement Pending for this

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "recruitmentUser")
    @Fetch(value = FetchMode.SUBSELECT)
    private List<RecruitmentUserExpEntity> userExperiences;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "recruitmentUser")
    @Fetch(value = FetchMode.SUBSELECT)
    private List<RecruitmentUserQlyEntity> userQualifications;

    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true, mappedBy = "recruitmentUser")
    private List<RecruitmentUserSkillEntity> userSkills = new ArrayList<>();
}