package io.paioneer.nain.resume.jpa.entity;

import io.paioneer.nain.resume.model.dto.SkillDto;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "TB_SKILL")
public class SkillEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SKILL_ID", nullable = false)
    private Long skillId;

    @Column(name = "SKILL_NAME", nullable = false)
    private String skillName;

    public SkillDto toDto() {
        return SkillDto.builder()
                .skillId(this.skillId)
                .skillName(this.skillName)
                .build();
    }
}
