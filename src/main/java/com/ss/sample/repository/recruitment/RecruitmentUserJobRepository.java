package com.ss.sample.repository.recruitment;

import com.ss.sample.entity.recruitment.RecruitmentUserJobEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RecruitmentUserJobRepository extends CrudRepository<RecruitmentUserJobEntity, Long> {


    @Query(value = "select * from recruitment_users_jobs r where r.user_id = ?1", nativeQuery = true)
    List<RecruitmentUserJobEntity> findAllByUserId(String userId);
}
