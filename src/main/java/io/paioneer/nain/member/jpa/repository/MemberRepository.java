package io.paioneer.nain.member.jpa.repository;

import io.paioneer.nain.member.jpa.entity.MemberEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface MemberRepository extends JpaRepository<MemberEntity, UUID> {
    Optional<MemberEntity> findByMemberEmail(String MemberEmail);

    Optional<MemberEntity> findByMemberEmailAndLoginType(String MemberEmail, String loginType);

}
