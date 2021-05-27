package com.ss.sample.service;

import com.ss.sample.entity.RoleEntity;
import com.ss.sample.entity.ServiceEntity;
import com.ss.sample.repository.RoleRepository;
import com.ss.sample.repository.ServiceRepository;
import com.ss.sample.util.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Service
public class RoleServicesMappingService {

	private RoleRepository roleRepository;
	private ServiceRepository serviceRepository;

	private static final Logger log = LoggerFactory.getLogger(RoleServicesMappingService.class);

	@Autowired
	public void setRoleRepository(RoleRepository roleRepository) {
		this.roleRepository = roleRepository;
	}

	@Autowired
	public void setServiceRepository(ServiceRepository serviceRepository) {
		this.serviceRepository = serviceRepository;
	}

	public Map<Long,String> getRoles() {
		return StreamSupport.stream(roleRepository.findAll().spliterator(), false)
				.collect(Collectors.toMap(RoleEntity::getRoleId, RoleEntity::getRoleName));
	}

	public Map<Long,String> getServices() {
		return StreamSupport.stream(serviceRepository.findAll().spliterator(), false)
				.collect(Collectors.toMap(ServiceEntity::getServiceId,
						ServiceEntity::getServiceName));
	}

	public List<Long> getRoleMappedServices(Long roleId) {

		List<ServiceEntity> services = new ArrayList<>();

		roleRepository.findByRoleId(roleId)
				.forEach(role -> services.addAll(role.getServices()));

		/*roleRepository.findByRoleId(roleId)
				.stream()
				.map(Service::getServiceId)
				.distinct()
				.collect(Collectors.toList());*/ // Modify This

		return services
				.stream()
				.map(ServiceEntity::getServiceId)
				.distinct()
				.collect(Collectors.toList());
	}

	public Optional<RoleEntity> updateServices(HttpServletRequest request, RoleEntity toUpdateRole) {

		Optional<RoleEntity> optionalRole = roleRepository.findById(toUpdateRole.getRoleId());

		if(optionalRole.isPresent()) {
			RoleEntity role = optionalRole.get();

			role.setServices(toUpdateRole.getServices());
			RoleEntity savedRole = roleRepository.save(role);

			if(savedRole.getRoleId() > 0 ) {

				log.info("<ROLE_SERVICES><ROLE_SERVICES:UPDATE>"
						+ "<User:" + request.getSession().getAttribute(Constants.StrConstants.SESSION_USER_NAME) + ">"
						+ "<" + savedRole.getRoleName() +" : updated>");

				return Optional.of(savedRole);
			}
		}
		return Optional.empty();
	}


}
