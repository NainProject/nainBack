package io.paioneer.nain.resume.jpa.entity;

import io.paioneer.nain.resume.model.dto.ResumeDto;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Builder
@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "TB_RESUME")
public class ResumeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "resume_no_seq")
    @SequenceGenerator(name = "resume_no_seq", sequenceName = "RESUME_NO_SEQ", allocationSize = 1)
    @Column(name="RESUME_NO", nullable = false)
    private Long resumeNo;  // 이력서 번호

    @Column(name="MEMBER_NO", nullable = false)
    private Long memberNo;  // 회원 번호

    @Column(name="TITLE", nullable = false)
    private String title;  // 이력서 제목

    @Column(name="RESUME_NAME", nullable = false)
    private String resumeName;  // 이름

    @Column(name="EMAIL", nullable = false)
    private String email;  // 이메일

    @Column(name="PHONE", nullable = false)
    private String phone;  // 전화번호

    @Column(name="BOOKMARKED", nullable = false)
    private String bookMarked;  // 스크랩 여부

    @Column(name="JOB_CATEGORY", nullable = false)
    private String jobCategory;  // 직무 카테고리

    @Column(name="CREATE_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDate;  // 이력서 생성일

    @Column(name="MODIFICATION_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date modificationDate;  // 이력서 수정일

    @Column(name="DELETE_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date deleteDate;  // 이력서 삭제일

    @Column(name="INTRODUCTION", nullable = false)
    private String introduction;  // 자기 소개서

    @OneToMany(mappedBy = "resumeEntity", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ResumeSkillEntity> resumeSkills;

    @PrePersist
    protected void onCreate() {
        this.createDate = new Date();
    }

    @PreUpdate
    protected void onUpdate() {
        this.modificationDate = new Date();
    }

    public ResumeDto toDto() {
        return ResumeDto.builder()
                .resumeNo(this.resumeNo)
                .memberNo(this.memberNo)
                .title(this.title)
                .resumeName(this.resumeName)
                .email(this.email)
                .phone(this.phone)
                .bookMarked(this.bookMarked)
                .jobCategory(this.jobCategory)
                .createDate(this.createDate)
                .modificationDate(this.modificationDate)
                .deleteDate(this.deleteDate)
                .introduction(this.introduction)
                .build();
    }
}
