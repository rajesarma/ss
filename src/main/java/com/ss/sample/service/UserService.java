package com.ss.sample.service;

import com.ss.sample.entity.RoleEntity;
import com.ss.sample.entity.UserEntity;
import com.ss.sample.model.UserDto;
import com.ss.sample.repository.RoleRepository;
import com.ss.sample.repository.UserRepository;
import com.ss.sample.util.Constants;
import com.ss.sample.util.UserConverter;
import com.ss.sample.util.Constants.StrConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Service
public class UserService {

	private UserRepository userRepository;
	private RoleRepository roleRepository;

	@Autowired
    UserService(final UserRepository userRepository,
                final RoleRepository roleRepository) {
		this.userRepository = userRepository;
		this.roleRepository = roleRepository;
	}

	private static final Logger log = LoggerFactory.getLogger(UserService.class);

	public Map<Long,String> getRoles() {
		return StreamSupport.stream(roleRepository.findAll().spliterator(), false)
				.collect(Collectors.toMap(RoleEntity::getRoleId, RoleEntity::getRoleName));
	}

	public Optional<UserDto> save(HttpServletRequest request, UserDto userDto) {

		UserEntity userEntity = UserConverter.convert(userDto);

		Optional<UserEntity> existingUser = userRepository.findByUsername(userEntity.getUsername());

		if(existingUser.isPresent()) {
			log.info("<USER><USER:SAVE>"
					+ "<User:" + request.getSession().getAttribute(Constants.StrConstants.SESSION_USER_NAME) + ">"
					+ "<" + existingUser.get().getUsername() +" : already exists>");

			return Optional.empty();
		}

		userEntity.setPassword(new BCryptPasswordEncoder().encode(userDto.getPassword()));
		UserEntity savedUser = userRepository.save(userEntity);

		log.info("<USER><USER:SAVE>"
				+ "<User:" + request.getSession().getAttribute(StrConstants.SESSION_USER_NAME) + ">"
				+ "<" + savedUser.getUsername() +" : saved>");

		return Optional.of(UserConverter.convert(savedUser));
	}

	public List<UserDto> findUsersByRoles(UserDto userDto) {

		List<UserEntity> users =
				userRepository.findAllByRolesIn(UserConverter.convert(userDto).getRoles());

		List<UserDto> userDtoDtos = new ArrayList<>();

		users.forEach(user -> userDtoDtos.add(UserConverter.convert(user)));

		return userDtoDtos;
	}

	public Optional<UserDto> findUsersById(Long userId) {
		Optional<UserEntity> userOptional = userRepository.findById(userId);
			if(userOptional.isPresent()) {

				UserDto userDto = UserConverter.convert(userOptional.get());

				return Optional.of(userDto);
			}

		return Optional.empty();
	}

	public Optional<UserDto> changePassword(HttpServletRequest request, String username,
									 String password, String newPassword) {
		PasswordEncoder encoder = new BCryptPasswordEncoder();

		Optional<UserEntity> userOptional =
				userRepository.findByUsername(username.toLowerCase(Locale.US));

		if(!userOptional.isPresent()) {

			log.info("<UserEntity><USER:CHANGE_PASSWORD>"
					+ "<User:" + request.getSession().getAttribute(StrConstants.SESSION_USER_NAME) + ">"
					+ "<" + username +" : not found>");

			return Optional.empty();
		} else {
			UserEntity user = userOptional.get();
			if(encoder.matches(password, user.getPassword())) {

				user.setPassword(encoder.encode(newPassword));
				user.setLastPasswordChange(new Date());
				UserEntity savedUser = userRepository.save(user);

				log.info("<UserEntity><USER:CHANGE_PASSWORD>"
						+ "<User:" + request.getSession().getAttribute(StrConstants.SESSION_USER_NAME) + ">"
						+ "<" + userOptional.get().getUsername() +" : Password updated>");

				return Optional.of(UserConverter.convert(savedUser));
			} else {

				log.info("<UserEntity><USER:CHANGE_PASSWORD>"
						+ "<User:" + request.getSession().getAttribute(StrConstants.SESSION_USER_NAME) + ">"
						+ "<" + userOptional.get().getUsername() +" : User credentials " +
						"does not match>");
				return Optional.empty();
			}
		}
	}

	public Optional<UserDto> delete(HttpServletRequest request, UserDto userDto) {

		UserEntity user = UserConverter.convert(userDto);

		userRepository.deleteById(user.getUserId());
		Optional<UserEntity> userOptional = userRepository.findById(user.getUserId());

		if(userOptional.isPresent()) {
			log.info("<UserEntity><USER:DELETE>"
					+ "<User:" + request.getSession().getAttribute(StrConstants.SESSION_USER_NAME) + ">"
					+ "<" + userOptional.get().getUsername() +" : not deleted>");
			return Optional.of(UserConverter.convert(userOptional.get()));
		}

		log.info("<UserEntity><USER:DELETE>"
				+ "<User:" + request.getSession().getAttribute(StrConstants.SESSION_USER_NAME) + ">"
				+ "<" + userDto.getUsername() +" : deleted>");

		return Optional.empty();
	}

	public Optional<UserDto> update(HttpServletRequest request, UserDto userDto) {
		UserEntity user = UserConverter.convert(userDto);

		PasswordEncoder encoder = new BCryptPasswordEncoder();
		Optional<UserEntity> userOptional = userRepository.findById(user.getUserId());

		if(!userOptional.isPresent()) {
			return Optional.empty();
		} else {
			UserEntity toUpdateUser = userOptional.get();

			toUpdateUser.setUsername(user.getUsername());
			toUpdateUser.setPassword(encoder.encode(user.getPassword()));
			toUpdateUser.setEmail(user.getEmail());
			toUpdateUser.setRoles(user.getRoles());
			toUpdateUser.setUserDesc(user.getUserDesc());

			UserEntity savedUser = userRepository.save(toUpdateUser);

			if(userRepository.existsById(savedUser.getUserId())) {
				log.info("<UserEntity><USER:UPDATE>"
						+ "<User:" + request.getSession().getAttribute(StrConstants.SESSION_USER_NAME) + ">"
						+ "<" + savedUser.getUserId() +" : updated>");

				return Optional.of(UserConverter.convert(savedUser));
			}

			return Optional.empty();
		}
	}

	public void registerSuccessfulLogin(Long userId){
		Optional<UserEntity> userOptional = userRepository.findById(userId);

		if(!userOptional.isPresent()){
			return;
		}
		UserEntity user = userOptional.get();
		user.setLastLogin(new Date());
		user.setFailedLoginAttempts(0L);
		userRepository.save(user);
	}

	public void registerFaliureLogin(String username){
		if(username  == null) {
			return;
		}

		Optional<UserEntity> userOptional = userRepository.findByUsername(username);

		if(!userOptional.isPresent()){
			return;
		}

		UserEntity user = userOptional.get();

		Long prevFailureLoginCount = user.getFailedLoginAttempts();
		long failureLoginCount = prevFailureLoginCount != null ?
				prevFailureLoginCount + 1 : 1L;

		user.setFailedLoginAttempts(failureLoginCount);
		userRepository.save(user);
	}

}
