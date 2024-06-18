package io.paioneer.nain.resume.jpa.repository;

import io.paioneer.nain.resume.jpa.entity.ActivityEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ActivityRepository extends JpaRepository<ActivityEntity, Long> {
    List<ActivityEntity> findByResumeNo(Long resumeNo);
}
