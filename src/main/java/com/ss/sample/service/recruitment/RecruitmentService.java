package com.ss.sample.service.recruitment;

import com.ss.sample.entity.UserEntity;
import com.ss.sample.entity.recruitment.RecruitmentRecruiterEntity;
import com.ss.sample.entity.recruitment.RecruitmentUserEntity;
import com.ss.sample.model.recruitment.JobSeekerDto;
import com.ss.sample.model.recruitment.RegisterDto;
import com.ss.sample.model.UserDto;
import com.ss.sample.repository.RoleRepository;
import com.ss.sample.repository.UserRepository;
import com.ss.sample.repository.recruitment.RecruitmentRecruiterRepository;
import com.ss.sample.repository.recruitment.RecruitmentUserRepository;
import com.ss.sample.util.Constants;
import com.ss.sample.util.UserConverter;
import com.ss.sample.util.Util;
import com.ss.sample.util.recruitment.JDoodleCompilerTest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.Objects;
import java.util.Optional;

@Service
@Slf4j
public class RecruitmentService {

    private RecruitmentHelperService recruitmentHelperService;
    private JDoodleCompilerTest jDoodleCompilerTest;
    private RecruitmentUserRepository recruitmentUserRepository;
    private RecruitmentRecruiterRepository recruitmentRecruiterRepository;
    private RoleRepository roleRepository;
    private UserRepository userRepository;

    public RecruitmentService(
            RecruitmentHelperService recruitmentHelperService,
            RecruitmentUserRepository recruitmentUserRepository,
            RecruitmentRecruiterRepository recruitmentRecruiterRepository,
            RoleRepository roleRepository,
            UserRepository userRepository,
            JDoodleCompilerTest jDoodleCompilerTest) {
        this.recruitmentHelperService = recruitmentHelperService;
        this.recruitmentUserRepository = recruitmentUserRepository;
        this.recruitmentRecruiterRepository = recruitmentRecruiterRepository;
        this.roleRepository = roleRepository;
        this.userRepository = userRepository;
        this.jDoodleCompilerTest = jDoodleCompilerTest;
    }


    public Optional<RegisterDto> getRecruiterByUserName() {
        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        Optional<String> roleOptional = Util.getAuthenticatedRole();

        if (roleOptional.isPresent()) {
            String roleString = roleOptional.get();
            Optional<RecruitmentRecruiterEntity> savedRecruitmentUser = recruitmentRecruiterRepository.findByUserId(userEntity.getUsername());

            if (savedRecruitmentUser.isPresent() && roleString.equals("ROLE_" + Constants.Roles.RECRUITER_ROLE.toUpperCase())) {
                RecruitmentRecruiterEntity recEntity = savedRecruitmentUser.get();
                return Optional.of(recruitmentHelperService.convertRecruiter(recEntity));
            }
            return Optional.empty();
        }
        return Optional.empty();
    }

    public Optional<JobSeekerDto> getDataByUserName() {
        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//            if (roleString.equals("ROLE_" + Constants.Roles.JOB_SEEKER_ROLE.toUpperCase())) {
        Optional<RecruitmentUserEntity> savedRecruitmentUser = recruitmentUserRepository.findByUserId(userEntity.getUsername());
        return savedRecruitmentUser.map(recruitmentHelperService::convert);
    }

    public Optional<RegisterDto> createUser(RegisterDto registerDto) {
        Long id;
        if (Objects.nonNull(registerDto.getIsRecruiter()) && registerDto.getIsRecruiter()) {
            id = recruitmentRecruiterRepository.getMaxId();
            String userId = Constants.StrConstants.RECRUITER + String.format("%06d", id);

            RecruitmentRecruiterEntity recruitmentEntity = RecruitmentRecruiterEntity.builder()
                    .id(id)
                    .userId(userId)
                    .firstName(registerDto.getFirstName())
                    .lastName(registerDto.getLastName())
                    .email(registerDto.getEmail())
                    .build();

            createUser(userId,
                    registerDto.getFirstName() + " " + registerDto.getLastName(),
                    registerDto.getEmail(),
                    registerDto.getPassword(),
                    Constants.Roles.RECRUITER_ROLE_ID,
                    id);

            RecruitmentRecruiterEntity savedRecruitmentUser = recruitmentRecruiterRepository.save(recruitmentEntity);

            return Optional.of(recruitmentHelperService.convertRecruiter(savedRecruitmentUser));

        } else {
            id = recruitmentUserRepository.getMaxId();
            String userId = Constants.StrConstants.JOB_SEEKER + String.format("%06d", id);

            RecruitmentUserEntity recruitmentEntity = new RecruitmentUserEntity();
            recruitmentEntity.setId(id);
            recruitmentEntity.setUserId(userId);
            recruitmentEntity.setFirstName(registerDto.getFirstName());
            recruitmentEntity.setLastName(registerDto.getLastName());
            recruitmentEntity.setEmail(registerDto.getEmail());

            createUser(userId,
                    registerDto.getFirstName() + " " + registerDto.getLastName(),
                    registerDto.getEmail(),
                    registerDto.getPassword(),
                    Constants.Roles.JOB_SEEKER_ROLE_ID,
                    id);

            RecruitmentUserEntity savedRecruitmentUser = recruitmentUserRepository.save(recruitmentEntity);
            return Optional.of(recruitmentHelperService.convert(savedRecruitmentUser));
        }
    }

    private void createUser(String userName, String userDesc, String email, String password, int roleId, long id) {
        UserDto userDto = new UserDto(
                userName,
                new BCryptPasswordEncoder().encode(password),
                false,
                userDesc,
                email,
                roleRepository.findByRoleId(roleId)
        );

        UserEntity savedUserEntity = userRepository.save(UserConverter.convert(userDto));

        if (userRepository.existsById(id)) {
            log.info("<RECRUITMENT:SAVE>"
                    + "<RECRUITMENT User : " + savedUserEntity.getUserDesc() + " created with username " + userName + ">");
        } else {
            log.info("<RECRUITMENT:SAVE>"
                    + "<RECRUITMENT User : " + savedUserEntity.getUserDesc() + " not created >");
        }
    }

    public Optional<RegisterDto> saveRecruiter(RegisterDto registerDto) {
        RecruitmentRecruiterEntity recruitmentRecruiterEntity = recruitmentHelperService.convertRecruiter(registerDto);
        RecruitmentRecruiterEntity savedRecruiter = recruitmentRecruiterRepository.save(recruitmentRecruiterEntity);

        Optional<UserEntity> userEntityOptional = userRepository.findByUsername(savedRecruiter.getUserId());

        // Update Email and First Name, Last Name
        if(userEntityOptional.isPresent()) {
            UserEntity userEntity = userEntityOptional.get();
            userEntity.setEmail(savedRecruiter.getEmail());
            userEntity.setUserDesc(savedRecruiter.getFirstName() + " " + savedRecruiter.getLastName());
            userRepository.save(userEntity);
        }
        return Optional.of(recruitmentHelperService.convertRecruiter(savedRecruiter));
    }

    public Optional<JobSeekerDto> saveProfile(JobSeekerDto jobSeekerDto) {
        RecruitmentUserEntity recruitmentUserEntity = recruitmentHelperService.convertJobSeeker(jobSeekerDto);
        RecruitmentUserEntity savedRecruitmentUser = recruitmentUserRepository.save(recruitmentUserEntity);

        Optional<UserEntity> userEntityOptional = userRepository.findByUsername(savedRecruitmentUser.getUserId());

        // Update Email and First Name, Last Name
        if(userEntityOptional.isPresent()) {
            UserEntity userEntity = userEntityOptional.get();
            userEntity.setEmail(savedRecruitmentUser.getEmail());
            userEntity.setUserDesc(savedRecruitmentUser.getFirstName() + " " + savedRecruitmentUser.getLastName());
            userRepository.save(userEntity);
        }
        return Optional.of(recruitmentHelperService.convert(savedRecruitmentUser));
    }

    public Optional<JobSeekerDto> updatePreferences(String type, long id) {
        UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Optional<RecruitmentUserEntity> existingEntityOptional = recruitmentUserRepository.findByUserId(userEntity.getUsername());

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
        }

        return Optional.empty();
    }

    public Map<Long,String> getAllSkillTypes() {
        return recruitmentHelperService.getAllSkillTypes();
    }

    public Map<Long,String> getAllSkills() {
        return recruitmentHelperService.getAllSkills();
    }

    public Optional<Map<Long,String>> getSkillsBySkillTypeId(long skillTypeId) {
        return recruitmentHelperService.getSkillsBySkillTypeId(skillTypeId);
    }

    public Optional<RegisterDto> findByType(String role, String type, String value) {
        return recruitmentHelperService.findByType(role, type, value);
    }

    // Old
    public Optional<JobSeekerDto> save(JobSeekerDto jobSeekerDto) {
        return recruitmentHelperService.save(jobSeekerDto);
    }

    // Old
    public Optional<JobSeekerDto> savePreferences(JobSeekerDto jobSeekerDto) {
        return recruitmentHelperService.savePreferences(jobSeekerDto);
    }


}
