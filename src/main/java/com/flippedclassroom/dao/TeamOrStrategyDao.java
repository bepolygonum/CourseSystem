package com.flippedclassroom.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * @author DELL
 */
@Repository
public interface TeamOrStrategyDao {
    void createTeamOrStrategy(@Param("0") int id, @Param("1") String strategyName, @Param("2") int strategyId);
    int selectTeamOrStrategyMaxId();
}
