package io.paioneer.nain.resume.jpa.repository;

import io.paioneer.nain.resume.jpa.entity.ExperienceEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExperienceRepository extends JpaRepository<ExperienceEntity, Long> {
    List<ExperienceEntity> findByResumeNo(Long resumeNo);
}
