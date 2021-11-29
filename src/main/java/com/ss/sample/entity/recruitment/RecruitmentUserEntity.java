package com.ss.sample.entity.recruitment;

import com.ss.sample.model.Gender;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "recruitment_user")
public class RecruitmentUserEntity {

    @Id
    @Column(name = "id")
    private long id;

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

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getFatherName() {
        return fatherName;
    }

    public void setFatherName(String fatherName) {
        this.fatherName = fatherName;
    }

    public char getIsActive() {
        return isActive;
    }

    public void setIsActive(char isActive) {
        this.isActive = isActive;
    }

    public Character getGender() {
        return gender;
    }

    public void setGender(Character gender) {
        this.gender = gender;
    }

    public void setIsActive(Character isActive) {
        this.isActive = isActive;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAlternateNo() {
        return alternateNo;
    }

    public void setAlternateNo(String alternateNo) {
        this.alternateNo = alternateNo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAadhar() {
        return aadhar;
    }

    public void setAadhar(String aadhar) {
        this.aadhar = aadhar;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public byte[] getPhoto() {
        return photo;
    }

    public void setPhoto(byte[] photo) {
        this.photo = photo;
    }

    public String getPhotoName() {
        return photoName;
    }

    public void setPhotoName(String photoName) {
        this.photoName = photoName;
    }

    public byte[] getResume() {
        return resume;
    }

    public void setResume(byte[] resume) {
        this.resume = resume;
    }

    public String getResumeName() {
        return resumeName;
    }

    public void setResumeName(String resumeName) {
        this.resumeName = resumeName;
    }

    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public LocalDateTime getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(LocalDateTime createdOn) {
        this.createdOn = createdOn;
    }

    public LocalDateTime getUpdatedOn() {
        return updatedOn;
    }

    public void setUpdatedOn(LocalDateTime updatedOn) {
        this.updatedOn = updatedOn;
    }

    public LocalDateTime getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(LocalDateTime lastLogin) {
        this.lastLogin = lastLogin;
    }
}