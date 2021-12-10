package com.ss.sample.service.recruitment;

import com.ss.sample.entity.UserEntity;
import com.ss.sample.entity.recruitment.RecruitmentUserEntity;
import com.ss.sample.entity.recruitment.RecruitmentUserExpEntity;
import com.ss.sample.entity.recruitment.RecruitmentUserQlyEntity;
import com.ss.sample.model.*;
import com.ss.sample.repository.RoleRepository;
import com.ss.sample.repository.UserRepository;
import com.ss.sample.repository.recruitment.RecruitmentRepository;
import com.ss.sample.util.Constants;
import com.ss.sample.util.UserConverter;
import com.ss.sample.util.recruitment.JDoodleCompilerTest;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.time.Clock;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

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

    public Optional<JobSeekerDto> updatePreferences(String type, long id) {

        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Optional<RecruitmentUserEntity> existingEntityOptional = recruitmentRepository.findByUserId(userEntity.getUsername());

        if (existingEntityOptional.isPresent()) {
            RecruitmentUserEntity existingUserEntity = existingEntityOptional.get();

            if( "jobSeekerQualifications".equalsIgnoreCase(type)) {
                existingUserEntity.getUserQualifications().removeIf(js ->  js.getId() == id);
            }

            if( "jobSeekerExperiences".equalsIgnoreCase(type)) {
                existingUserEntity.getUserExperiences().removeIf(js ->  js.getId() == id);
            }

            RecruitmentUserEntity savedEntity = recruitmentRepository.save(existingUserEntity);
            return Optional.of(convert(savedEntity));
        }

        return Optional.empty();
    }

    public Optional<JobSeekerDto> savePreferences(JobSeekerDto jobSeekerDto) {

        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Optional<RecruitmentUserEntity> existingEntityOptional = recruitmentRepository.findByUserId(userEntity.getUsername());

        if (existingEntityOptional.isPresent()) {
            RecruitmentUserEntity existingUserEntity = existingEntityOptional.get();
            updateUserExperiences(jobSeekerDto, existingUserEntity);
            updateUserQualifications(jobSeekerDto, existingUserEntity);
            RecruitmentUserEntity savedEntity = recruitmentRepository.save(existingUserEntity);
            return Optional.of(convert(savedEntity));
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

    private void updateUserExperiences(JobSeekerDto jobSeekerDto, RecruitmentUserEntity recruitmentUserEntity) {
        if(Objects.nonNull(jobSeekerDto.getUserExperiences()) &&  !jobSeekerDto.getUserExperiences().isEmpty()) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

            // If Existing User Experiences are present, Update them
            if(Objects.nonNull(recruitmentUserEntity.getUserExperiences()) &&  !recruitmentUserEntity.getUserExperiences().isEmpty()) {
                List<Long> existingIds = new ArrayList<>();

                for (JobSeekerExpDto js : jobSeekerDto.getUserExperiences()) {
                    recruitmentUserEntity.getUserExperiences()
                            .forEach(exp -> {
                                if (js.getId() == exp.getId()) {
                                    exp.setCompany(js.getCompany());
                                    exp.setExpMonths(js.getExpMonths());
                                    exp.setFromDate(LocalDate.parse(js.getFromDate(), formatter));
                                    exp.setToDate(LocalDate.parse(js.getToDate(), formatter));
                                    exp.setDesignation(js.getDesignation());
                                    exp.setJobLocation(js.getJobLocation());
                                    exp.setIsCurrentJob(js.getIsCurrentJob() ? 'Y' : 'N');
                                    exp.setRecruitmentUser(recruitmentUserEntity);
                                    existingIds.add(js.getId());
                                }
                            });
                }
                jobSeekerDto.getUserExperiences().removeIf(js -> existingIds.stream().anyMatch( eid -> js.getId() == eid));
            }

            List<RecruitmentUserExpEntity> userExps = jobSeekerDto.getUserExperiences()
                    .stream()
                    .map(jobSeekerExpDto -> {
                        RecruitmentUserExpEntity exp = new RecruitmentUserExpEntity();
                        exp.setCompany(jobSeekerExpDto.getCompany());
                        exp.setExpMonths(jobSeekerExpDto.getExpMonths());
                        exp.setFromDate(LocalDate.parse(jobSeekerExpDto.getFromDate(), formatter));
                        exp.setToDate(LocalDate.parse(jobSeekerExpDto.getToDate(), formatter));
                        exp.setDesignation(jobSeekerExpDto.getDesignation());
                        exp.setJobLocation(jobSeekerExpDto.getJobLocation());
                        exp.setIsCurrentJob(jobSeekerExpDto.getIsCurrentJob() ? 'Y' : 'N');
                        exp.setRecruitmentUser(recruitmentUserEntity);
                        return exp;
                    }).collect(Collectors.toList());

            // If records present, then add them to exisiting, else create new records
            if(Objects.nonNull(recruitmentUserEntity.getUserExperiences())) {
                recruitmentUserEntity.getUserExperiences().addAll(userExps);
            } else {
                recruitmentUserEntity.setUserExperiences(userExps);
            }
        }
    }

    private void updateUserQualifications(JobSeekerDto jobSeekerDto, RecruitmentUserEntity recruitmentUserEntity) {
        if(Objects.nonNull(jobSeekerDto.getUserQualifications()) &&  !jobSeekerDto.getUserQualifications().isEmpty()) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            // If Existing User Qualifications are present, Update them
            if(Objects.nonNull(recruitmentUserEntity.getUserQualifications()) &&  !recruitmentUserEntity.getUserQualifications().isEmpty()) {
                List<Long> existingIds = new ArrayList<>();

                for (JobSeekerQlyDto jobSeekerQlyDto : jobSeekerDto.getUserQualifications()) {
                    recruitmentUserEntity.getUserQualifications()
                            .forEach(qly -> {
                                if (jobSeekerQlyDto.getId() == qly.getId()) {
                                    qly.setQualification(jobSeekerQlyDto.getQualification());
                                    qly.setSpecialization(jobSeekerQlyDto.getSpecialization());
                                    qly.setInstituteName(jobSeekerQlyDto.getInstituteName());
                                    qly.setBoardUniversity(jobSeekerQlyDto.getBoardUniversity());
                                    qly.setPercentage(jobSeekerQlyDto.getPercentage());
                                    qly.setStartDate(StringUtils.isNotEmpty(jobSeekerQlyDto.getStartDate()) ? LocalDate.parse(jobSeekerQlyDto.getStartDate(), formatter) : null);
                                    qly.setCompletionDate(StringUtils.isNotEmpty(jobSeekerQlyDto.getCompletionDate()) ? LocalDate.parse(jobSeekerQlyDto.getCompletionDate(), formatter) : null);
                                    qly.setRecruitmentUser(recruitmentUserEntity);
                                    existingIds.add(jobSeekerQlyDto.getId());
                                }
                            });
                }
                jobSeekerDto.getUserQualifications().removeIf(js -> existingIds.stream().anyMatch( eid -> js.getId() == eid));
            }

            List<RecruitmentUserQlyEntity> userQlys = jobSeekerDto.getUserQualifications()
                    .stream()
                    .map(jobSeekerQlyDto -> {
                        RecruitmentUserQlyEntity qly = new RecruitmentUserQlyEntity();
                        qly.setQualification(jobSeekerQlyDto.getQualification());
                        qly.setSpecialization(jobSeekerQlyDto.getSpecialization());
                        qly.setInstituteName(jobSeekerQlyDto.getInstituteName());
                        qly.setBoardUniversity(jobSeekerQlyDto.getBoardUniversity());
                        qly.setPercentage(jobSeekerQlyDto.getPercentage());
                        qly.setStartDate(StringUtils.isNotEmpty(jobSeekerQlyDto.getStartDate()) ? LocalDate.parse(jobSeekerQlyDto.getStartDate(), formatter) : null);
                        qly.setCompletionDate(StringUtils.isNotEmpty(jobSeekerQlyDto.getCompletionDate()) ? LocalDate.parse(jobSeekerQlyDto.getCompletionDate(), formatter) : null);
                        qly.setRecruitmentUser(recruitmentUserEntity);
                        return qly;
                    }).collect(Collectors.toList());

            // If records present, then add them to exisiting, else create new records
            if(Objects.nonNull(recruitmentUserEntity.getUserQualifications())) {
                recruitmentUserEntity.getUserQualifications().addAll(userQlys);
            } else {
                recruitmentUserEntity.setUserQualifications(userQlys);
            }
        }
    }


    public RecruitmentUserEntity convert(final JobSeekerDto jobSeekerDto) {
        Long id = recruitmentRepository.getMaxId();
        String userId = Constants.StrConstants.APP_NAME + String.format("%06d", id);

        /*
        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Optional<RecruitmentUserEntity> savedRecruitmentUserOptional = recruitmentRepository.findByUserId(userEntity.getUsername());

        if (savedRecruitmentUserOptional.isPresent()) {
            id = savedRecruitmentUserOptional.get().getId();
            userId = savedRecruitmentUserOptional.get().getUserId();
        } else {
            id = recruitmentRepository.getMaxId();
            userId = Constants.StrConstants.APP_NAME + String.format("%06d", id);
        }*/

        RecruitmentUserEntity recruitmentUserEntity = new RecruitmentUserEntity();
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
        recruitmentUserEntity.setPostalCode(jobSeekerDto.getPostalCode());
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

        updateUserExperiences(jobSeekerDto, recruitmentUserEntity);
        updateUserQualifications(jobSeekerDto, recruitmentUserEntity);

        return recruitmentUserEntity;
    }

    public JobSeekerDto convert(final RecruitmentUserEntity recruitmentUserEntity) {
        JobSeekerDto jobSeekerDto = new JobSeekerDto();

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
        jobSeekerDto.setPostalCode(recruitmentUserEntity.getPostalCode());
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

        if(Objects.nonNull(recruitmentUserEntity.getUserExperiences()) &&  !recruitmentUserEntity.getUserExperiences().isEmpty()) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            List<JobSeekerExpDto> userExps = recruitmentUserEntity.getUserExperiences()
                    .stream()
                    .map(expEntity -> {
                        JobSeekerExpDto exp = new JobSeekerExpDto();
                        exp.setId(expEntity.getId());
                        exp.setCompany(expEntity.getCompany());
                        exp.setExpMonths(expEntity.getExpMonths());
                        exp.setFromDate(Objects.nonNull(expEntity.getFromDate()) ? expEntity.getFromDate().format(formatter) : null);
                        exp.setToDate(Objects.nonNull(expEntity.getToDate()) ? expEntity.getToDate().format(formatter) : null);
                        exp.setDesignation(expEntity.getDesignation());
                        exp.setJobLocation(expEntity.getJobLocation());
                        exp.setIsCurrentJob(Objects.nonNull(expEntity.getIsCurrentJob()) && 'Y' == expEntity.getIsCurrentJob());
                        return exp;
                    }).collect(Collectors.toList());
            jobSeekerDto.setUserExperiences(userExps);
        }

        if(Objects.nonNull(recruitmentUserEntity.getUserQualifications()) &&  !recruitmentUserEntity.getUserQualifications().isEmpty()) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            List<JobSeekerQlyDto> userQlys = recruitmentUserEntity.getUserQualifications()
                    .stream()
                    .map(qlyEntity -> {
                        JobSeekerQlyDto qly = new JobSeekerQlyDto();
                        qly.setId(qlyEntity.getId());
                        qly.setQualification(qlyEntity.getQualification());
                        qly.setSpecialization(qlyEntity.getSpecialization());
                        qly.setInstituteName(qlyEntity.getInstituteName());
                        qly.setBoardUniversity(qlyEntity.getBoardUniversity());
                        qly.setPercentage(qlyEntity.getPercentage());
                        qly.setStartDate(Objects.nonNull(qlyEntity.getStartDate()) ? qlyEntity.getStartDate().format(formatter) : null);
                        qly.setCompletionDate(Objects.nonNull(qlyEntity.getCompletionDate()) ? qlyEntity.getCompletionDate().format(formatter) : null);
                        return qly;
                    }).collect(Collectors.toList());
            jobSeekerDto.setUserQualifications(userQlys);
        }
        return jobSeekerDto;
    }
}
