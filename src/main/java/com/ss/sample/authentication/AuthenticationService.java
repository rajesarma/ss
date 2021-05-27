package com.ss.sample.authentication;

import com.ss.sample.entity.UserEntity;
import com.ss.sample.exception.AuthenticationException;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

//@Service
public class AuthenticationService {

	private AuthenticationRepository authenticationRepository;

	@Autowired
	AuthenticationService(final AuthenticationRepository authenticationRepository) {
		this.authenticationRepository = authenticationRepository;
	}

	boolean authenticateUser(String userName, String password,
			HttpServletRequest request) throws AuthenticationException {

		UserEntity user = authenticationRepository.authenticateUser(userName, password);

		getServices(request, user);



		if (user != null) {

			return true;
		}

		return false;
	}

	public List getServices(HttpServletRequest request, UserEntity user) {

		HttpSession session = request.getSession(true);

		List<HashMap<String, String>> servicesList =
				authenticationRepository.getServices(user.getUsername());

		session.setAttribute("services", servicesList);
		session.setAttribute("user", user);
		session.setAttribute("user_desc", user.getUserDesc());

		List serviceUrls =  servicesList.stream()
				.map(serviceMap -> serviceMap.get("serviceUrl"))
				.collect(Collectors.toList());

		session.setAttribute("serviceUrls", serviceUrls);

		List<HashMap<String, String>> servicesShowList = servicesList.stream()
				.filter(serviceMap -> "1".equalsIgnoreCase(serviceMap.get("menuDisplay")))
				.collect(Collectors.toList());

//		System.out.println(servicesShowList);
		session.setAttribute("servicesMenu", new JSONArray(servicesShowList)); // Show
		// in menu only services which are allowed to show in menu

		return servicesList;
	}

}
