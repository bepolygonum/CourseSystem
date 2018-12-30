package com.flippedclassroom.dao;

import org.apache.ibatis.annotations.Param;

/**
 * @author DELL
 */
public interface TeamOrStrategyDao {
    void createTeamOrStrategy(@Param("0") int id, @Param("1") String strategyName, @Param("2") int strategyId);
    int selectTeamOrStrategyMaxId();
}
