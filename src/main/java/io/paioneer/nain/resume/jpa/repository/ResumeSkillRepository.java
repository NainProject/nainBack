package io.paioneer.nain.resume.jpa.repository;

import io.paioneer.nain.resume.jpa.entity.ResumeSkillEntity;
import io.paioneer.nain.resume.jpa.entity.ResumeSkillId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ResumeSkillRepository extends JpaRepository<ResumeSkillEntity, ResumeSkillId> {
}
