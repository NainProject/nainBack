package io.paioneer.nain.resume.jpa.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "TB_RESUME_SKILL")
public class ResumeSkillEntity {

    @EmbeddedId
    private ResumeSkillId id;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("resumeNo")
    private ResumeEntity resumeEntity;

    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("skillId")
    private SkillEntity skillEntity;

    // Constructors, getters, and setters
}
