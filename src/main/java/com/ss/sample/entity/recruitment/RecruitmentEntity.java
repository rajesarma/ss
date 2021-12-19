package com.ss.sample.entity.recruitment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import java.io.Serializable;
import java.time.LocalDateTime;

@MappedSuperclass
@AllArgsConstructor
@NoArgsConstructor
@Data
@SuperBuilder(toBuilder = true)
public class RecruitmentEntity implements Serializable {

    private static final long serialVersionUID = -1605994317636704342L;
    @Id
    @Column(name = "id")
    private Long id;

    @Column(name ="first_name")
    private String firstName;

    @Column(name ="last_name")
    private String lastName;

    @Column(name ="mobile")
    private String mobile;

    @Column(name ="email")
    private String email;

    @Column(name ="address")
    private String address;

    @Column(name ="postal_code")
    private String postalCode;

    @Column(name ="is_active")
    @Builder.Default
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

}