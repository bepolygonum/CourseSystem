package com.flippedclassroom.dao;

import com.flippedclassroom.entity.TeamAndStrategy;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author DELL
 */
@Repository
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

    List<TeamAndStrategy> getTeamAndStrategyById(@Param("0") int strategyId);
}
