package com.ss.sample.repository;

import com.ss.sample.entity.RoleEntity;
import com.ss.sample.entity.UserEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends CrudRepository<UserEntity, Long> {

	Optional<UserEntity> findByUsername(String username);

	List<UserEntity> findAllByRolesIn(java.util.List<RoleEntity> role);

	@Override
	void deleteById(Long userId);

	@Query(value = "select id, user_name, password, disabled, user_desc, email, last_login, failed_login_attempts, last_password_change" +
			" from user_roles ur" +
			" join users u on (u.id = ur.user_id)" +
			" where role_id = ?1",nativeQuery = true)
	List<UserEntity> findAllByRoleId(long roleId);


}
