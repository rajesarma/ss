package com.ss.sample.controller;

import com.ss.sample.entity.RoleEntity;
import com.ss.sample.entity.UserEntity;
import com.ss.sample.model.UserDto;
import com.ss.sample.service.UserService;
import com.ss.sample.util.UserConverter;
import com.ss.sample.validator.UserValidator;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
public class UserController {

	private UserService userService;

	@Autowired
    UserController(UserService userService) {
		this.userService = userService;
	}

	@Value("${save}")
	private String save;

	@Value("${change}")
	private String change;

	@Value("${update}")
	private String update;

	private String userDataDto = "userDto";
	private String usersList = "usersList";
	private String buttonValue = "buttonValue";
	private String action = "action";
	private String method = "method";
	private String roles = "roles";
	private String message;
	private String msg = "message";
	private String selectedRoleIds = "selectedRoleIds";

	@GetMapping("/admin/user/add")
	public ModelAndView save(HttpServletRequest req) {

		ModelAndView mav = new ModelAndView("user", userDataDto, new UserDto());
		mav.addObject(buttonValue, save);
		mav.addObject(action,"/admin/user/add");
		mav.addObject(method,"Post");
		mav.addObject(roles, userService.getRoles());

		Map<String,?> inputFlash = RequestContextUtils.getInputFlashMap(req);

		/*if(inputFlash != null) {
			mav.ad
		}*/

		return mav;
	}

	@PostMapping("/admin/user/add")
	public ModelAndView save(@ModelAttribute UserDto userDto,
                             BindingResult bindingResult, HttpServletRequest request,
                             RedirectAttributes ra) { //
		// @Valid

		new UserValidator().validate(userDto, bindingResult);
		ModelAndView mav = new ModelAndView("user", userDataDto, userDto);

		if(!bindingResult.hasErrors()) {
			Optional<UserDto> savedUserDto = userService.save(request, userDto);

			ra.addFlashAttribute(userDto);

			if (!savedUserDto.isPresent()) {
				message = "User already existed";
			} else {
				userDto.setUsername("");
				userDto.setPassword("");
				userDto.setEmail("");
				userDto.setUserDesc("");
				message = "User Information inserted successfully";
			}
		} else {
			message = "User Information is not inserted";
			mav.addObject(selectedRoleIds, getSelectedRoles(userDto.getRoles()));
		}

		mav.addObject(msg, message);
		mav.addObject(buttonValue, save );
		mav.addObject(action,"/admin/user/add");
		mav.addObject(method,"Post");
		mav.addObject(roles, userService.getRoles());
		return mav;
	}

	@GetMapping("/changePassword")
	public ModelAndView change() {

		UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		ModelAndView mav = new ModelAndView("changePassword", userDataDto, UserConverter.convert(userEntity));
		mav.addObject(buttonValue, change );
		mav.addObject(action,"/changePassword");
		mav.addObject(method,"Post");

		return mav;
	}

	@PostMapping("/changePassword")
	public ModelAndView change(@ModelAttribute UserDto userDto, HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("changePassword", userDataDto, userDto);
		mav.addObject(buttonValue, change );
		mav.addObject(action,"/changePassword");
		mav.addObject(msg, "Problem in Updating Password");
		mav.addObject(method,"Post");

		if(StringUtils.isNotEmpty(userDto.getNewPassword())) {
			UserEntity userEntity = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			Optional<UserDto> userOptional = userService.changePassword(request, userEntity.getUsername(),
							userDto.getPassword(), userDto.getNewPassword());

			if(userOptional.isPresent() && userOptional.get().getUserId() > 0) {
				mav.addObject(msg, "Password Updated");
			}
		}
		return mav;
	}

	@GetMapping("/admin/usersList")
	public ModelAndView list() {

		ModelAndView mav = new ModelAndView(usersList, userDataDto, new UserDto());

		mav.addObject(buttonValue, "Get" );
		mav.addObject(action,"/admin/usersList");
		mav.addObject(method,"post");
		mav.addObject(roles, userService.getRoles());
		return mav;
	}

	@PostMapping("/admin/usersList")
	public ModelAndView list(@ModelAttribute("userDto") UserDto userDto) {

		ModelAndView mav = new ModelAndView(usersList, userDataDto, userDto);
		mav.addObject(buttonValue, "Get" );
		mav.addObject(action,"/admin/usersList");
		mav.addObject(method,"Post");
		mav.addObject("Role", "/admin");
		mav.addObject(usersList, userService.findUsersByRoles(userDto));
		mav.addObject(selectedRoleIds, getSelectedRoles(userDto.getRoles()));
		mav.addObject(roles, userService.getRoles());
		return mav;
	}

	@GetMapping("/admin/user/edit/{userId}/{operation}")
	public ModelAndView edit(@PathVariable("userId") long userId,
                             @PathVariable("operation") String operation) {

		ModelAndView mav = new ModelAndView("user", userDataDto, new UserDto());

		Optional<UserDto> userOptional = userService.findUsersById(userId);
		if(userOptional.isPresent()) {
			UserDto userDto = userOptional.get();
			mav.addObject(userDataDto, userDto);
			mav.addObject(selectedRoleIds, getSelectedRoles(userDto.getRoles()));
		}

		mav.addObject(roles, userService.getRoles());
		mav.addObject(buttonValue, operation.toUpperCase());
		mav.addObject(action,"/admin/user/" + operation); // operation as Update/Delete
		mav.addObject(method,"post");
		mav.addObject("Role", "/admin");
		return mav;
	}

	@PostMapping("/admin/user/delete")
	public ModelAndView delete(@ModelAttribute("userDto") UserDto userDto,
                               HttpServletRequest request)  {

		ModelAndView mav = new ModelAndView(usersList, userDataDto, userDto);
		Optional<UserDto> userOptional = userService.delete(request, userDto);

		if(!userOptional.isPresent()) {
			message = "User Information deleted successfully";
		} else {
			message = "Problem in User deletion";
		}

		mav.addObject(msg, message);
		mav.addObject(buttonValue, "Get" );
		mav.addObject(action,"/admin/usersList");
		mav.addObject(method,"Post");
		mav.addObject("Role", "/admin");
		mav.addObject(usersList, userService.findUsersByRoles(userDto));
		mav.addObject(roles, userService.getRoles());
		mav.addObject(selectedRoleIds, getSelectedRoles(userDto.getRoles()));

		return mav;
	}

	@PostMapping("/admin/user/update")
	public ModelAndView update(@ModelAttribute UserDto userDto,
                               BindingResult bindingResult, HttpServletRequest request) { // @Valid

		new UserValidator().validate(userDto, bindingResult);

		ModelAndView mav = new ModelAndView(usersList, userDataDto, userDto);
		mav.addObject(selectedRoleIds, getSelectedRoles(userDto.getRoles()));
		mav.addObject(method,"Post");
		mav.addObject(roles, userService.getRoles());

		if(bindingResult.hasErrors()) {
			mav.setViewName("user");
			mav.addObject(msg, "User Information is not updated");
			mav.addObject(buttonValue, update );
			mav.addObject(action,"/admin/user/update");
			return mav;

		} else {
			Optional<UserDto> userOptional = userService.update(request, userDto);

			if (userOptional.isPresent()) {
				message = "User Information updated successfully";
				mav.addObject(userDataDto, userOptional.get());
			} else {
				userDto.setPassword("");
				message = "User Information is not updated";
			}
		}

		mav.addObject(msg, message);
		mav.addObject(buttonValue, "Get" );
		mav.addObject(action,"/admin/usersList");
		mav.addObject("Role", "/admin");

		mav.addObject(usersList, userService.findUsersByRoles(userDto));
		mav.addObject(selectedRoleIds, getSelectedRoles(userDto.getRoles()));

		return mav;
	}

	private List<Long> getSelectedRoles(List<RoleEntity> roles) {
		return roles
				.stream()
				.map(RoleEntity::getRoleId)
				.distinct()
				.collect(Collectors.toList());
	}
}