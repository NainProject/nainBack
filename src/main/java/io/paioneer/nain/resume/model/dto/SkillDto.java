package io.paioneer.nain.resume.model.dto;

import io.paioneer.nain.resume.jpa.entity.SkillEntity;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@Component
public class SkillDto {
    private Long skillId;
    private String skillName;

    public SkillEntity toEntity() {
        return SkillEntity.builder()
                .skillId(this.skillId)
                .skillName(this.skillName)
                .build();
    }
}
