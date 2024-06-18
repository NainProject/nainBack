package io.paioneer.nain.resume.jpa.repository;

import io.paioneer.nain.resume.jpa.entity.ResumeEntity;

import java.util.List;

public interface ResumeRepositoryCustom {
    List<ResumeEntity> findResumesByMemberNo(Long memberNo);
}
