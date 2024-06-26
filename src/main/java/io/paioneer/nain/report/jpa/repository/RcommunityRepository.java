package io.paioneer.nain.report.jpa.repository;

import io.paioneer.nain.report.jpa.entity.RcommunityEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RcommunityRepository extends JpaRepository<RcommunityEntity, Long>, RcommunityRepositoryCustom {

}
