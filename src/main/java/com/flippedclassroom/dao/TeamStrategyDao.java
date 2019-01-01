package com.flippedclassroom.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;


/**
 * @author DELL
 */
@Repository
public interface TeamStrategyDao {
    /**
     * createTeamStrategy
     * @param courseId
     * @param strategySerial
     * @param strategyName
     * @param strategyId
     */
    void createTeamStrategy(@Param("0") int courseId,@Param("1") int strategySerial,@Param("2") String strategyName,@Param("3") int strategyId);
}
