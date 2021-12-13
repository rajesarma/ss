package com.ss.sample.controller;

import com.ss.sample.model.JobSeekerDto;
import com.ss.sample.service.UserService;
import com.ss.sample.service.recruitment.RecruitmentService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.validation.Valid;
import java.util.Objects;
import java.util.Optional;

@Controller
@Slf4j
@RequestMapping(value="/register")
public class RegisterController {

	private RecruitmentService recruitmentService;

	public RegisterController(RecruitmentService recruitmentService) {
		this.recruitmentService = recruitmentService;
	}

	@GetMapping(value="")
	public ModelAndView register() {

		return new ModelAndView("register", "jobSeekerDto", new JobSeekerDto());
	}

	@PostMapping(value="")
	public ModelAndView save(@ModelAttribute("jobSeekerDto") JobSeekerDto jobSeekerDto) {
		ModelAndView mav = new ModelAndView("register", "jobSeekerDto", new JobSeekerDto());

		if (
			StringUtils.isEmpty(jobSeekerDto.getFirstName()) ||
			StringUtils.isEmpty(jobSeekerDto.getLastName()) ||
			StringUtils.isEmpty(jobSeekerDto.getEmail()) ||
			StringUtils.isEmpty(jobSeekerDto.getPassword())
		) {
			mav.addObject("message", "Please enter mandatory fields");
			return mav;
		}

		Optional<JobSeekerDto> savedDtoOptional = recruitmentService.createUser(jobSeekerDto);

		if (!savedDtoOptional.isPresent()) {
			mav.addObject("message", "Problem in Creating User");
			return mav;
		}

		final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
		log.info("Url : {}", baseUrl);

		mav.addObject("message", "User created successfully \n Please " +
				"<a href='" + baseUrl + "'>login</a>" +
				"  with User Name : " + savedDtoOptional.get().getUserId());
		return mav;
	}

	@GetMapping(value = "/{type}/{value}")
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