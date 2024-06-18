package io.paioneer.nain.resume.jpa.entity;

import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Embeddable
public class ResumeSkillId implements Serializable {

    private Long resumeNo;
    private Long skillId;

    // Default constructor, equals, and hashCode methods
}
