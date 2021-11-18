package com.ss.sample.controller.recruitment;

import com.ss.sample.model.JobSeekerDto;
import com.ss.sample.service.recruitment.RecruitmentService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.validation.BindingResult;

import javax.validation.Valid;

@Controller
@RequestMapping(value="/recruitment")
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

        if(result.hasErrors()) {
            System.out.println("Errors in page");
        }

        ModelAndView mav = new ModelAndView("jobSeeker", jobSeekerDtoStr, jobSeekerDto);
        mav.addObject("buttonValue", save);
        mav.addObject(action,"/recruitment/jobSeeker");
        mav.addObject(method,"Post");
        mav.addObject(msg, message);
        mav.addObject(buttonValue, save);
        return mav;
    }

}
