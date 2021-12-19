package com.ss.sample.repository.recruitment;

import com.ss.sample.entity.recruitment.RecruitmentUserEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RecruitmentUserRepository extends CrudRepository<RecruitmentUserEntity, Long> {

    @Query(value = "SELECT coalesce(max(ru.id), 0) + 1 FROM recruitment_user ru", nativeQuery = true)
    Long getMaxId();
    Optional<RecruitmentUserEntity> findFirstByEmail(String email);
    Optional<RecruitmentUserEntity> findFirstByAadhar(String aadhar);
    Optional<RecruitmentUserEntity> findFirstByMobile(String mobile);

    Optional<RecruitmentUserEntity> findByUserId(String userId);

}
