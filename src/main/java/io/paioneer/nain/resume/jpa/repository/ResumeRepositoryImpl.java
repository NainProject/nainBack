package io.paioneer.nain.resume.jpa.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;
import io.paioneer.nain.resume.jpa.entity.QResumeEntity;
import io.paioneer.nain.resume.jpa.entity.ResumeEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class ResumeRepositoryImpl implements ResumeRepositoryCustom {
    private final JPAQueryFactory queryFactory;
    private final QResumeEntity resumeEntity = QResumeEntity.resumeEntity;

    @Override
    public List<ResumeEntity> findResumesByMemberNo(Long memberNo) {
        // 임시 값 설정 (memberNo 파라미터값 전달 가능 시 주석 예정)
        if (memberNo == null) {
            memberNo = 1L;
        }

        return queryFactory
                .selectFrom(resumeEntity)
                .where(resumeEntity.memberNo.eq(memberNo))
                .fetch();
    }
}
