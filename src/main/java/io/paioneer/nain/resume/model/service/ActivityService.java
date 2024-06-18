package io.paioneer.nain.resume.model.service;


import io.paioneer.nain.resume.jpa.entity.ActivityEntity;
import io.paioneer.nain.resume.jpa.entity.EducationEntity;
import io.paioneer.nain.resume.jpa.repository.ActivityRepository;
import io.paioneer.nain.resume.model.dto.ActivityDto;
import io.paioneer.nain.resume.model.dto.EducationDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ActivityService {
    private final ActivityRepository activityRepository;

    // 활동 조회
    public List<ActivityDto> getActivityByResumeNo(Long resumeNo) {
        return activityRepository.findByResumeNo(resumeNo).stream()
                .map(ActivityEntity::toDto)
                .collect(Collectors.toList());
    }

    // 활동 저장
    public ActivityDto createActivity(ActivityDto activityDto, Long resumeNo) {
        ActivityEntity activityEntity = activityDto.toEntity();
        activityEntity.setResumeNo(resumeNo);
        ActivityEntity savedEntity = activityRepository.save(activityEntity);
        return savedEntity.toDto();
    }

    // 활동 삭제
    public void deleteActivity(Long activityNo) {
        activityRepository.deleteById(activityNo);
    }
}
