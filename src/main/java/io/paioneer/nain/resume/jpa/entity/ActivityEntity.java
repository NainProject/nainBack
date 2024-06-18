package io.paioneer.nain.resume.jpa.entity;

import io.paioneer.nain.resume.model.dto.ActivityDto;
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
@Table(name = "TB_ACTIVITY")
public class ActivityEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "activity_no_seq")
    @SequenceGenerator(name = "activity_no_seq", sequenceName = "ACTIVITY_NO_SEQ", allocationSize = 1)
    @Column(name="ACTIVITY_NO", nullable = false)
    private Long activityNo; // 활동 번호

    @Column(name = "RESUME_NO", nullable = false)
    private Long resumeNo;  // 이력서 번호

    @Column(name="ACTIVITY_NAME", nullable = false)
    private String activityName; // 활동명

    @Column(name="ACTIVITY_DESCRIPTION", nullable = false)
    private String activityDescription; //활동 내용

    @Column(name="ORGANIZER", nullable = false)
    private String organizer; // 주최기관

    @Column(name="START_DATE", nullable = false)
    private Date startDate; // 시작일

    @Column(name="END_DATE")
    private Date endDate; // 종료일

    public ActivityDto toDto() {
        return ActivityDto.builder()
                .activityNo(this.activityNo)
                .resumeNo(this.resumeNo)
                .activityName(this.activityName)
                .activityDescription(this.activityDescription)
                .organizer(this.organizer)
                .startDate(this.startDate)
                .endDate(this.endDate)
                .build();
    }
}
