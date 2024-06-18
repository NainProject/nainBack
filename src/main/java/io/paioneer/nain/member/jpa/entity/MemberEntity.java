package io.paioneer.nain.member.jpa.entity;

import io.paioneer.nain.member.model.dto.MemberDto;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
@Table(name="TB_MEMBER")
@Entity //jpa 가 관리함, repository 와 연결됨
public class MemberEntity {

    @Id
    @Column(name="MEMBER_NO", nullable = false)
    private Long memberNo;            //회원 번호

    @Column(name="MEMBER_EMAIL", nullable = false, unique = true)
    private String memberEmail;         //회원 이메일, 아이디로 사용됨

    @Column(name="MEMBER_PWD", nullable = true)
    private String memberPwd;           //회원 비밀번호

    @Column(name="MEMBER_NAME", nullable = false)
    private String memberName;          //회원 이름

    @Column(name="MEMBER_NICKNAME")
    private String memberNickName;      //회원 닉네임

    @Column(name="SUBSCRIBE_YN")
    private String subscribeYN;         //회원 구독여부

    @Column(name="ADMIN")
    private Boolean admin;               //관리자

    @Column(name="PAYMENT_DATE")
    private LocalDateTime paymentDate;           //회원 결제일

    @Column(name="EXPIRE_DATE")
    private LocalDateTime expireDate;            //회원 구독만료일

    @Column(name="SIGNUP_DATE")
    private LocalDateTime signUpDate;            //회원 가입일

    @Column(name="WITHDRAWAL_DATE")
    private LocalDateTime withDrawalDate;        //회원 탈퇴일

    @Column(name="MEMBER_UPDATE")
    private LocalDateTime memberUpdate;          //회원 정보수정일

    @Column(name="LOGIN_TYPE", nullable = false, columnDefinition = "VARCHAR2(50) DEFAULT 'local'")
    private String loginType;

    @Column(name="SNS_ACCESS_TOKEN", nullable = true)
    private String snsAccessToken;

    public MemberEntity(long l) {
    }

    public MemberDto toDto() {
        return MemberDto.builder()
                .memberNo(this.memberNo)
                .memberEmail(this.memberEmail)
                .memberPwd(this.memberPwd)
                .memberName(this.memberName)
                .memberNickName(this.memberNickName)
                .subscribeYN(this.subscribeYN)
                .admin(this.admin)
                .paymentDate(this.paymentDate)
                .expireDate(this.expireDate)
                .signUpDate(this.signUpDate)
                .withDrawalDate(this.withDrawalDate)
                .memberUpdate(this.memberUpdate)
                .build();

    }

}
