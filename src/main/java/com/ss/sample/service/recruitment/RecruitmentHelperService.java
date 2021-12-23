package com.ss.sample.service.recruitment;

import com.ss.sample.entity.UserEntity;
import com.ss.sample.entity.recruitment.*;
import com.ss.sample.model.*;
import com.ss.sample.model.recruitment.*;
import com.ss.sample.repository.RoleRepository;
import com.ss.sample.repository.UserRepository;
import com.ss.sample.repository.recruitment.RecruitmentRecruiterRepository;
import com.ss.sample.repository.recruitment.RecruitmentUserRepository;
import com.ss.sample.repository.recruitment.SkillTypeRepository;
import com.ss.sample.util.Constants;
import com.ss.sample.util.UserConverter;
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
import java.util.stream.StreamSupport;

@Service
@Slf4j
public class RecruitmentHelperService {

    private RecruitmentUserRepository recruitmentUserRepository;
    private RecruitmentRecruiterRepository recruitmentRecruiterRepository;
    private RoleRepository roleRepository;
    private UserRepository userRepository;
    private SkillTypeRepository skillTypeRepository;

    public RecruitmentHelperService(
            RecruitmentUserRepository recruitmentUserRepository,
            RecruitmentRecruiterRepository recruitmentRecruiterRepository,
            RoleRepository roleRepository,
            UserRepository userRepository,
            SkillTypeRepository skillTypeRepository) {
        this.recruitmentUserRepository = recruitmentUserRepository;
        this.recruitmentRecruiterRepository = recruitmentRecruiterRepository;
        this.roleRepository = roleRepository;
        this.userRepository = userRepository;
        this.skillTypeRepository = skillTypeRepository;
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

    RegisterDto convertRecruiter(RecruitmentRecruiterEntity recEntity) {
        RegisterDto dto = new RegisterDto();

        dto.setId(recEntity.getId());
        dto.setUserId(recEntity.getUserId());
        dto.setFirstName(recEntity.getFirstName());
        dto.setLastName(recEntity.getLastName());
        dto.setCompanyName(recEntity.getCompanyName());
        dto.setMobile(recEntity.getMobile());
        dto.setEmail(recEntity.getEmail());
        dto.setAddress(recEntity.getAddress());
        dto.setPostalCode(recEntity.getPostalCode());
        return dto;
    }

    RecruitmentRecruiterEntity convertRecruiter(RegisterDto dto) {
        RecruitmentRecruiterEntity recEntity = new RecruitmentRecruiterEntity();

        Long id;
        String userId;

        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Optional<RecruitmentRecruiterEntity> savedRecruitmentUserOptional = recruitmentRecruiterRepository.findByUserId(userEntity.getUsername());

        if (savedRecruitmentUserOptional.isPresent()) {
            id = savedRecruitmentUserOptional.get().getId();
            userId = savedRecruitmentUserOptional.get().getUserId();
        } else {
            id = recruitmentRecruiterRepository.getMaxId();
            userId = Constants.StrConstants.RECRUITER + String.format("%06d", id);
        }

        recEntity.setId(id);
        recEntity.setUserId(userId);
        recEntity.setFirstName(dto.getFirstName());
        recEntity.setLastName(dto.getLastName());
        recEntity.setCompanyName(dto.getCompanyName());
        recEntity.setMobile(dto.getMobile());
        recEntity.setEmail(dto.getEmail());
        recEntity.setAddress(dto.getAddress());
        recEntity.setPostalCode(dto.getPostalCode());
        return recEntity;
    }

    public Optional<RegisterDto> findByType(String role, String type, String value) {

        switch(type) {
            case Constants.StrConstants.AADHAR : {
                return recruitmentUserRepository.findFirstByAadhar(value).map(this::convert);
            }

            case Constants.StrConstants.MOBILE : {
                if (Constants.Roles.JOB_SEEKER_ROLE.equals(role)) {
                    return recruitmentUserRepository.findFirstByMobile(value).map(this::convert);
                } else if (Constants.Roles.RECRUITER_ROLE.equals(role)) {
                    return recruitmentRecruiterRepository.findFirstByMobile(value).map(this::convertRecruiter);
                }
            }

            case Constants.StrConstants.EMAIL : {
                if (Constants.Roles.JOB_SEEKER_ROLE.equals(role)) {
                    return recruitmentUserRepository.findFirstByEmail(value).map(this::convert);
                } else if (Constants.Roles.RECRUITER_ROLE.equals(role)) {
                    return recruitmentRecruiterRepository.findFirstByEmail(value).map(this::convertRecruiter);
                }
            }

            default : {
                return Optional.empty();
            }
        }
    }

    void updateUserExperiences(JobSeekerDto jobSeekerDto, RecruitmentUserEntity recruitmentUserEntity) {
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
                    .filter(this::jobSeekerExpDtoValidation)
                    .map(jobSeekerExpDto -> {
                        RecruitmentUserExpEntity exp = new RecruitmentUserExpEntity();
                        exp.setCompany(jobSeekerExpDto.getCompany());
                        exp.setExpMonths(jobSeekerExpDto.getExpMonths());
                        exp.setFromDate(LocalDate.parse(jobSeekerExpDto.getFromDate(), formatter));
                        exp.setToDate(LocalDate.parse(jobSeekerExpDto.getToDate(), formatter));
                        exp.setDesignation(jobSeekerExpDto.getDesignation());
                        exp.setJobLocation(jobSeekerExpDto.getJobLocation());
                        exp.setIsCurrentJob(jobSeekerExpDto.getIsCurrentJob() != null && jobSeekerExpDto.getIsCurrentJob() ? 'Y' : 'N');
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

    void updateUserQualifications(JobSeekerDto jobSeekerDto, RecruitmentUserEntity recruitmentUserEntity) {
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
                    .filter(this::jobSeekerQlyDtoValidation)
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

    private boolean jobSeekerExpDtoValidation(JobSeekerExpDto jobSeekerExpDto) {
        return StringUtils.isNotEmpty(jobSeekerExpDto.getCompany()) &&
                Objects.nonNull(jobSeekerExpDto.getExpMonths()) &&
                StringUtils.isNotEmpty(jobSeekerExpDto.getFromDate()) &&
                StringUtils.isNotEmpty(jobSeekerExpDto.getToDate()) &&
                StringUtils.isNotEmpty(jobSeekerExpDto.getDesignation()) &&
                StringUtils.isNotEmpty(jobSeekerExpDto.getJobLocation());
    }

    private boolean jobSeekerQlyDtoValidation(JobSeekerQlyDto jobSeekerQlyDto) {
        return StringUtils.isNotEmpty(jobSeekerQlyDto.getQualification()) &&
                Objects.nonNull(jobSeekerQlyDto.getSpecialization()) &&
                StringUtils.isNotEmpty(jobSeekerQlyDto.getInstituteName()) &&
                StringUtils.isNotEmpty(jobSeekerQlyDto.getBoardUniversity()) &&
                Objects.nonNull(jobSeekerQlyDto.getPercentage()) &&
                StringUtils.isNotEmpty(jobSeekerQlyDto.getStartDate()) &&
                StringUtils.isNotEmpty(jobSeekerQlyDto.getCompletionDate());
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
                    .filter(this::jobSeekerQlyDtoValidation)
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

    private boolean jobSeekerQlyDtoValidation(JobSeekerSkillDto jobSeekerSkillDto) {
        return Objects.nonNull(jobSeekerSkillDto.getSkillLevel()) &&
                Objects.nonNull(jobSeekerSkillDto.getExpMonths()) &&
                Objects.nonNull(jobSeekerSkillDto.getSkillId());
    }

    /**
     * Method to convert from Dto to entity
     * @param jobSeekerDto Job Seeker Dto
     * @return RecruitmentUserEntity
     */
    public RecruitmentUserEntity convertJobSeeker(final JobSeekerDto jobSeekerDto) {
        Long id;
        String userId;

        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Optional<RecruitmentUserEntity> savedRecruitmentUserOptional = recruitmentUserRepository.findByUserId(userEntity.getUsername());

        if (savedRecruitmentUserOptional.isPresent()) {
            id = savedRecruitmentUserOptional.get().getId();
            userId = savedRecruitmentUserOptional.get().getUserId();
        } else {
            id = recruitmentUserRepository.getMaxId();
            userId = Constants.StrConstants.JOB_SEEKER + String.format("%06d", id);
        }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
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
        recruitmentUserEntity.setDob(LocalDate.parse(jobSeekerDto.getDob(), formatter));
        recruitmentUserEntity.setMaritalStatus(jobSeekerDto.getMaritalStatus());

        try {
            if(jobSeekerDto.getPhoto() != null && jobSeekerDto.getPhoto().getBytes().length > 0) {
                recruitmentUserEntity.setPhoto(jobSeekerDto.getPhoto().getBytes());
                recruitmentUserEntity.setPhotoName(jobSeekerDto.getPhoto().getOriginalFilename());

            } else if(StringUtils.isNotEmpty(jobSeekerDto.getPhotoData())) {
                recruitmentUserEntity.setPhoto(Base64.getDecoder().decode(jobSeekerDto.getPhotoData()));
            }

            if(jobSeekerDto.getResume() != null && jobSeekerDto.getResume().getBytes().length > 0) {
                recruitmentUserEntity.setResume(jobSeekerDto.getResume().getBytes());
                recruitmentUserEntity.setResumeName(jobSeekerDto.getResume().getOriginalFilename());

            } else if(StringUtils.isNotEmpty(jobSeekerDto.getResumeData())) {
                recruitmentUserEntity.setResume(Base64.getDecoder().decode(jobSeekerDto.getResumeData()));
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
     * Method to convert from Entity to Dto
     * @param recruitmentUserEntity Recruitment User Entity
     * @return JobSeekerDto
     */
    public JobSeekerDto convert(final RecruitmentUserEntity recruitmentUserEntity) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
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
        jobSeekerDto.setDob(Objects.nonNull(recruitmentUserEntity.getDob()) ? recruitmentUserEntity.getDob().format(formatter) : null);
        jobSeekerDto.setMaritalStatus(recruitmentUserEntity.getMaritalStatus());

        if (recruitmentUserEntity.getPhoto() != null && recruitmentUserEntity.getPhoto().length > 0) {
            jobSeekerDto.setPhotoData(new String(Base64.getEncoder().encode(recruitmentUserEntity.getPhoto())));
            jobSeekerDto.setPhotoName(recruitmentUserEntity.getPhotoName());
        }

        if (recruitmentUserEntity.getResume() != null && recruitmentUserEntity.getResume().length > 0) {
            jobSeekerDto.setResumeData(new String(Base64.getEncoder().encode(recruitmentUserEntity.getResume())));
            jobSeekerDto.setResumeName(recruitmentUserEntity.getResumeName());
        }

        if(Objects.nonNull(recruitmentUserEntity.getUserExperiences()) &&  !recruitmentUserEntity.getUserExperiences().isEmpty()) {
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

    Optional<SkillEntity> getSkillEntityFromId(long skillId) {
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

    // Old
    public Optional<JobSeekerDto> savePreferences(JobSeekerDto jobSeekerDto) {

        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Optional<RecruitmentUserEntity> existingEntityOptional = recruitmentUserRepository.findByUserId(userEntity.getUsername());

        if (existingEntityOptional.isPresent()) {
            RecruitmentUserEntity existingUserEntity = existingEntityOptional.get();
            updateUserExperiences(jobSeekerDto, existingUserEntity);
            updateUserQualifications(jobSeekerDto, existingUserEntity);
//            updateUserSkills(jobSeekerDto, existingUserEntity);
            RecruitmentUserEntity savedEntity = recruitmentUserRepository.save(existingUserEntity);
            return Optional.of(convert(savedEntity));
        }

        return Optional.empty();
    }

    // Old
    public Optional<JobSeekerDto> save(JobSeekerDto jobSeekerDto) {

        RecruitmentUserEntity recruitmentUserEntity = convertJobSeeker(jobSeekerDto);
        RecruitmentUserEntity savedRecruitmentUser = recruitmentUserRepository.save(recruitmentUserEntity);

        if(recruitmentUserRepository.existsById(savedRecruitmentUser.getId())) {
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
}
