package com.ss.sample.controller.recruitment;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ss.sample.entity.recruitment.JobPostingEntity;
import com.ss.sample.model.recruitment.*;
import com.ss.sample.service.recruitment.JobPostingService;
import com.ss.sample.service.recruitment.RecruitmentService;
import com.ss.sample.util.Constants;
import com.ss.sample.util.Util;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.validation.Valid;
import java.util.*;

@Controller
@RequestMapping(value="/recruitment")
@Slf4j
public class RecruitmentController {

    @Value("${save}")
    private String save;

    private String jobSeekerDtoStr = "jobSeekerDto";
    private String buttonValue = "buttonValue";
    private String action = "action";
    private String method = "method";

    private RecruitmentService recruitmentService;
    private JobPostingService jobPostingService;

    public RecruitmentController(RecruitmentService recruitmentService,
                                 JobPostingService jobPostingService) {
        this.recruitmentService = recruitmentService;
        this.jobPostingService = jobPostingService;
    }

    @RequestMapping(value = "/compiler", method = RequestMethod.GET)
    public String compiler(ModelMap model) {
        return "compiler";
    }

    ////////////////////////JOB Seeker///////////////

    @GetMapping("/profile")
    public ModelAndView getJobSeekerProfile(
//            @RequestParam(required = false) String operation
    ) {
        /*if (Util.isSpecifiedRole(Constants.Roles.RECRUITER_ROLE.toUpperCase())) {
            getRecruiterProfile();
        }*/

        JobSeekerDto jobSeekerDto = new JobSeekerDto();
        ModelAndView mav = new ModelAndView("profile", jobSeekerDtoStr, jobSeekerDto);

        // If Authenticated User
        if (Util.isAuthenticatedUser()) {
            Optional<JobSeekerDto> jobSeekerDtoOptional = recruitmentService.getDataByUserName();

            if(jobSeekerDtoOptional.isPresent()) {
                mav = new ModelAndView("profile", jobSeekerDtoStr, jobSeekerDtoOptional.get());
                mav.addObject(action,"/recruitment/profile");
            } else {
                recruitmentService.addMinRecords(jobSeekerDto);
                mav.addObject("message", "Problem in Fetching Data");
            }
        } else {
            return new ModelAndView("home");
        }
        getData(mav);
        return mav;
    }

    @PostMapping("/profile")
    public ModelAndView saveJobSeekerProfile(@Valid @ModelAttribute("jobSeekerDto") JobSeekerDto jobSeekerDto,
                                    BindingResult result
    ) {
        ModelAndView mav = new ModelAndView("profile", "jobSeekerDto", jobSeekerDto);
        mav.addObject("buttonValue", save);
        mav.addObject(action,"/recruitment/profile");
        mav.addObject(buttonValue, save);
        mav.addObject(method,"Post");

        if(result.hasErrors()) {
            System.out.println("Errors in page");
        }

        Optional<JobSeekerDto> savedDtoOptional = recruitmentService.saveProfile(jobSeekerDto);

        if (savedDtoOptional.isPresent()) {
            mav.addObject("message", "Profile Updated");
            mav.addObject("jobSeekerDto", savedDtoOptional.get());
        } else {
            mav.addObject("message", "Problem in Saving Profile");
            recruitmentService.addMinRecords(jobSeekerDto);
            mav.addObject("jobSeekerDto", jobSeekerDto);
        }

        getData(mav);
        return mav;
    }

    @GetMapping(value = "/profile/{type}/{value}")
    public ResponseEntity<?> checkExisting(@PathVariable("type") String type,
                                           @PathVariable("value") String value) throws JsonProcessingException {

        String result;

        if(type.equalsIgnoreCase("getSkills")) {

            Optional<Map<Long,String>> skillsOptional =
                    recruitmentService.getSkillsBySkillTypeId(Long.parseLong(value));

            if(skillsOptional.isPresent()) {

                String json = new ObjectMapper().writeValueAsString(skillsOptional.get());
                json = json.replace("\"", "\'").replace("'","\'");
                result = "{\"skillsExists\":\"true\", \"skills\":\""+json+"\"  }";
            } else {
                result = "{\"skillsExists\":\"false\" }";
            }
        } else {

            Optional<RegisterDto> dtoOptional = recruitmentService.findByType(Constants.Roles.JOB_SEEKER_ROLE, type, value);
            String typeString = StringUtils.join(type.split("(?=\\p{Upper})"), " ");

            if (dtoOptional.isPresent()) {
                result =
                        "{\"valueExists\":\"true\", \"message\":\"" + StringUtils.capitalize(typeString) +
                                " already exists\"  }";
            } else {
                result = "{\"valueExists\":\"false\" }";
            }
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @PostMapping("/profile/{type}/{id}")
    public ModelAndView updateProfile(
            @ModelAttribute("jobSeekerDto") JobSeekerDto jobSeekerDto,
            @PathVariable("type") String type,
            @PathVariable("id") String id) {

        ModelAndView mav = new ModelAndView("profile", "jobSeekerDto", jobSeekerDto);
        mav.addObject(action,"/recruitment/profile");
        getData(mav);

        Optional<JobSeekerDto> jobSeekerDtoOptional = recruitmentService.updatePreferences(type, Long.parseLong(id));
        if (jobSeekerDtoOptional.isPresent()) {
            mav.addObject("jobSeekerDto", jobSeekerDtoOptional.get());
            mav.addObject("message", "Profile updated successfully ");
            return mav;
        }

        mav.addObject("message", "Problem in Saving Profile");
        return mav;
    }

    private void getData(ModelAndView mav) {
        mav.addObject("skillTypes", recruitmentService.getAllSkillTypes());
        mav.addObject("skills", recruitmentService.getAllSkills());
    }

    ////////////////////// Profile ///////////////////

    ////////////////////////Recruiter///////////////

    @GetMapping("/recruiter")
    public ModelAndView getRecruiterProfile() {

        /*if (Util.isSpecifiedRole(Constants.Roles.JOB_SEEKER_ROLE.toUpperCase())) {
            getJobSeekerProfile();
        }*/

        RegisterDto registerDto = new RegisterDto();
        ModelAndView mav = new ModelAndView("recruiter", "registerDto", registerDto);

        // If Authenticated User
        if (Util.isAuthenticatedUser()) {
            Optional<RegisterDto> registerDtoOptional = recruitmentService.getRecruiterByUserName();

            if (registerDtoOptional.isPresent()) {
                mav = new ModelAndView("recruiter", "registerDto", registerDtoOptional.get());
            } else {
                mav.addObject("message", "Problem in Fetching Data");
            }
        } else {
            return new ModelAndView("home");
        }
        return mav;
    }

    @PostMapping("/recruiter")
    public ModelAndView saveRecruiter(@Valid @ModelAttribute("registerDto") RegisterDto registerDto,
                                      BindingResult result
    ) {
        ModelAndView mav = new ModelAndView("recruiter", "registerDto", registerDto);
        mav.addObject(action,"/recruitment/recruiter");
        mav.addObject(buttonValue, save);

        if(result.hasErrors()) {
            System.out.println("Errors in page");
        }

        Optional<RegisterDto> savedDtoOptional = recruitmentService.saveRecruiter(registerDto);

        if (!savedDtoOptional.isPresent()) {
            mav.addObject("message", "Problem in Saving Profile");
            mav.addObject("registerDto", new RegisterDto());
            return mav;
        }

        mav.addObject("registerDto", savedDtoOptional.get());
        mav.addObject("message", "Profile Updated");
        return mav;
    }

    @GetMapping(value = "/recruiter/{type}/{value}")
    public ResponseEntity<?> checkExistingRecruiter(@PathVariable("type") String type,
                                           @PathVariable("value") String value) throws JsonProcessingException {

        String result;
        Optional<RegisterDto> dtoOptional = recruitmentService.findByType(Constants.Roles.RECRUITER_ROLE, type, value);
        String typeString = StringUtils.join(type.split("(?=\\p{Upper})"), " ");

        if (dtoOptional.isPresent()) {
            result =
                    "{\"valueExists\":\"true\", \"message\":\"" + StringUtils.capitalize(typeString) +
                            " already exists\"  }";
        } else {
            result = "{\"valueExists\":\"false\" }";
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    ////////////////// Job Posting //////////////////

    @GetMapping("/jobPosting")
    public ModelAndView getJobPostingPage(
//            @ModelAttribute("jobPostingDto") JobPostingDto jobPostingDto
    ) {

        /*if (Objects.nonNull(jobPostingDto) && StringUtils.isNotEmpty(jobPostingDto.getJobId())) {
            Optional<JobPostingDto> jobPostingOptional = jobPostingService.getByPostId(jobPostingDto.getJobId());
            if (jobPostingOptional.isPresent()) {
                jobPostingDto = jobPostingOptional.get();
            }
        } else {
            jobPostingDto = new JobPostingDto();
        }*/

        JobPostingDto jobPostingDto = new JobPostingDto();

        ModelAndView mav = new ModelAndView("jobPosting", "jobPostingDto", jobPostingDto);

        if (Objects.isNull(jobPostingDto.getJobPostingRoles()) || jobPostingDto.getJobPostingRoles().isEmpty()) {
            // For the user, if no records available, we can show a single record
            List<JobPostingRoleDto> jobPostingRoles = new ArrayList<>();
            JobPostingRoleDto jobPostingRoleDto = new JobPostingRoleDto();
            jobPostingRoles.add(jobPostingRoleDto);
            jobPostingDto.setJobPostingRoles(jobPostingRoles);
        }

        if (Objects.isNull(jobPostingDto.getJobPostingSkills()) || jobPostingDto.getJobPostingSkills().isEmpty()) {
            List<JobPostingSkillDto> jobPostingSkillDtos = new ArrayList<>();
            JobPostingSkillDto jobPostingSkillDto = new JobPostingSkillDto();
            jobPostingSkillDtos.add(jobPostingSkillDto);
            jobPostingDto.setJobPostingSkills(jobPostingSkillDtos);
        }

        mav.addObject("jobsList", jobPostingService.getJobPostings());
        return mav;
    }

    @PostMapping("/jobPosting")
    public ModelAndView getJobPostingPage(@Valid @ModelAttribute("jobPostingDto") JobPostingDto jobPostingDto,
                                          BindingResult result) {
        ModelAndView mav = new ModelAndView("jobPosting", "jobPostingDto", jobPostingDto);

        if(result.hasErrors()) {
            System.out.println("Errors in page");
        }

        Optional<JobPostingDto> savedJobPostingDtoOptional = jobPostingService.saveJob(jobPostingDto);

        if (!savedJobPostingDtoOptional.isPresent()) {
            mav.addObject("message", "Problem in Saving Profile");
            mav.addObject("jobSeekerDto", new JobSeekerDto());
        } else {
            mav.addObject("message", "Job Post Created / Updated");
            mav.addObject("jobSeekerDto", savedJobPostingDtoOptional.get());
        }

        if (Objects.isNull(jobPostingDto.getJobPostingRoles()) || jobPostingDto.getJobPostingRoles().isEmpty()) {
            // For the user, if no records available, we can show a single record
            List<JobPostingRoleDto> jobPostingRoles = new ArrayList<>();
            JobPostingRoleDto jobPostingRoleDto = new JobPostingRoleDto();
            jobPostingRoles.add(jobPostingRoleDto);
            jobPostingDto.setJobPostingRoles(jobPostingRoles);
        }

        if (Objects.isNull(jobPostingDto.getJobPostingSkills()) || jobPostingDto.getJobPostingSkills().isEmpty()) {
            List<JobPostingSkillDto> jobPostingSkillDtos = new ArrayList<>();
            JobPostingSkillDto jobPostingSkillDto = new JobPostingSkillDto();
            jobPostingSkillDtos.add(jobPostingSkillDto);
            jobPostingDto.setJobPostingSkills(jobPostingSkillDtos);
        }

        mav.addObject("jobsList", jobPostingService.getJobPostings());

        return mav;
    }

    @GetMapping("/jobPosting/{postId}")
    public ResponseEntity<?> getByPostId(@PathVariable String postId) {

        String result = null;

        Optional<JobPostingDto> jobPostingOptional = jobPostingService.getByPostId(postId);
        if(jobPostingOptional.isPresent()) {
            JobPostingDto jobPostingDto = jobPostingOptional.get();
            try {
                result = new ObjectMapper().writeValueAsString(jobPostingDto);
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
        } else {
            result = "{}";
        }

        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    ////////////////// Job Posting //////////////////

    @GetMapping("/jobPosts")
    public ModelAndView getJobPosts() {

        JobPostingDto jobPostingDto = new JobPostingDto();

        ModelAndView mav = new ModelAndView("jobPosts", "jobPostingDto", jobPostingDto);
        List<JobPostingDto> jobPostingDtos = jobPostingService.getJobPosts();

        mav.addObject("jobsList", jobPostingDtos);
        return mav;
    }

    @PostMapping("/jobPosts")
    public ModelAndView applyForJobPost(@Valid @ModelAttribute("jobPostingDto") JobPostingDto jobPostingDto,
                                          BindingResult result) {
        ModelAndView mav = new ModelAndView("jobPosts", "jobPostingDto", jobPostingDto);

        if(result.hasErrors()) {
            System.out.println("Errors in page");
        }

        Status status = jobPostingService.applyForJobPost(jobPostingDto);

        mav.addObject("jobsList", jobPostingService.getJobPosts());

        if(Objects.nonNull(status) && status.isStatus()) {
            mav.addObject("message", status.getResponseText());
        }

        return mav;
    }



















    ////////////////// Old ////////////////////

    @GetMapping("/jobSeeker")
    public ModelAndView getJobSeekerPage(
            @RequestParam(required = false) String operation
    ) {
        JobSeekerDto newJobSeekerDto = new JobSeekerDto();

        /*List<JobSeekerExpDto> jobSeekerExperiences = new ArrayList<>();
        newJobSeekerDto.setExperiences(jobSeekerExperiences);*/

        ModelAndView mav = new ModelAndView("jobSeeker", jobSeekerDtoStr, newJobSeekerDto);
        mav.addObject(action,"/recruitment/jobSeeker");

        // If Authenticated User
        if (Util.isAuthenticatedUser()) {

            // For Editing operation
            if(StringUtils.isNotEmpty(operation) && "edit".equalsIgnoreCase(operation)) {
                Optional<JobSeekerDto> jobSeekerDtoOptional = recruitmentService.getDataByUserName();

                if(jobSeekerDtoOptional.isPresent()) {
                    mav = new ModelAndView("jobSeeker", jobSeekerDtoStr, jobSeekerDtoOptional.get());
                } else {
                    mav.addObject("message", "Problem in Fetching Data");
                }
            } else { // Without Editing. just login and continuing preferences page
                return getJobseekerPreferencesPage();
            }
        } else { // Not Authenticated
            mav = new ModelAndView("jobSeekerNotAuthenticated", jobSeekerDtoStr, newJobSeekerDto);
        }

        mav.addObject("buttonValue", save);
        mav.addObject(method,"Post");
        return mav;
    }

    @PostMapping("/jobSeeker")
    public ModelAndView save(@Valid @ModelAttribute("jobSeekerDto") JobSeekerDto jobSeekerDto,
                             BindingResult result
                             ) {
        ModelAndView mav = new ModelAndView("jobSeeker", "jobSeekerDto", jobSeekerDto);
        mav.addObject("buttonValue", save);
        mav.addObject(action,"/recruitment/jobSeeker");
        mav.addObject(buttonValue, save);
        mav.addObject(method,"Post");

        if(result.hasErrors()) {
            System.out.println("Errors in page");
        }

        Optional<JobSeekerDto> savedDtoOptional = recruitmentService.save(jobSeekerDto);

        if (!savedDtoOptional.isPresent()) {
            mav.addObject("message", "Problem in Saving Profile");
            return mav;
        }

        final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
        log.info("Url : {}", baseUrl);

        mav.addObject("message", "Profile created successfully \n Please " +
                "<a href='" + baseUrl + "'>login</a>" +
                "  with User Name : " + savedDtoOptional.get().getUserId());
        mav.addObject("jobSeekerDto", new JobSeekerDto());
        return mav;
    }

    @GetMapping("/jobSeekerPreferences")
    public ModelAndView getJobseekerPreferencesPage() {
        ModelAndView mav;

        JobSeekerDto jobSeekerDto = new JobSeekerDto();
        Optional<JobSeekerDto> jobSeekerDtoOptional = recruitmentService.getDataByUserName();

        if(jobSeekerDtoOptional.isPresent()) {
            jobSeekerDto = jobSeekerDtoOptional.get();

            // For the user, if no records available, we can show a single record
            if (Objects.isNull(jobSeekerDto.getUserExperiences()) || jobSeekerDto.getUserExperiences().isEmpty()) {
                List<JobSeekerExpDto> jobSeekerExperiences = new ArrayList<>();
                JobSeekerExpDto jobSeekerExpDto = new JobSeekerExpDto();
                jobSeekerExperiences.add(jobSeekerExpDto);
                jobSeekerDto.setUserExperiences(jobSeekerExperiences);
            }

            if (Objects.isNull(jobSeekerDto.getUserQualifications()) || jobSeekerDto.getUserQualifications().isEmpty()) {
                List<JobSeekerQlyDto> jobSeekerQualifications = new ArrayList<>();
                JobSeekerQlyDto jobSeekerQlyDto = new JobSeekerQlyDto();
                jobSeekerQualifications.add(jobSeekerQlyDto);
                jobSeekerDto.setUserQualifications(jobSeekerQualifications);
            }

            mav = new ModelAndView("jobSeekerPreferences", jobSeekerDtoStr, jobSeekerDto);
            mav.addObject(action,"/recruitment/jobSeekerPreferences");
            mav.addObject(method,"Post");
        } else {
            List<JobSeekerExpDto> jobSeekerExperiences = new ArrayList<>();
            JobSeekerExpDto jobSeekerExpDto = new JobSeekerExpDto();
            jobSeekerExperiences.add(jobSeekerExpDto);
            jobSeekerDto.setUserExperiences(jobSeekerExperiences);

            List<JobSeekerQlyDto> jobSeekerQualifications = new ArrayList<>();
            JobSeekerQlyDto jobSeekerQlyDto = new JobSeekerQlyDto();
            jobSeekerQualifications.add(jobSeekerQlyDto);
            jobSeekerDto.setUserQualifications(jobSeekerQualifications);

            mav = new ModelAndView("jobSeeker", jobSeekerDtoStr, jobSeekerDto);
            mav.addObject(action,"/recruitment/jobSeeker");
            mav.addObject(method,"Post");
        }
        mav.addObject("buttonValue", save);
        return mav;
    }

    @PostMapping("/jobSeekerPreferences")
    public ModelAndView savePreferences(@ModelAttribute("jobSeekerDto") JobSeekerDto jobSeekerDto) {

        ModelAndView mav = new ModelAndView("jobSeekerPreferences", jobSeekerDtoStr, jobSeekerDto);
        mav.addObject(action,"/recruitment/jobSeekerPreferences");
        mav.addObject("buttonValue", save);
        mav.addObject(buttonValue, save);
        mav.addObject(method,"Post");

        Optional<JobSeekerDto> jobSeekerDtoOptional = recruitmentService.savePreferences(jobSeekerDto);
        if (jobSeekerDtoOptional.isPresent()) {
            mav.addObject("message", "Profile updated successfully ");
            mav.addObject("jobSeekerDto", jobSeekerDtoOptional.get());
            return mav;
        }
        mav.addObject("message", "Problem in Saving Profile");
        return mav;
    }

    @PostMapping("/jobSeekerPreferences/{type}/{id}")
    public ModelAndView updatePreferences(
            @ModelAttribute("jobSeekerDto") JobSeekerDto jobSeekerDto,
            @PathVariable("type") String type,
            @PathVariable("id") String id) {

        ModelAndView mav = new ModelAndView("jobSeekerPreferences", jobSeekerDtoStr, jobSeekerDto);
        mav.addObject(action,"/recruitment/jobSeekerPreferences");
        mav.addObject("buttonValue", save);
        mav.addObject(buttonValue, save);
        mav.addObject(method,"Post");

        Optional<JobSeekerDto> jobSeekerDtoOptional = recruitmentService.updatePreferences(type, Long.parseLong(id));
        if (jobSeekerDtoOptional.isPresent()) {
            mav.addObject("jobSeekerDto", jobSeekerDtoOptional.get());
            mav.addObject("message", "Profile updated successfully ");
            return mav;
        }

        mav.addObject("message", "Problem in Saving Profile");
        return mav;
    }


    @GetMapping(value = "/jobSeeker/{type}/{value}")
    public ResponseEntity<?> find(@PathVariable("type") String type,
                                  @PathVariable("value") String value) {

        String result;
        Optional<RegisterDto> dtoOptional = recruitmentService.findByType(Constants.Roles.JOB_SEEKER_ROLE, type, value);
        String typeString = StringUtils.join(type.split("(?=\\p{Upper})"), " ");

        if(dtoOptional.isPresent()) {
            result =
                    "{\"valueExists\":\"true\", \"message\":\"" + StringUtils.capitalize(typeString) +
                            " already exists\"  }";
        } else {
            result = "{\"valueExists\":\"false\" }";
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }
}
