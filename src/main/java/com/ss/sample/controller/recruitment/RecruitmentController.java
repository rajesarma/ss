package com.ss.sample.controller.recruitment;

import com.ss.sample.service.recruitment.RecruitmentService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/recruitment")
public class RecruitmentController {

    private RecruitmentService recruitmentService;

    public RecruitmentController(RecruitmentService recruitmentService) {
        this.recruitmentService = recruitmentService;
    }

    @RequestMapping(value = "/compiler", method = RequestMethod.GET)
    public String compiler(ModelMap model) {
        return "compiler";
    }

}
