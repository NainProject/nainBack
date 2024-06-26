package io.paioneer.nain.report.jpa.entity;

import io.paioneer.nain.common.TimeFormater;
import io.paioneer.nain.community.jpa.entity.CommentEntity;
import io.paioneer.nain.member.jpa.entity.MemberEntity;
import io.paioneer.nain.report.model.dto.RcommentDto;
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
@Table(name = "TB_COMMENT_REPORT")
public class RcommentEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_C_REPORT_NO")
    @SequenceGenerator(name = "SEQ_C_REPORT_NO", sequenceName = "SEQ_C_REPORT_NO", allocationSize = 1)
    @Column(name="C_REPORT_NO", nullable = false)
    private Long cReportNo;

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="MEMBER_NO", referencedColumnName = "MEMBER_NO")
    private MemberEntity memberEntity;

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="COMMENT_NO", referencedColumnName = "COMMENT_NO")
    private CommentEntity commentEntity;

    @Column(name="REPORT_TYPE", nullable=false)
    private String reportType;

    @Column(name="REPORT_DATE", nullable=false)
    private Date reportDate;

    @Column(name="HANDLED_YN")
    private String handledYN;

    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="ADMIN_NO", referencedColumnName = "MEMBER_NO")
    private MemberEntity adminEntity;

    @Column(name="HANDLED_DATE")
    private Date handledDate;


    public RcommentDto toDto(){
        return RcommentDto.builder()
                .cReportNo(this.cReportNo)
                .reporter(this.memberEntity.getMemberNickName())
                .commentNo(this.commentEntity.getCommentNo())
                .reportType(this.reportType)
                .reportDate(this.reportDate)
                .handledYN(this.handledYN)
                .admin(this.adminEntity.getMemberNickName())
                .handledDate(this.handledDate)
                .build();
    }
}
