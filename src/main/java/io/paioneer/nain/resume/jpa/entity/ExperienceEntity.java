package io.paioneer.nain.resume.jpa.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.paioneer.nain.member.jpa.entity.MemberEntity;
import io.paioneer.nain.resume.model.dto.ExperienceDto;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Builder
@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "TB_EXPERIENCE")
public class ExperienceEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "experience_no_seq")
    @SequenceGenerator(name = "experience_no_seq", sequenceName = "EXPERIENCE_NO_SEQ", allocationSize = 1)
    @Column(name="EXPERIENCE_NO", nullable = false)
    private Long experienceNo;  // 경력 번호

    @Column(name="RESUME_NO", nullable = false)
    private Long resumeNo;  // 이력서 번호

    @Column(name="COM_NAME", nullable = false)
    private String company;  // 회사명

    @Column(name="DEPARTMENT", nullable = false)
    private String department;  // 부서명

    @Column(name="EX_POSITION", nullable = false)
    private String exPosition;  // 직책

    @Column(name="START_DATE", nullable = false)
    private Date startDate;  // 시작일

    @Column(name="END_DATE")
    private Date endDate;  // 종료일

    @Column(name="EX_CURRENT", nullable = false)
    private String current;  // 현재 근무 여부

    @Column(name="RESPONSIBILITIES")
    private String responsibilities;  // 담당 업무 및 주요 성과

    @Column(name="EX_DURATION", nullable = false)
    private String exDuration;  // 근무 기간

    public ExperienceDto toDto() {
        return ExperienceDto.builder()
                .experienceNo(this.experienceNo)
                .resumeNo(this.resumeNo)
                .company(this.company)
                .department(this.department)
                .exPosition(this.exPosition)
                .startDate(this.startDate)
                .endDate(this.endDate)
                .current(this.current)
                .responsibilities(this.responsibilities)
                .exDuration(this.exDuration)
                .build();
    }
}