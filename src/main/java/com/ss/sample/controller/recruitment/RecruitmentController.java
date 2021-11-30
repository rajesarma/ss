package com.ss.sample.controller.recruitment;

import com.ss.sample.model.JobSeekerDto;
import com.ss.sample.model.JobSeekerExpDto;
import com.ss.sample.model.JobSeekerQlyDto;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

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

        Optional<JobSeekerDto> jobSeekerDtoOptional = recruitmentService.updatePreferences(jobSeekerDto);
        if (jobSeekerDtoOptional.isPresent()) {
            mav.addObject("message", "Profile updated successfully ");
            mav.addObject("jobSeekerDto", jobSeekerDtoOptional.get());
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

}
