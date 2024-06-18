package io.paioneer.nain.resume.model.service;

import io.paioneer.nain.resume.jpa.entity.EducationEntity;
import io.paioneer.nain.resume.jpa.repository.EducationRepository;
import io.paioneer.nain.resume.model.dto.EducationDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class EducationService {
    private final EducationRepository educationRepository;

    // 학력 조회
    public List<EducationDto> getEducationByResumeNo(Long resumeNo) {
        return educationRepository.findByResumeNo(resumeNo).stream()
                .map(EducationEntity::toDto)
                .collect(Collectors.toList());
    }

    // 학력 저장
    public EducationDto createEducation(EducationDto educationDto, Long resumeNo) {
        EducationEntity educationEntity = educationDto.toEntity();
        educationEntity.setResumeNo(resumeNo);
        EducationEntity savedEntity = educationRepository.save(educationEntity);
        return savedEntity.toDto();
    }

    // 학력 삭제
    public void deleteEducation(Long educationNo) {
        educationRepository.deleteById(educationNo);
    }
}
