package com.ss.sample.service.recruitment;

import com.ss.sample.entity.UserEntity;
import com.ss.sample.entity.recruitment.RecruitmentUserEntity;
import com.ss.sample.model.Gender;
import com.ss.sample.model.JobSeekerDto;
import com.ss.sample.model.UserDto;
import com.ss.sample.repository.RoleRepository;
import com.ss.sample.repository.UserRepository;
import com.ss.sample.repository.recruitment.RecruitmentRepository;
import com.ss.sample.util.Constants;
import com.ss.sample.util.UserConverter;
import com.ss.sample.util.recruitment.JDoodleCompilerTest;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.time.Clock;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Optional;

@Service
@Slf4j
public class RecruitmentService {

    private JDoodleCompilerTest jDoodleCompilerTest;
    private RecruitmentRepository recruitmentRepository;
    private RoleRepository roleRepository;
    private UserRepository userRepository;

    public RecruitmentService(
            RecruitmentRepository recruitmentRepository,
            RoleRepository roleRepository,
            UserRepository userRepository,
            JDoodleCompilerTest jDoodleCompilerTest) {
        this.recruitmentRepository = recruitmentRepository;
        this.roleRepository = roleRepository;
        this.userRepository = userRepository;
        this.jDoodleCompilerTest = jDoodleCompilerTest;
    }

    public Optional<JobSeekerDto> getDataByUserName() {

        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        Optional<RecruitmentUserEntity> savedRecruitmentUser = recruitmentRepository.findByUserId(userEntity.getUsername());
        if(savedRecruitmentUser.isPresent()) {
            return Optional.of(convert(savedRecruitmentUser.get()));
        }
        return Optional.empty();
    }

    public Optional<JobSeekerDto> save(JobSeekerDto jobSeekerDto) {

        RecruitmentUserEntity recruitmentUserEntity = convert(jobSeekerDto);
        RecruitmentUserEntity savedRecruitmentUser = recruitmentRepository.save(recruitmentUserEntity);

        if(recruitmentRepository.existsById(savedRecruitmentUser.getId())) {
            UserDto userDto = new UserDto(
                    savedRecruitmentUser.getUserId(),
                    new BCryptPasswordEncoder().encode(jobSeekerDto.getPassword()),
                    false,
                    savedRecruitmentUser.getFullName() ,
                    savedRecruitmentUser.getEmail(),
                    roleRepository.findByRoleId(Constants.Roles.JOB_SEEKER_ROLE_ID)
            );

            UserEntity savedUserEntity = userRepository.save(UserConverter.convert(userDto));

            if(userRepository.existsById(savedRecruitmentUser.getId())) {
                log.info("<RECRUITMENT:SAVE>"
                        + "<RECRUITMENT User : " + savedRecruitmentUser.getFullName() +" created with username " + savedRecruitmentUser.getUserId() + ">");
            } else {
                log.info("<RECRUITMENT:SAVE>"
                        + "<RECRUITMENT User : " + savedRecruitmentUser.getFullName() +" not created >");
            }

            return Optional.of(convert(savedRecruitmentUser));
        }

        return Optional.empty();
    }

    public Optional<JobSeekerDto> findByType(String type, String value) {

        Optional<RecruitmentUserEntity> recruitmentUserEntityOptional;

        switch(type) {
            case Constants.StrConstants.AADHAR : {
                recruitmentUserEntityOptional = recruitmentRepository.findFirstByAadhar(value);
                break;
            }

            case Constants.StrConstants.MOBILE : {
                recruitmentUserEntityOptional = recruitmentRepository.findFirstByMobile(value);
                break;
            }

            case Constants.StrConstants.EMAIL : {
                recruitmentUserEntityOptional = recruitmentRepository.findFirstByEmail(value);
                break;
            }

            default : {
                recruitmentUserEntityOptional = Optional.empty();
                break;
            }
        }

        if(recruitmentUserEntityOptional.isPresent()) {
            return Optional.of(convert(recruitmentUserEntityOptional.get()));
        }

        return Optional.empty();
    }

    public RecruitmentUserEntity convert(final JobSeekerDto jobSeekerDto) {
        RecruitmentUserEntity recruitmentUserEntity = new RecruitmentUserEntity();

        Long id = recruitmentRepository.getMaxId();
        String userId = Constants.StrConstants.APP_NAME + String.format("%06d", id);

        recruitmentUserEntity.setId(id);
        recruitmentUserEntity.setUserId(userId);
        recruitmentUserEntity.setFullName(jobSeekerDto.getFullName());
        recruitmentUserEntity.setFatherName(jobSeekerDto.getFatherName());
        recruitmentUserEntity.setGender(jobSeekerDto.getGender().getGender());
        recruitmentUserEntity.setMobile(jobSeekerDto.getMobile());
        recruitmentUserEntity.setAlternateNo(jobSeekerDto.getAlternateNo());
        recruitmentUserEntity.setEmail(jobSeekerDto.getEmail());
        recruitmentUserEntity.setAadhar(jobSeekerDto.getAadhar());
        recruitmentUserEntity.setAddress(jobSeekerDto.getAddress());
        recruitmentUserEntity.setDob(jobSeekerDto.getDob());
        recruitmentUserEntity.setMaritalStatus(jobSeekerDto.getMaritalStatus());

        try {
            if(jobSeekerDto.getPhoto() != null && jobSeekerDto.getPhoto().getBytes().length > 0) {
                recruitmentUserEntity.setPhoto(jobSeekerDto.getPhoto().getBytes());
                recruitmentUserEntity.setPhotoName(jobSeekerDto.getPhoto().getOriginalFilename());

            } else if(StringUtils.isNotEmpty(jobSeekerDto.getPhotoData())) {
                recruitmentUserEntity.setPhoto(java.util.Base64.getDecoder().decode(jobSeekerDto.getPhotoData()));
            }

            if(jobSeekerDto.getResume() != null && jobSeekerDto.getResume().getBytes().length > 0) {
                recruitmentUserEntity.setResume(jobSeekerDto.getResume().getBytes());
                recruitmentUserEntity.setResumeName(jobSeekerDto.getResume().getOriginalFilename());

            } else if(StringUtils.isNotEmpty(jobSeekerDto.getResumeData())) {
                recruitmentUserEntity.setResume(java.util.Base64.getDecoder().decode(jobSeekerDto.getResumeData()));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return recruitmentUserEntity;
    }

    public JobSeekerDto convert(final RecruitmentUserEntity recruitmentUserEntity) {
        JobSeekerDto jobSeekerDto = new JobSeekerDto();

//        jobSeekerDto.setIsActive('A');
        jobSeekerDto.setId(recruitmentUserEntity.getId());
        jobSeekerDto.setUserId(recruitmentUserEntity.getUserId());
        jobSeekerDto.setFullName(recruitmentUserEntity.getFullName());
        jobSeekerDto.setFatherName(recruitmentUserEntity.getFatherName());
        jobSeekerDto.setGender(Gender.getType(recruitmentUserEntity.getGender()));
        jobSeekerDto.setMobile(recruitmentUserEntity.getMobile());
        jobSeekerDto.setAlternateNo(recruitmentUserEntity.getAlternateNo());
        jobSeekerDto.setEmail(recruitmentUserEntity.getEmail());
        jobSeekerDto.setAadhar(recruitmentUserEntity.getAadhar());
        jobSeekerDto.setAddress(recruitmentUserEntity.getAddress());
        jobSeekerDto.setDob(recruitmentUserEntity.getDob());
        jobSeekerDto.setMaritalStatus(recruitmentUserEntity.getMaritalStatus());

        if (recruitmentUserEntity.getPhoto() != null && recruitmentUserEntity.getPhoto().length > 0) {
            jobSeekerDto.setPhotoData(new String(java.util.Base64.getEncoder().encode(recruitmentUserEntity.getPhoto())));
            jobSeekerDto.setPhotoName(recruitmentUserEntity.getPhotoName());
        }

        if (recruitmentUserEntity.getResume() != null && recruitmentUserEntity.getResume().length > 0) {
            jobSeekerDto.setResumeData(new String(java.util.Base64.getEncoder().encode(recruitmentUserEntity.getResume())));
            jobSeekerDto.setResumeName(recruitmentUserEntity.getResumeName());
        }

        return jobSeekerDto;
    }
}
