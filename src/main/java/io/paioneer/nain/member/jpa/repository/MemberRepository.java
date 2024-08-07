package io.paioneer.nain.member.jpa.repository;

import io.paioneer.nain.member.jpa.entity.MemberEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface MemberRepository extends JpaRepository<MemberEntity, Long>, MemberRepositoryCustom {


    Optional<MemberEntity> findByMemberEmailAndLoginType(String MemberEmail, String loginType);

    Optional<MemberEntity> findByMemberNo(Long memberNo);

    List<MemberEntity> findByMemberNameContaining(String MemberName);

    List<MemberEntity> findByMemberEmailIn(List<String> admin);

    Optional<MemberEntity> findByMemberEmail(String userEmail);
}
