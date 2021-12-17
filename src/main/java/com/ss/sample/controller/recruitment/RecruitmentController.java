package com.ss.sample.controller.recruitment;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ss.sample.model.JobSeekerDto;
import com.ss.sample.model.JobSeekerExpDto;
import com.ss.sample.model.JobSeekerQlyDto;
import com.ss.sample.model.JobSeekerSkillDto;
import com.ss.sample.service.recruitment.RecruitmentService;
import com.ss.sample.util.Util;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.validation.Valid;
import java.time.LocalDate;
import java.util.*;

@Controller
@RequestMapping(value="/recruitment")
@Slf4j
public class RecruitmentController {

    @Value("${save}")
    private String save;

    @Value("${change}")
    private String change;

    @Value("${update}")
    private String update;

    private String jobSeekerDtoStr = "jobSeekerDto";
    private String usersList = "usersList";
    private String buttonValue = "buttonValue";
    private String action = "action";
    private String method = "method";
    private String msg = "message";
    private String message;

    private RecruitmentService recruitmentService;

    public RecruitmentController(RecruitmentService recruitmentService) {
        this.recruitmentService = recruitmentService;
    }

    @RequestMapping(value = "/compiler", method = RequestMethod.GET)
    public String compiler(ModelMap model) {
        return "compiler";
    }

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
        if (Util.isAuthenticatedJobSeeker()) {

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
        Optional<JobSeekerDto> jobSeekerDto = recruitmentService.findByType(type, value);
        String typeString = StringUtils.join(type.split("(?=\\p{Upper})"), " ");

        if(jobSeekerDto.isPresent()) {
            result =
                    "{\"valueExists\":\"true\", \"message\":\"" + StringUtils.capitalize(typeString) +
                            " already exists\"  }";
        } else {
            result = "{\"valueExists\":\"false\" }";
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }



    ////////////////////////

    @GetMapping("/profile")
    public ModelAndView getProfile(
            @RequestParam(required = false) String operation
    ) {
        JobSeekerDto jobSeekerDto = new JobSeekerDto();

        ModelAndView mav = new ModelAndView("profile", jobSeekerDtoStr, jobSeekerDto);

//        newJobSeekerDto.setSkillTypes(recruitmentService.getSkillTypes());
//        mav.addObject(method,"Post");
//        mav.addObject(action,"/recruitment/profile");

        // If Authenticated User
        if (Util.isAuthenticatedJobSeeker()) {
            Optional<JobSeekerDto> jobSeekerDtoOptional = recruitmentService.getDataByUserName();

            /*if (jobSeekerDtoOptional.isPresent()) {
                mav = new ModelAndView("profile", jobSeekerDtoStr, jobSeekerDtoOptional.get());
            } else {
                mav.addObject("message", "Problem in Fetching Data");
            }*/

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

                if (Objects.isNull(jobSeekerDto.getUserSkills()) || jobSeekerDto.getUserSkills().isEmpty()) {
                    List<JobSeekerSkillDto> jobSeekerSkills = new ArrayList<>();
                    JobSeekerSkillDto jobSeekerSkillDto = new JobSeekerSkillDto();
                    jobSeekerSkills.add(jobSeekerSkillDto);
                    jobSeekerDto.setUserSkills(jobSeekerSkills);
                }

                mav = new ModelAndView("profile", jobSeekerDtoStr, jobSeekerDto);
                mav.addObject(action,"/recruitment/profile");
            } else {

                mav.addObject("message", "Problem in Fetching Data");
            }
        } else {
            return new ModelAndView("home");
        }
        getData(mav);
        return mav;
    }

    @PostMapping("/profile")
    public ModelAndView saveProfile(@Valid @ModelAttribute("jobSeekerDto") JobSeekerDto jobSeekerDto,
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

        if (!savedDtoOptional.isPresent()) {
            mav.addObject("message", "Problem in Saving Profile");
            mav.addObject("jobSeekerDto", new JobSeekerDto());
            return mav;
        }

        mav.addObject("jobSeekerDto", savedDtoOptional.get());
        mav.addObject("message", "Profile Updated");
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

            Optional<JobSeekerDto> jobSeekerDto = recruitmentService.findByType(type, value);
            String typeString = StringUtils.join(type.split("(?=\\p{Upper})"), " ");

            if (jobSeekerDto.isPresent()) {
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
}
