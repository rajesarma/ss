package com.ss.sample.controller;

import com.ss.sample.model.recruitment.RegisterDto;
import com.ss.sample.service.recruitment.RecruitmentService;
import com.ss.sample.util.Constants;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

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

		return new ModelAndView("register", "registerDto", new RegisterDto());
	}

	@PostMapping(value="")
	public ModelAndView save(@ModelAttribute("registerDto") RegisterDto registerDto) {
		ModelAndView mav = new ModelAndView("register", "registerDto", new RegisterDto());

		if (
			StringUtils.isEmpty(registerDto.getFirstName()) ||
			StringUtils.isEmpty(registerDto.getLastName()) ||
			StringUtils.isEmpty(registerDto.getEmail()) ||
			StringUtils.isEmpty(registerDto.getPassword())
		) {
			mav.addObject("message", "Please enter mandatory fields");
			return mav;
		}

		Optional<RegisterDto> savedDtoOptional = recruitmentService.createUser(registerDto);

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