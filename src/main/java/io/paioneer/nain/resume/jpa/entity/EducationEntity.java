package io.paioneer.nain.resume.jpa.entity;

import io.paioneer.nain.member.jpa.entity.MemberEntity;
import io.paioneer.nain.resume.model.dto.EducationDto;
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
@Table(name = "TB_EDUCATION")
public class EducationEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "education_no_seq")
    @SequenceGenerator(name = "education_no_seq", sequenceName = "EDUCATION_NO_SEQ", allocationSize = 1)
    @Column(name = "EDUCATION_NO", nullable = false)
    private Long educationNo;  // 학력 번호

    @Column(name = "RESUME_NO", nullable = false)
    private Long resumeNo;  // 이력서 번호

    @Column(name = "EDUCATION_CURRENT", nullable = false)
    private String current;  // 재학 여부

    @Column(name = "MAJOR", nullable = false)
    private String major;  // 전공

    @Column(name = "DEGREE", nullable = false)
    private String degree;  // 학위

    @Column(name = "SCORE")
    private Float score;  // 학점

    @Column(name = "START_DATE", nullable = false)
    private Date startDate;  // 입학일

    @Column(name = "END_DATE")
    private Date endDate;  // 졸업일

    public EducationDto toDto() {
        return EducationDto.builder()
                .educationNo(this.educationNo)
                .resumeNo(this.resumeNo)
                .current(this.current)
                .major(this.major)
                .degree(this.degree)
                .score(this.score)
                .startDate(this.startDate)
                .endDate(this.endDate)
                .build();
    }
}
