package io.paioneer.nain.resume.model.service;

import io.paioneer.nain.resume.jpa.entity.ExperienceEntity;
import io.paioneer.nain.resume.jpa.entity.ResumeEntity;
import io.paioneer.nain.resume.jpa.repository.ExperienceRepository;
import io.paioneer.nain.resume.jpa.repository.ResumeRepository;
import io.paioneer.nain.resume.jpa.repository.SkillRepository;
import io.paioneer.nain.resume.model.dto.ExperienceDto;
import io.paioneer.nain.resume.model.dto.ResumeDto;
import io.paioneer.nain.resume.model.dto.SkillDto;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ResumeService {
    private final ResumeRepository resumeRepository;
    private final SkillRepository skillRepository;

    public List<ResumeDto> findResumesByMemberNo(Long memberNo) {
        return resumeRepository.findByMemberNo(memberNo).stream()
                .map(ResumeEntity::toDto)
                .collect(Collectors.toList());
    }

    public ResumeDto createResume(ResumeDto resumeDto) {
        resumeDto.setMemberNo(1L);  // 임시로 memberNo 값을 1로 설정
        ResumeEntity resumeEntity = resumeDto.toEntity();
        ResumeEntity savedResume = resumeRepository.save(resumeEntity);
        return savedResume.toDto();
    }
}