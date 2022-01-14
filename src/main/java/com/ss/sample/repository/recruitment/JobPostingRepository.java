package com.ss.sample.repository.recruitment;

import com.ss.sample.entity.recruitment.JobPostingEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface JobPostingRepository extends CrudRepository<JobPostingEntity, Long> {

    @Query(value = "SELECT coalesce(max(rr.id), 0) + 1 FROM recruitment_job_post_master rr", nativeQuery = true)
    Long getMaxId();

    @Query(value = "select * from recruitment_job_post_master r where r.user_id = ?1", nativeQuery = true)
    List<JobPostingEntity> findAllByUserId(String userId);

    Optional<JobPostingEntity> findByJobId(String jobId);


    List<JobPostingEntity> findByIsActive(char isActive);
    List<JobPostingEntity> findByIsActiveAndLastDateToApplyGreaterThan(char isActive, LocalDate date);

}
