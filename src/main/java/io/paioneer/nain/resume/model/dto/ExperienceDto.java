package io.paioneer.nain.resume.model.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.paioneer.nain.resume.jpa.entity.ExperienceEntity;
import io.paioneer.nain.resume.jpa.entity.ResumeEntity;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Date;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ExperienceDto {
    private Long experienceNo;
    private Long resumeNo;
    private String company;
    private String department;
    private String exPosition;  // 직책
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM")
    private Date startDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM")
    private Date endDate;
    private String current;
    private String responsibilities;
    private String exDuration;

    public ExperienceEntity toEntity() {
        return ExperienceEntity.builder()
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
