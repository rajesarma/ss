package com.ss.sample.controller;

import com.ss.sample.entity.RoleEntity;
import com.ss.sample.service.RoleServicesMappingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/roleServices")
public class RoleServicesMappingController {

	private RoleServicesMappingService roleServicesMappingService;

	@Autowired
	public void setRoleServicesMappingService(RoleServicesMappingService roleServicesMappingService) {
		this.roleServicesMappingService = roleServicesMappingService;
	}

	private void loadDbData(final ModelAndView mav) {
		mav.addObject("roles", roleServicesMappingService.getRoles());
		mav.addObject("services", roleServicesMappingService.getServices());
	}

	@GetMapping("")
	public ModelAndView roleServiceMapping() {

		RoleEntity role = new RoleEntity();
		role.setRoleId(1);
		ModelAndView mav = new ModelAndView("roleServices", "role", role);
		loadDbData(mav);

		mav.addObject("selectedServiceIds",
				roleServicesMappingService.getRoleMappedServices(role.getRoleId()));
		mav.addObject("roleId", role.getRoleId());

		return mav;
	}

	@PostMapping("")
	public ModelAndView mapRoleServices(@ModelAttribute("role") RoleEntity role,
                                        HttpServletRequest request) {

		ModelAndView mav = new ModelAndView("roleServices", "role", role);
		loadDbData(mav);

		Optional<RoleEntity> roleOptional = roleServicesMappingService.updateServices(request
				, role);

		if(roleOptional.isPresent()) {
			role = roleOptional.get();
			mav.addObject("message", "Role Services mapped successfully");

		} else {
			mav.addObject("message", "Role Services is not mapped");
		}

		mav.addObject("role", role);
		mav.addObject("roleId", role.getRoleId());
		mav.addObject("selectedServiceIds",
				roleServicesMappingService.getRoleMappedServices(role.getRoleId()));

		return mav;
	}

	@GetMapping("/{roleId}") // Ajax Call
	public ResponseEntity<?> getMappedServices(@PathVariable("roleId") Long roleId) {

		List<Long> selectedServiceIds =
				roleServicesMappingService.getRoleMappedServices(roleId);
		return new ResponseEntity<>(selectedServiceIds, HttpStatus.OK);
	}
}
