package com.flippedclassroom.dao;

import com.flippedclassroom.entity.TeamStrategy;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import java.util.List;


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

    List<TeamStrategy> getTeamStrategyByCourseId(@Param("0") int courseId);
}
