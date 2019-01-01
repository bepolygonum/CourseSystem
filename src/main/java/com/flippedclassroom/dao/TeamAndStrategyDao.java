package com.flippedclassroom.dao;

import org.apache.ibatis.annotations.Param;

/**
 * @author DELL
 */
public interface TeamAndStrategyDao {
    /**
     * createTeamAndStrategy
     * @param id
     * @param strategyName
     * @param strategyId
     */
    void createTeamAndStrategy(@Param("0") int id,@Param("1") String strategyName,@Param("2") int strategyId);

    /**
     * selectTeamAndStrategyMaxId
     * @return
     */
    int selectTeamAndStrategyMaxId();
}
