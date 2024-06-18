package io.paioneer.nain.resume.controller;

import io.paioneer.nain.resume.model.dto.ActivityDto;
import io.paioneer.nain.resume.model.service.ActivityService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/activity")
@RequiredArgsConstructor
public class ActivityController {
    private final ActivityService activityService;

    // 활동 조회
    @GetMapping("/resume/{resumeNo}")
    public ResponseEntity<List<ActivityDto>> getActivityByResumeNo(@PathVariable Long resumeNo) {
        List<ActivityDto> activity = activityService.getActivityByResumeNo(resumeNo);
        return ResponseEntity.ok(activity);
    }

    // 활동 저장
    @PostMapping("/resume/{resumeNo}/create")
    public ResponseEntity<ActivityDto> createActivity(@RequestBody ActivityDto activityDto, @PathVariable Long resumeNo) {
        log.info("resumeNo : " + resumeNo);
        ActivityDto createActivity = activityService.createActivity(activityDto, resumeNo);
        return ResponseEntity.ok(createActivity);
    }

    // 활동 삭제
    @DeleteMapping("/{activityNo}")
    public ResponseEntity<Void> deleteActivity(@PathVariable Long activityNo) {
        activityService.deleteActivity(activityNo);
        return ResponseEntity.noContent().build();
    }
}
