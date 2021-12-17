package com.ss.sample.service.recruitment;

import com.ss.sample.entity.UserEntity;
import com.ss.sample.entity.recruitment.*;
import com.ss.sample.model.*;
import com.ss.sample.repository.RoleRepository;
import com.ss.sample.repository.UserRepository;
import com.ss.sample.repository.recruitment.RecruitmentRepository;
import com.ss.sample.repository.recruitment.SkillTypeRepository;
import com.ss.sample.util.Constants;
import com.ss.sample.util.UserConverter;
import com.ss.sample.util.recruitment.JDoodleCompilerTest;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

@Service
@Slf4j
public class RecruitmentService {

    private JDoodleCompilerTest jDoodleCompilerTest;
    private RecruitmentRepository recruitmentRepository;
    private RoleRepository roleRepository;
    private UserRepository userRepository;
    private SkillTypeRepository skillTypeRepository;

    public RecruitmentService(
            RecruitmentRepository recruitmentRepository,
            RoleRepository roleRepository,
            UserRepository userRepository,
            SkillTypeRepository skillTypeRepository,
            JDoodleCompilerTest jDoodleCompilerTest) {
        this.recruitmentRepository = recruitmentRepository;
        this.roleRepository = roleRepository;
        this.userRepository = userRepository;
        this.skillTypeRepository = skillTypeRepository;
        this.jDoodleCompilerTest = jDoodleCompilerTest;
    }

    public Map<Long,String> getAllSkillTypes() {
        return StreamSupport.stream(skillTypeRepository.findAll().spliterator(), false)
                .collect(Collectors.toMap(SkillTypeEntity::getSkillTypeId,
                        SkillTypeEntity::getSkillType));
    }

    public Map<Long,String> getAllSkills() {
        return StreamSupport.stream(skillTypeRepository.findAll().spliterator(), false)
                .map(SkillTypeEntity::getSkills)
                .collect(Collectors.toList())
                .stream()
                .flatMap(List::stream)
                .collect(Collectors.toList())
                .stream()
                .collect(Collectors.toMap(SkillEntity::getSkillId,
                        SkillEntity::getSkill));
    }

    public Optional<Map<Long,String>> getSkillsBySkillTypeId(long skillTypeId) {

        Optional<SkillTypeEntity> skillTypeEntityOptional = skillTypeRepository.findBySkillTypeId(skillTypeId);
        return skillTypeEntityOptional
                .map(skillTypeEntity -> skillTypeEntity
                .getSkills()
                .stream()
                .collect(Collectors.toMap(SkillEntity::getSkillId, SkillEntity::getSkill)));
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

            if( "jobSeekerSkills".equalsIgnoreCase(type)) {
                existingUserEntity.getUserSkills().removeIf(js ->  js.getId() == id);
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
//            updateUserSkills(jobSeekerDto, existingUserEntity);
            RecruitmentUserEntity savedEntity = recruitmentRepository.save(existingUserEntity);
            return Optional.of(convert(savedEntity));
        }

        return Optional.empty();
    }

    public Optional<JobSeekerDto> createUser(JobSeekerDto jobSeekerDto) {
        Long id = recruitmentRepository.getMaxId();
        String userId = Constants.StrConstants.APP_NAME + String.format("%06d", id);

        RecruitmentUserEntity recruitmentUserEntity = new RecruitmentUserEntity();
        recruitmentUserEntity.setId(id);
        recruitmentUserEntity.setUserId(userId);
        recruitmentUserEntity.setFirstName(jobSeekerDto.getFirstName());
        recruitmentUserEntity.setLastName(jobSeekerDto.getLastName());
        recruitmentUserEntity.setEmail(jobSeekerDto.getEmail());

        RecruitmentUserEntity savedRecruitmentUser = recruitmentRepository.save(recruitmentUserEntity);

        if(recruitmentRepository.existsById(savedRecruitmentUser.getId())) {
            UserDto userDto = new UserDto(
                    savedRecruitmentUser.getUserId(),
                    new BCryptPasswordEncoder().encode(jobSeekerDto.getPassword()),
                    false,
                    savedRecruitmentUser.getFirstName() + " " + savedRecruitmentUser.getLastName(),
                    savedRecruitmentUser.getEmail(),
                    roleRepository.findByRoleId(Constants.Roles.JOB_SEEKER_ROLE_ID)
            );

            UserEntity savedUserEntity = userRepository.save(UserConverter.convert(userDto));

            if(userRepository.existsById(savedRecruitmentUser.getId())) {
                log.info("<RECRUITMENT:SAVE>"
                        + "<RECRUITMENT User : " + savedRecruitmentUser.getFirstName() + " " + savedRecruitmentUser.getLastName() +" created with username " + savedRecruitmentUser.getUserId() + ">");
            } else {
                log.info("<RECRUITMENT:SAVE>"
                        + "<RECRUITMENT User : " + savedRecruitmentUser.getFirstName() + " " + savedRecruitmentUser.getLastName() +" not created >");
            }

            return Optional.of(convert(savedRecruitmentUser));
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
                    savedRecruitmentUser.getFirstName() + " " + savedRecruitmentUser.getLastName(),
                    savedRecruitmentUser.getEmail(),
                    roleRepository.findByRoleId(Constants.Roles.JOB_SEEKER_ROLE_ID)
            );

            UserEntity savedUserEntity = userRepository.save(UserConverter.convert(userDto));

            if(userRepository.existsById(savedRecruitmentUser.getId())) {
                log.info("<RECRUITMENT:SAVE>"
                        + "<RECRUITMENT User : " + savedRecruitmentUser.getFirstName() + " " + savedRecruitmentUser.getLastName() +" created with username " + savedRecruitmentUser.getUserId() + ">");
            } else {
                log.info("<RECRUITMENT:SAVE>"
                        + "<RECRUITMENT User : " + savedRecruitmentUser.getFirstName() + " " + savedRecruitmentUser.getLastName() +" not created >");
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

    private void updateUserSkills(JobSeekerDto jobSeekerDto, RecruitmentUserEntity recruitmentUserEntity) {
        if(Objects.nonNull(jobSeekerDto.getUserSkills()) &&  !jobSeekerDto.getUserSkills().isEmpty()) {

            // If Existing User Experiences are present, Update them
            if(Objects.nonNull(recruitmentUserEntity.getUserSkills()) &&  !recruitmentUserEntity.getUserSkills().isEmpty()) {
                List<Long> existingIds = new ArrayList<>();

                for (JobSeekerSkillDto js : jobSeekerDto.getUserSkills()) {
                    recruitmentUserEntity.getUserSkills()
                            .forEach(skill -> {
                                if (js.getId() == skill.getId()) {
                                    skill.setSkillLevel(js.getSkillLevel());
                                    skill.setExpMonths(js.getExpMonths());
                                    getSkillEntityFromId(js.getSkillId()).ifPresent(skill::setSkill);
                                    skill.setRecruitmentUser(recruitmentUserEntity);
                                    existingIds.add(js.getId());
                                }
                            });
                }
                jobSeekerDto.getUserSkills().removeIf(js -> existingIds.stream().anyMatch( eid -> js.getId() == eid));
            }

            List<RecruitmentUserSkillEntity> userSkills = jobSeekerDto.getUserSkills()
                    .stream()
                    .map(jobSeekerSkillDto -> {
                        RecruitmentUserSkillEntity skill = new RecruitmentUserSkillEntity();
                        skill.setSkillLevel(jobSeekerSkillDto.getSkillLevel());
                        skill.setExpMonths(jobSeekerSkillDto.getExpMonths());
                        getSkillEntityFromId(jobSeekerSkillDto.getSkillId()).ifPresent(skill::setSkill);
                        skill.setRecruitmentUser(recruitmentUserEntity);
                        return skill;
                    }).collect(Collectors.toList());

            // If records present, then add them to exisiting, else create new records
            if(Objects.nonNull(recruitmentUserEntity.getUserSkills())) {
                recruitmentUserEntity.getUserSkills().addAll(userSkills);
            } else {
                recruitmentUserEntity.setUserSkills(userSkills);
            }
        }
    }

    /**
     * Methid to convert from Dto to entity
     * @param jobSeekerDto
     * @return RecruitmentUserEntity
     */
    public RecruitmentUserEntity convert(final JobSeekerDto jobSeekerDto) {
        Long id;
        String userId;

        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Optional<RecruitmentUserEntity> savedRecruitmentUserOptional = recruitmentRepository.findByUserId(userEntity.getUsername());

        if (savedRecruitmentUserOptional.isPresent()) {
            id = savedRecruitmentUserOptional.get().getId();
            userId = savedRecruitmentUserOptional.get().getUserId();
        } else {
            id = recruitmentRepository.getMaxId();
            userId = Constants.StrConstants.APP_NAME + String.format("%06d", id);
        }

        RecruitmentUserEntity recruitmentUserEntity = new RecruitmentUserEntity();
        recruitmentUserEntity.setId(id);
        recruitmentUserEntity.setUserId(userId);
        recruitmentUserEntity.setFirstName(jobSeekerDto.getFirstName());
        recruitmentUserEntity.setLastName(jobSeekerDto.getLastName());
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
        updateUserSkills(jobSeekerDto, recruitmentUserEntity);

        return recruitmentUserEntity;
    }

    /**
     * Methid to convert from Entity to Dto
     * @param recruitmentUserEntity
     * @return JobSeekerDto
     */
    public JobSeekerDto convert(final RecruitmentUserEntity recruitmentUserEntity) {
        JobSeekerDto jobSeekerDto = new JobSeekerDto();

        jobSeekerDto.setId(recruitmentUserEntity.getId());
        jobSeekerDto.setUserId(recruitmentUserEntity.getUserId());
        jobSeekerDto.setFirstName(recruitmentUserEntity.getFirstName());
        jobSeekerDto.setLastName(recruitmentUserEntity.getLastName());
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

        if(Objects.nonNull(recruitmentUserEntity.getUserSkills()) &&  !recruitmentUserEntity.getUserSkills().isEmpty()) {
            List<JobSeekerSkillDto> userSkills = recruitmentUserEntity.getUserSkills()
                    .stream()
                    .map(skillEntity -> {
                        JobSeekerSkillDto skill = new JobSeekerSkillDto();
                        skill.setId(skillEntity.getId());
                        skill.setSkillLevel(skillEntity.getSkillLevel());
                        skill.setExpMonths(skillEntity.getExpMonths());
                        Optional<SkillEntity> skillEntityOptional = getSkillEntityFromId(skillEntity.getSkill().getSkillId());
                        skillEntityOptional.ifPresent(s -> skill.setSkillId(s.getSkillId()));
                        skillEntityOptional.ifPresent(s -> skill.setSkillTypeId(s.getSkillType().getSkillTypeId()));
                        return skill;
                    }).collect(Collectors.toList());
            jobSeekerDto.setUserSkills(userSkills);
        }

        return jobSeekerDto;
    }

    public Optional<JobSeekerDto> saveProfile(JobSeekerDto jobSeekerDto) {
        RecruitmentUserEntity recruitmentUserEntity = convert(jobSeekerDto);
        RecruitmentUserEntity savedRecruitmentUser = recruitmentRepository.save(recruitmentUserEntity);

        Optional<UserEntity> userEntityOptional = userRepository.findByUsername(savedRecruitmentUser.getUserId());

        // Update Email and First Name, Last Name
        if(userEntityOptional.isPresent()) {
            UserEntity userEntity = userEntityOptional.get();
            userEntity.setEmail(savedRecruitmentUser.getEmail());
            userEntity.setUserDesc(savedRecruitmentUser.getFirstName() + " " + savedRecruitmentUser.getLastName());
            userRepository.save(userEntity);
        }
        return Optional.of(convert(savedRecruitmentUser));
    }

    private Optional<SkillEntity> getSkillEntityFromId(long skillId) {
        return StreamSupport.stream(skillTypeRepository.findAll().spliterator(), false)
                .map(SkillTypeEntity::getSkills)
                .collect(Collectors.toList())
                .stream()
                .flatMap(List::stream)
                .collect(Collectors.toList())
                .stream()
                .filter(skill -> skill.getSkillId() == skillId)
                .findAny();
//                .orElseThrow(new IllegalArgumentException("Role should be passed"));

    }
}
