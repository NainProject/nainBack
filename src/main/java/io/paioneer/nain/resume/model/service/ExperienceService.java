package io.paioneer.nain.resume.model.service;

import io.paioneer.nain.resume.jpa.entity.ExperienceEntity;
import io.paioneer.nain.resume.jpa.repository.ExperienceRepository;
import io.paioneer.nain.resume.model.dto.ExperienceDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ExperienceService {
    private final ExperienceRepository experienceRepository;

    // 경력 저장
    public ExperienceDto createExperience(ExperienceDto experienceDto, Long resumeNo) {
        ExperienceEntity experienceEntity = experienceDto.toEntity(); //experienceDto 를 experienceEntity 객체로 변환
        experienceEntity.setResumeNo(resumeNo); // 전달 받은 resumeNo 를 experienceEntity에 설정
        experienceEntity.setExDuration(calculateDuration(experienceEntity.getStartDate(), experienceEntity.getEndDate())); // 근무 기간 계산 후 experienceEntity에 설정
        ExperienceEntity savedEntity = experienceRepository.save(experienceEntity); // experienceRepository.save 메소드로 experienceEntity를 데이터베이서에 저장
        return savedEntity.toDto(); //저장된 experienceEntity를 experienceDto로 변환하여 반환
    }

    // 근무 기간 계산
    private String calculateDuration(Date startDate, Date endDate) {
        if (startDate == null || endDate == null) {
            return "";
        }
        long months = ChronoUnit.MONTHS.between(
                startDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate(),
                endDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate()
        );
        return Long.toString(months);
    }

    // 경력 조회
    public List<ExperienceDto> getExperiencesByResumeNo(Long resumeNo) {
        return experienceRepository.findByResumeNo(resumeNo).stream()
                .map(ExperienceEntity::toDto)
                .collect(Collectors.toList());
    }

    // 경력 삭제
    public void deleteExperience(Long experienceNo) {
        experienceRepository.deleteById(experienceNo);
    }
}
