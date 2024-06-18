package io.paioneer.nain.resume.jpa.repository;

import io.paioneer.nain.resume.jpa.entity.EducationEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EducationRepository extends JpaRepository<EducationEntity, Long> {
    List<EducationEntity> findByResumeNo(Long resumeNo);
}
