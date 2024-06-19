package resume.jpa.repository;

import io.paioneer.nain.resume.jpa.entity.ResumeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ResumeRepository extends JpaRepository<ResumeEntity, Long>, ResumeRepositoryCustom {
    List<ResumeEntity> findByMemberNo(Long memberNo);
}
