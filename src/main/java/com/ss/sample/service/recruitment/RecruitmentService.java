package com.ss.sample.service.recruitment;

import com.ss.sample.util.recruitment.JDoodleCompilerTest;
import org.springframework.stereotype.Service;

@Service
public class RecruitmentService {

    private JDoodleCompilerTest jDoodleCompilerTest;

    public RecruitmentService(JDoodleCompilerTest jDoodleCompilerTest) {
        this.jDoodleCompilerTest = jDoodleCompilerTest;
    }
}
