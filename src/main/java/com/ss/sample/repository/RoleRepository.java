package com.ss.sample.repository;

import com.ss.sample.entity.RoleEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleRepository extends CrudRepository<RoleEntity, Long> {

	List<RoleEntity> findByRoleId(long roleId);

	List<RoleEntity> findByRoleName(String roleName);

	List<RoleEntity> findByRoleNameIn(String... roles);

	List<RoleEntity> findAllByRoleIdIn(long[] roleIds);

//	List<Role> findByRoleNameInOrderByServices(String... roles);

}
