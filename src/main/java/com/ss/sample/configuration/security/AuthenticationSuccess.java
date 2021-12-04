package com.ss.sample.configuration.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ss.sample.entity.RoleEntity;
import com.ss.sample.entity.ServiceEntity;
import com.ss.sample.entity.UserEntity;
import com.ss.sample.repository.RoleRepository;
import com.ss.sample.service.UserService;
import com.ss.sample.util.Constants;
import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

public class AuthenticationSuccess extends SimpleUrlAuthenticationSuccessHandler {

	private static final Logger log = LoggerFactory.getLogger(AuthenticationSuccess.class);

	@Autowired
	private RoleRepository roleRepository;

	@Autowired
	private UserService userService;

	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		HttpSession session = request.getSession(true);

		ObjectMapper oMapper = new ObjectMapper();

		// Get the Principal User object
//		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserEntity user = (UserEntity) authentication.getPrincipal();

		log.info("User logged in: " + user.getUsername() + " - " + request.getRemoteHost());

		// Update the LastLogin of User
		userService.registerSuccessfulLogin(user.getUserId());
		session.setAttribute("username", user.getUsername());

		String[] roleNames = user.getRoles()
								.stream()
								.map(RoleEntity::getRoleName)
								.collect(Collectors.toList())
								.stream()
								.toArray(String[] :: new);

		List<ServiceEntity> services = new ArrayList<>();

		roleRepository.findByRoleNameIn(roleNames)
						.forEach(role -> services.addAll(role.getServices()));

		services.sort(Comparator.comparing(ServiceEntity :: getParentId)
								.thenComparing(ServiceEntity :: getServiceId));

		List serviceUrls = services.stream()
				.filter(service -> service.getMenuDisplay() )
				.collect(Collectors.toList())
				.stream()
				.map(service -> oMapper.convertValue(service, Map.class))
				.collect(Collectors.toList());

		session.setAttribute("servicesMenu", new JSONArray(serviceUrls));
		session.setAttribute("services1", services);

//		response.sendRedirect("/home");

		Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

		authorities.forEach(authority -> {
			if(getRole(Constants.Roles.MANAGEMENT_ROLE).equals(authority.getAuthority())) {
				try {
					redirectStrategy.sendRedirect(request, response, "/management/managementDashboard");

				} catch (Exception e) {
				}
			} else if(!Constants.Roles.MANAGEMENT_ROLE.equals(authority.getAuthority())) {
				try {
//					response.sendRedirect("/home");
					redirectStrategy.sendRedirect(request, response, "/home");
				} catch (Exception e) { }
			} else {
				throw new IllegalStateException();
			}
		});

	}

	private String getRole(String role){
		if(role.length() == 0){
			throw new IllegalArgumentException("Role should be passed");
		} else {
			return "JobSeekerDto" + role;
		}
	}
}