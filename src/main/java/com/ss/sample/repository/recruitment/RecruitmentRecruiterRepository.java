package com.ss.sample.repository.recruitment;

import com.ss.sample.entity.recruitment.RecruitmentRecruiterEntity;
import com.ss.sample.entity.recruitment.RecruitmentUserEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RecruitmentRecruiterRepository extends CrudRepository<RecruitmentRecruiterEntity, Long> {

    @Query(value = "SELECT coalesce(max(rr.id), 0) + 1 FROM recruitment_recruiter rr", nativeQuery = true)
    Long getMaxId();
    Optional<RecruitmentRecruiterEntity> findFirstByEmail(String email);
    Optional<RecruitmentRecruiterEntity> findFirstByMobile(String mobile);

    Optional<RecruitmentRecruiterEntity> findByUserId(String userId);

}
