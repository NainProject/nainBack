package io.paioneer.nain.resume.model.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.paioneer.nain.resume.jpa.entity.EducationEntity;
import io.paioneer.nain.resume.jpa.entity.ResumeEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Date;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class EducationDto {
    private Long educationNo;
    private Long resumeNo;
    private String current;
    private String major;
    private String degree;
    private Float score;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM")
    private Date startDate;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM")
    private Date endDate;

    public EducationEntity toEntity() {
        return EducationEntity.builder()
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
