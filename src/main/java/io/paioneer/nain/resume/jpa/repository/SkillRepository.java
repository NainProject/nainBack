package io.paioneer.nain.resume.jpa.repository;

import io.paioneer.nain.resume.jpa.entity.SkillEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SkillRepository extends JpaRepository<SkillEntity, Long> {
}
