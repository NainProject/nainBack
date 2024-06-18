package io.paioneer.nain.resume.controller;

import io.paioneer.nain.resume.model.dto.ResumeDto;
import io.paioneer.nain.resume.model.dto.SkillDto;
import io.paioneer.nain.resume.model.service.ResumeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/resume")
@RequiredArgsConstructor
public class ResumeController {
    private final ResumeService resumeService;

    @GetMapping("/member/{memberNo}")
    public ResponseEntity<List<ResumeDto>> getResumesByMemberNo(@PathVariable Long memberNo) {
        List<ResumeDto> resumes = resumeService.findResumesByMemberNo(memberNo);
        return ResponseEntity.ok(resumes);
    }

    @PostMapping("/create")
    public ResponseEntity<ResumeDto> createResume(@RequestBody ResumeDto resumeDto) {
        resumeDto.setMemberNo(1L);  // 임시로 memberNo 값을 1로 설정
        ResumeDto createdResume = resumeService.createResume(resumeDto);
        return ResponseEntity.ok(createdResume);
    }
}
