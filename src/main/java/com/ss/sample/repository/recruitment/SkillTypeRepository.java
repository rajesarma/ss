package com.ss.sample.repository.recruitment;

import com.ss.sample.entity.recruitment.SkillTypeEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface SkillTypeRepository extends CrudRepository<SkillTypeEntity, Long> {

    Optional<SkillTypeEntity> findBySkillTypeId(long yearId);
}
