package com.ss.sample.controller.recruitment;

import com.ss.sample.model.JobSeekerDto;
import com.ss.sample.service.recruitment.RecruitmentService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
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
    public ModelAndView getJobseekerPage() {

        ModelAndView mav = new ModelAndView("jobSeeker", jobSeekerDtoStr, new JobSeekerDto());
        mav.addObject("buttonValue", save);
        mav.addObject(action,"/recruitment/jobSeeker");
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
