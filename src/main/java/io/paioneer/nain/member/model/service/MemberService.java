package io.paioneer.nain.member.model.service;

import io.paioneer.nain.member.jpa.entity.MemberEntity;
import io.paioneer.nain.member.jpa.repository.MemberRepository;
import io.paioneer.nain.member.model.dto.MemberDto;
import io.paioneer.nain.member.model.input.InputMember;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Date;
import java.util.Optional;
import java.util.UUID;


@Slf4j
@Service
public class MemberService {

    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final MemberRepository memberRepository;

    public MemberService(BCryptPasswordEncoder bCryptPasswordEncoder, MemberRepository memberRepository) {
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
        this.memberRepository = memberRepository;
    }

    @Transactional
    public MemberEntity signUpMember(MemberEntity memberEntity) {
        memberRepository.findByMemberEmail(memberEntity.getMemberEmail())
                .ifPresent(u -> {
                    throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "이메일이 이미 사용중입니다.");
                });
        return memberRepository.save(createMember(memberEntity));
    }

    @Transactional
    public MemberEntity createMember(MemberEntity memberEntity) {
        String encodedPassword = bCryptPasswordEncoder.encode(memberEntity.getMemberPwd());
        return MemberEntity.builder()
                .memberNo(memberEntity.getMemberNo())
                .memberEmail(memberEntity.getMemberEmail())
                .memberPwd(encodedPassword)
                .memberName(memberEntity.getMemberName())
                .memberNickName(memberEntity.getMemberName())
                .loginType(memberEntity.getLoginType() != null ? memberEntity.getLoginType() : "local")
                .admin(false)
                .build();
    }

    @Transactional
    public Optional<MemberEntity> findByMemberEmail(String username){
        return memberRepository.findByMemberEmail(username);
    }

    @Transactional
    public MemberDto findById(Long memberNo) {
        return memberRepository.findByMemberNo(memberNo).get().toDto();
    }



    @Transactional
    public void updateMemberInfo(Long memberNo, MemberDto memberDto) {
        log.info("Updating member info: " + memberDto);
        MemberDto member = memberRepository.findById(memberNo).get().toDto();
        member.setMemberPwd(memberDto.getMemberPwd());
        member.setMemberName(memberDto.getMemberName());
        member.setMemberNickName(memberDto.getMemberNickName());
        memberRepository.save(member.toEntity());
    }


    @Transactional
    public boolean checkEmail(String email) {
        return memberRepository.findByMemberEmail(email).isPresent();
    }

    @Transactional
    public int emailCount(String memberEmail) {
        return (int)memberRepository.emailCount(memberEmail);
    }
}








