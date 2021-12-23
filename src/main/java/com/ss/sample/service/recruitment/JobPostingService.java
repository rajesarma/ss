package com.ss.sample.service.recruitment;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ss.sample.entity.UserEntity;
import com.ss.sample.entity.recruitment.*;
import com.ss.sample.model.recruitment.JobPostingDto;
import com.ss.sample.model.recruitment.JobPostingRoleDto;
import com.ss.sample.model.recruitment.JobPostingSkillDto;
import com.ss.sample.model.recruitment.JobSeekerExpDto;
import com.ss.sample.repository.recruitment.JobPostingRepository;
import com.ss.sample.repository.recruitment.RecruitmentRecruiterRepository;
import com.ss.sample.util.Constants;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
public class JobPostingService {

    private JobPostingRepository jobPostingRepository;
    private RecruitmentRecruiterRepository recruitmentRecruiterRepository;

    public JobPostingService(JobPostingRepository jobPostingRepository,
                             RecruitmentRecruiterRepository recruitmentRecruiterRepository) {
        this.jobPostingRepository = jobPostingRepository;
        this.recruitmentRecruiterRepository = recruitmentRecruiterRepository;
    }

    public Optional<JobPostingDto> getByPostId(String postId) {

        Optional<JobPostingEntity> postingEntityOptional = jobPostingRepository.findByJobId(postId);
        return postingEntityOptional.map(this::convert);
    }

    public List<JobPostingDto> getJobPostings() {
        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Optional<RecruitmentRecruiterEntity> recruitmentUserOptional = recruitmentRecruiterRepository.findByUserId(userEntity.getUsername());

        List<JobPostingEntity> jobPostings = jobPostingRepository.findAllByUserId(userEntity.getUsername());

        List<JobPostingDto> jobPostingDtos = jobPostings
                .stream()
                .map(this::convert)
                .collect(Collectors.toList());

        jobPostingDtos.forEach(jobPostingDto -> recruitmentUserOptional.ifPresent(e -> jobPostingDto.setCompany(e.getCompanyName()))); // Set Company Name for each Job Posting

        return jobPostingDtos;
    }

    public Optional<JobPostingDto> saveJob(JobPostingDto jobPostingDto) {

        if (StringUtils.isNotEmpty(jobPostingDto.getJobId())) {
            return updateJob(jobPostingDto);
        }

        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Optional<RecruitmentRecruiterEntity> savedRecruitmentUser = recruitmentRecruiterRepository.findByUserId(userEntity.getUsername());
        JobPostingEntity jobPostingEntity = convert(jobPostingDto);

        Long id = jobPostingRepository.getMaxId();
        String jobId = Constants.StrConstants.APP_NAME_SHORT + String.format("%06d", id);
        jobPostingEntity.setId(id);
        jobPostingEntity.setJobId(jobId);
        savedRecruitmentUser.ifPresent(jobPostingEntity::setRecruiter);
        JobPostingEntity jobPosting = jobPostingRepository.save(jobPostingEntity);

        return Optional.of(convert(jobPosting));
    }

    public Optional<JobPostingDto> updateJob(JobPostingDto jobPostingDto) {

        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Optional<RecruitmentRecruiterEntity> savedRecruitmentUser = recruitmentRecruiterRepository.findByUserId(userEntity.getUsername());

        Optional<JobPostingEntity> existingEntityOptional = jobPostingRepository.findByJobId(jobPostingDto.getJobId());

        List<Long> existingRoleIds = jobPostingDto.getJobPostingRoles()
                .stream()
                .filter(jpr -> jpr.getDeleteFlag() != null && jpr.getDeleteFlag())
                .map(JobPostingRoleDto::getId)
                .collect(Collectors.toList());

        // Remove from Role DTOs
        jobPostingDto.getJobPostingRoles().removeIf(js -> existingRoleIds.stream().anyMatch( eid -> js.getId() == eid));

        List<Long> existingSkillIds = jobPostingDto.getJobPostingSkills()
                .stream()
                .filter(jps -> jps.getDeleteFlag() != null && jps.getDeleteFlag())
                .map(JobPostingSkillDto::getId)
                .collect(Collectors.toList());

        // Remove from Skill DTOs
        jobPostingDto.getJobPostingSkills().removeIf(js -> existingSkillIds.stream().anyMatch( eid -> js.getId() == eid));

        if (existingEntityOptional.isPresent()) {
            JobPostingEntity jobPostingEntity = existingEntityOptional.get();

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            jobPostingEntity.setId(jobPostingDto.getId());
            jobPostingEntity.setExperience(jobPostingDto.getExperience());
            jobPostingEntity.setTitle(jobPostingDto.getTitle());
            jobPostingEntity.setLocation(jobPostingDto.getLocation());
            jobPostingEntity.setDescription(jobPostingDto.getDescription());
            jobPostingEntity.setLastDateToApply(LocalDate.parse(jobPostingDto.getLastDateToApply(), formatter));
            jobPostingEntity.setMailTo(jobPostingDto.getMailTo());
            jobPostingEntity.setQualifications(jobPostingDto.getQualifications());
            jobPostingEntity.setOtherDetails(jobPostingDto.getOtherDetails());
            jobPostingEntity.setSalary(jobPostingDto.getSalary());

            // Remove Role records
            jobPostingEntity.getJobPostingRoles().removeIf(js -> existingRoleIds.stream().anyMatch( eid -> js.getId() == eid));

            // Update existing Role records
            if (Objects.nonNull(jobPostingEntity.getJobPostingRoles()) &&  !jobPostingEntity.getJobPostingRoles().isEmpty()) {
                for (JobPostingRoleDto jpr : jobPostingDto.getJobPostingRoles()) {
                    jobPostingEntity.getJobPostingRoles()
                            .forEach(jpRoleEntity -> {
                                if (jpr.getId() == jpRoleEntity.getId()) {
                                    jpRoleEntity.setRoleResponsibility(jpr.getRoleResponsibility());
                                    jpRoleEntity.setJobPosting(jobPostingEntity);
                                }
                            });
                }
            }

            // Add newly added Roles
            List<JobPostingRoleDto> newRoleDtos = jobPostingDto.getJobPostingRoles()
                    .stream()
                    .filter(jps -> jps.getId() == null || jps.getId() == 0)
                    .collect(Collectors.toList());

            if (!newRoleDtos.isEmpty()) {
                List<JobPostingRoleEntity> jobPostingRoles = newRoleDtos
                        .stream()
                        .map(s -> JobPostingRoleEntity.builder()
                                .roleResponsibility(s.getRoleResponsibility())
                                .jobPosting(jobPostingEntity)
                                .build()
                        ).collect(Collectors.toList());

                if(Objects.nonNull(jobPostingEntity.getJobPostingRoles())) {
                    jobPostingEntity.getJobPostingRoles().addAll(jobPostingRoles);
                } else {
                    jobPostingEntity.setJobPostingRoles(jobPostingRoles);
                }
            }

            // Remove Skill records
            jobPostingEntity.getJobPostingSkills().removeIf(js -> existingSkillIds.stream().anyMatch( eid -> js.getId() == eid));

            // Update existing Skill records
            if (Objects.nonNull(jobPostingEntity.getJobPostingSkills()) &&  !jobPostingEntity.getJobPostingSkills().isEmpty()) {
                for (JobPostingSkillDto jps : jobPostingDto.getJobPostingSkills()) {
                    jobPostingEntity.getJobPostingSkills()
                            .forEach(jpSkillEntity -> {
                                if (jps.getId() == jpSkillEntity.getId()) {
                                    jpSkillEntity.setSkill(jps.getSkill());
                                    jpSkillEntity.setJobPosting(jobPostingEntity);
                                }
                            });
                }
            }

            // Add newly added Skills
            List<JobPostingSkillDto> newSkillDtos = jobPostingDto.getJobPostingSkills()
                    .stream()
                    .filter(jps -> jps.getId() == null || jps.getId() == 0)
                    .collect(Collectors.toList());

            if (!newSkillDtos.isEmpty()) {
                List<JobPostingSkillEntity> jobPostingSkills = newSkillDtos
                        .stream()
                        .map(s -> JobPostingSkillEntity.builder()
                                .skill(s.getSkill())
                                .jobPosting(jobPostingEntity)
                                .build()
                        ).collect(Collectors.toList());

                if(Objects.nonNull(jobPostingEntity.getJobPostingSkills())) {
                    jobPostingEntity.getJobPostingSkills().addAll(jobPostingSkills);
                } else {
                    jobPostingEntity.setJobPostingSkills(jobPostingSkills);
                }
            }




            JobPostingEntity savedJobPostingEntity = jobPostingRepository.save(jobPostingEntity);
            return Optional.of(convert(savedJobPostingEntity));
        }

        return Optional.empty();
    }

    public Optional<JobPostingDto> updatePreferences(String type, long id) {
        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        /*Optional<JobPostingEntity> existingEntityOptional = jobPostingRepository.findByJobId(userEntity.getUsername());

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

            RecruitmentUserEntity savedEntity = recruitmentUserRepository.save(existingUserEntity);
            return Optional.of(recruitmentHelperService.convert(savedEntity));
        }*/

        return Optional.empty();
    }


    public JobPostingDto convert(JobPostingEntity jobPostingEntity) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        JobPostingDto jobPostingDto = JobPostingDto.builder()
                .id(jobPostingEntity.getId())
                .experience(jobPostingEntity.getExperience())
                .title(jobPostingEntity.getTitle())
                .jobId(jobPostingEntity.getJobId())
                .location(jobPostingEntity.getLocation())
                .description(jobPostingEntity.getDescription())
                .lastDateToApply(Objects.nonNull(jobPostingEntity.getLastDateToApply()) ? jobPostingEntity.getLastDateToApply().format(formatter) : null)
                .mailTo(jobPostingEntity.getMailTo())
                .qualifications(jobPostingEntity.getQualifications())
                .otherDetails(jobPostingEntity.getOtherDetails())
                .salary(jobPostingEntity.getSalary())
                .postedOn(Objects.nonNull(jobPostingEntity.getCreatedOn()) ? jobPostingEntity.getCreatedOn().toLocalDate().format(formatter) : null) // Only Date
                .build();

        if (Objects.nonNull(jobPostingEntity.getJobPostingRoles()) && !jobPostingEntity.getJobPostingRoles().isEmpty()) {
            List<JobPostingRoleDto> jobPostingRoles = jobPostingEntity.getJobPostingRoles()
                    .stream()
                    .map(r -> JobPostingRoleDto.builder()
                            .id(r.getId())
                            .roleResponsibility(r.getRoleResponsibility())
                            .build()
                    ).collect(Collectors.toList());

            jobPostingDto.setJobPostingRoles(jobPostingRoles);
        }

        if (Objects.nonNull(jobPostingEntity.getJobPostingSkills()) && !jobPostingEntity.getJobPostingSkills().isEmpty()) {
            List<JobPostingSkillDto> jobPostingSkills = jobPostingEntity.getJobPostingSkills()
                    .stream()
                    .map(s -> JobPostingSkillDto.builder()
                            .id(s.getId())
                            .skill(s.getSkill())
                            .build()
                    ).collect(Collectors.toList());

            jobPostingDto.setJobPostingSkills(jobPostingSkills);
        }

        return jobPostingDto;
    }

    private JobPostingEntity convert(JobPostingDto jobPostingDto) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        JobPostingEntity jobPostingEntity = JobPostingEntity.builder()
                .id(jobPostingDto.getId())
                .experience(jobPostingDto.getExperience())
                .title(jobPostingDto.getTitle())
                .location(jobPostingDto.getLocation())
                .description(jobPostingDto.getDescription())
                .lastDateToApply(LocalDate.parse(jobPostingDto.getLastDateToApply(), formatter))
                .mailTo(jobPostingDto.getMailTo())
                .qualifications(jobPostingDto.getQualifications())
                .otherDetails(jobPostingDto.getOtherDetails())
                .salary(jobPostingDto.getSalary())
                .build();

        if (Objects.nonNull(jobPostingDto.getJobPostingRoles()) && !jobPostingDto.getJobPostingRoles().isEmpty()) {
            List<JobPostingRoleEntity> jobPostingRoles = jobPostingDto.getJobPostingRoles()
                    .stream()
                    .map(r -> JobPostingRoleEntity.builder()
                            .roleResponsibility(r.getRoleResponsibility())
                            .jobPosting(jobPostingEntity)
                            .build()
                    ).collect(Collectors.toList());

            jobPostingEntity.setJobPostingRoles(jobPostingRoles);
        }

        if (Objects.nonNull(jobPostingDto.getJobPostingSkills()) && !jobPostingDto.getJobPostingSkills().isEmpty()) {
            List<JobPostingSkillEntity> jobPostingSkills = jobPostingDto.getJobPostingSkills()
                    .stream()
                    .map(s -> JobPostingSkillEntity.builder()
                            .skill(s.getSkill())
                            .jobPosting(jobPostingEntity)
                            .build()
                    ).collect(Collectors.toList());

            jobPostingEntity.setJobPostingSkills(jobPostingSkills);
        }

        return jobPostingEntity;
    }

}
